/* [KSC4]-------------------------------------------------------------------[]
 *
 *  UT60E.C - Gets readings from the UT-60E digital multimeter over RS232C
 *            Version 1.1 written by 
 *            Marco "Kiko" Carnut <kiko@tempest.com.br>
 *
 *  Description: This program continuously reads a serial port specified in
 *  ------------ the command line and translates the data coming from the
 *  UT60E (aka Minipa ET-2210 here in Brazil) to human readable form. In 
 *  other words, it shows in the computer exactly the same that appears in
 *  the device's display.
 * 
 *  It also also options to make it suitable for automated datalogging, such
 *  as adding timestamps, averaging blocks of measurements, scaling the data
 *  and formatting the output. It can decode not only the numeric data but
 *  many of the multimeter's mode/status and unit indicators as well.
 *
 *  Licensing: This program is free software released under the GNU General
 *  ---------- Public License Version 2: http://www.gnu.org/copyleft/gpl.html
 *
 *  Portability: Tested under Cygwin 1.5.16 and Linux 2.4.29. Should work
 *  ------------ with any Unix-like system with /proc. Perhaps minor header/
 *  device name changes may be needed. 
 *
 *  Building: A "gcc -o ut60e ut60e.c" should be enough.
 *  ---------
 *
 *  Warning: The UT60e is hooked up to the serial port via a cable with an
 *  -------- optocoupler. This is a good thing -- it electrically isolates
 *  your computer from the meter, so any potentially harmful high voltages
 *  from the latter will not pass to the former. However, the optocoupler
 *  draws its current from TX and DTR signals, so two or three-wire serial
 *  hookups will not work unless you provide external power. The ordinary PC
 *  serial port works fine as long as your operating system raises DTR
 *  properly. (I ran into such a problem when using this program with Linux on
 *  an ARM-based Ipaq 3650).
 *
 *  Changelog: 2007-jun-01: added missing [LOW BATT] flag (thanks to William
 *  ---------- Keller <willvolt at gmail dot com> for pointing this out).
 *  Added code to properly raise the DTR and RTS signals so it works with more
 *  serial port drivers. Other minor cosmetic changes.
 *
 * []-----------------------------------------------------------------------[]
 */

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
        
#define BAUDRATE B2400
#define FALSE 0
#define TRUE 1

/* --------------------------- Macro-declared Constants ------------------- */

#define DEVICE "/dev/ttyS0"

#define MAXLINELENGTH 80

/* ---------------------- Declarations and Global Variables --------------- */

char []={ 0x7D, 0x05, 0x5B, 0x1F, 0x27, 0x3E, 0x7E, 0x15, 0x7F, 0x3F, 0 };
int sample[16];
char regs[80],val[80],units[80],other[80];
int numonly;
int nsamples=-1;
int showregs;
int raw=0;
int nacc=0;
int curr;
int timestamp;
int busy0,idle0;
int show_cpu_stats;
float accum;
char *device=DEVICE;
char fmt[26]="%7.3f";
float mpy=1;

/* ---------------------------- Function Prototypes ----------------------- */

void process_sample(void);
void print_timestamp(void);
int  getcpu(int *busy, int *nice);
void usage(void);

/* ------------------------------- Main Program --------------------------- */

main(int argc, char **argv)
{
    int fd,c, res,flags,n,a, has_first;
    struct termios oldtio,newtio;
    char buf[255];

    if (argc==1) {
        fprintf(stderr,"Using default options. ");
        fprintf(stderr,"For help/usage, rerun with -h\n");
    }

    for (a=0,n=1;n<argc;n++) {
        if (argv[n][0]=='-') {
            switch(argv[n][1]) {
                case 'n': numonly=TRUE;
                break;
                case 'r': showregs=TRUE;
                break;
                case 'R': raw=TRUE;
                break;
                case 'a': if (argv[n][2]>='0' && argv[n][2]<='9') {
                             nacc=atoi(argv[n]+2);
                          } else {
                             nacc=atoi(argv[++n]);
                          }
                          if (nacc<1) nacc=0;
                          break;
                case 't': timestamp=TRUE;
                          break;
                case 'm': if (argv[n][2]>='0' && argv[n][2]<='9') {
                             sscanf(argv[n]+2,"%f",&mpy);
                          } else {
                             sscanf(argv[++n],"%f",&mpy);
                          }
                          /* printf("mpy=%f\n",mpy); */
                          break;
                case 'f': if (argv[n][2]!=0) {
                              strncpy(fmt,argv[n]+2,25);
                          } else {
                              strncpy(fmt,argv[++n],25);
                          }
                          fmt[25]=0;
                          break;
                case 'c': show_cpu_stats=TRUE;
                          break;
                case 'h': usage(); exit(0);
            }
        } else {
            switch(a) {
                case 0: device=argv[n];
                        break;
                case 1: nsamples=atoi(argv[n]);
                        break;
            }
            a++;
        }
    }
        
    fd = open(device, O_RDWR | O_NOCTTY ); 
    if (fd <0) {
        fprintf(stderr,"Can't open %s\n",device); 
        exit(1);
    }
        
    tcgetattr(fd,&oldtio); /* save current port settings */
        
    bzero(&newtio, sizeof(newtio));
    newtio.c_cflag = BAUDRATE | CS8 | CLOCAL | CREAD | CRTSCTS;
    newtio.c_iflag = IGNPAR;
    newtio.c_oflag = 0;
        
    cfsetospeed(&newtio,B2400);
    cfsetispeed(&newtio,B2400);

     /* set input mode (non-canonical, no echo,...) */
     newtio.c_lflag = 0;
         
     newtio.c_cc[VTIME]=0;
     newtio.c_cc[VMIN] =1;   
        
     tcflush(fd, TCIFLUSH);
     tcsetattr(fd,TCSANOW,&newtio);

     int status;
     ioctl(fd, TIOCMGET, &status);
     status |= TIOCM_DTR | TIOCM_RTS;
     ioctl(fd, TIOCMSET, &status);

     has_first=FALSE;
     accum=0.0; curr=nacc;
     getcpu(&busy0,&idle0);
     for (;;) {      
         res = read(fd,buf,255);
         buf[res]=0;
         if (raw) printf("%3d:",res);
         for (n=0;n<res;n++) {
             int slot=(buf[n]&0xF0)>>4;
             sample[slot]=buf[n]&0xF;
             if (raw) printf("%02X ",buf[n]&0xFF);
             if (slot==1) has_first=TRUE;
             if (slot==14 && has_first) {
                 process_sample();
                 if (showregs) printf("%s",regs);
                 if (nacc>0) {
                     if (curr--) {
                         float v;
                         sscanf(val,"%f",&v);
                         accum+=v;
                         /* printf(": %7.3f | %s\n",v,val); */
                     } else {
                         if (timestamp) print_timestamp();
                         printf(fmt,accum/nacc*mpy);
                         accum=0.0; curr=nacc;
                         if (!numonly) printf(" %s%s",units,other);
                         if (show_cpu_stats) {
                             float pc;
                             int busy1,idle1;
                             if (getcpu(&busy1,&idle1)) {
                                 pc=(busy1-busy0)*100.0/(idle1-idle0);
                                 if (pc<0 || pc>100) pc=0;
                                 printf(" %5.1f%%",pc);
                                 busy0=busy1; idle0=idle1;
                             }
                         }
                         printf("\n");
                     }
                 } else {
                     if (timestamp) print_timestamp();
                     printf("%s",val);
                     if (!numonly) printf(" %s%s",units,other);
                     if (show_cpu_stats) {
                         float pc;
                         int busy1,idle1;
                         getcpu(&busy1,&idle1);
                         pc=(busy1-busy0)*100.0/(idle1-idle0);
                         if (pc<0 || pc>100) pc=0;
                         printf(" %5.1f%%",pc);
                         busy0=busy1; idle0=idle1;
                     }
                     printf("\n");
                 }
                 fflush(stdout);
                 if (nsamples>0) {
                     nsamples--; if (!nsamples) exit(0);
                 }
             }
         }
     }
     tcsetattr(fd,TCSANOW,&oldtio);
} /* main */
    
/* ---------------------------- Auxiliary Functions ----------------------- */

void process_sample(void)
{
   int n,s;
   char *p=val,*q;
   regs[0]=0;
   if (showregs) {
       sprintf(regs,": ");
       for (n=0;n<16;n++) {
           sprintf(regs,"%s%02X ",regs,sample[n]);
       }
       sprintf(regs,"%s: ",regs);
   }
   for (n=2;n<10;n+=2) {
       if (sample[n]&8) 
           *p++=(n==2)?'-':'.';
       else if (n==2) *p++=' ';
       s=((sample[n]&7)<<4)|(sample[n+1]);
       if (showregs) sprintf(regs,"%s%02X ",regs,s);
       q=strchr(nums,s);
       if (q && *q) 
           *p++='0'+(q-nums);
       else { 
           if (s==0x68) *p++='L';
           if (s==0) *p++=' ';
       }
   }
   if (showregs) sprintf(regs,"%s| ",regs);
   *p=0; p=units;
   if (sample[10]&4) *p++='n',*p++='F';
   if (sample[10]&8) *p++='u';
   if (sample[11]&8) *p++='m';
   if (sample[13]&8) *p++='A';
   if (sample[13]&4) *p++='V';
   if (sample[13]&2) *p++='H',*p++='z';
   else if (sample[14]&1) *p++='o',*p++='C';
   *p=0;
   if (sample[12]&4) {
      strcat(p," ");
      if (sample[11]&2) strcat(p,"M");
      if (sample[10]&2) strcat(p,"k");
      strcat(p,"Ohms");
   }
   p=other; *p=0;
   if (sample[1]&8) strcat(p," AC");
   if (sample[1]&2) strcat(p," [AUTO]");
   if (sample[12]&1) strcat(p," [HOLD]");
   if (sample[12]&2) strcat(p," [DELTA]");
   if (sample[10]&1) strcat(p," [DIODE]");
   if (sample[11]&4) strcat(p," [%]");
   if (sample[11]&1) strcat(p," [BEEP]");
   if (sample[13]&1) strcat(p," [LOW BATT]");
}

void print_timestamp(void)
{
    char str[81];
    time_t now=time(NULL);
    struct tm *t=localtime(&now);
    strftime(str,80,"%Y-%m-%d %H:%M:%S",t);
    printf("%s  ",str);
}

int getcpu(int *busy, int *idle)
{
    FILE *fp;
    char line[MAXLINELENGTH+1];
    if (!(fp=fopen("/proc/stat","r"))) return 0;
    for (;;) {
        fgets(line,MAXLINELENGTH,fp);
        line[MAXLINELENGTH]=0;
        if (!strncmp(line,"cpu ",4)) {
            int user,nice,sys;
            sscanf(line+4,"%ld %ld %ld %ld",&user,&nice,&sys,idle);
            *busy=user+nice+sys;
            fclose(fp); return 1;
        }
        if (feof(fp)) break;
    }
    *busy=0; *idle=0;
    return 1;
}

void usage(void)
{
    fprintf(stderr,"ut60e: Decode serial data from ");
    fprintf(stderr,"UT60E (aka Minipa ET-2210) digital multimeter.\n");
    fprintf(stderr,"Version 1.1 - By Marco \"Kiko\" Carnut ");
    fprintf(stderr,"<kiko /at/ postcogito /dot/ org>\n\n");
    fprintf(stderr,"Usage: ut60e [options] [<device>] [<nsamples>]\n\n");
    fprintf(stderr,"   device: where the multimeter is connected to");
    fprintf(stderr," (default: " DEVICE ")\n");
    fprintf(stderr," nsamples: stop after collecting that many samples\n\n");
    fprintf(stderr,"Options:\n\n");
    fprintf(stderr,"  -a <num> averages that many samples\n");
    fprintf(stderr,"  -c       show CPU usage as well\n");
    fprintf(stderr,"  -f <str> Use this format string when printing\n");
    fprintf(stderr,"  -h       this help text\n");
    fprintf(stderr,"  -m <num> multiply result by this number\n");
    fprintf(stderr,"  -n       num only, no units or indicators\n");
    fprintf(stderr,"  -R       (debug) show raw data read from serial\n");
    fprintf(stderr,"  -r       (debug) show frame decoding\n");
    fprintf(stderr,"  -t       show timestamps\n");
    fprintf(stderr,"\nOutput is flushed after every line so you won't ");
    fprintf(stderr,"lose recent data after SIGINT\n");

}
