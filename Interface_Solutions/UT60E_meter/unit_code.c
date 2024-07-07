/*
 * parse-ut60e.c -- parse Uni-T UT60E DMM output
 *
 * http://perfec.to/ut60e/
 *
 * Copyright (c) 2015, Daniel Lawrence. All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 * $Id$
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <sys/time.h>


static int fd;
static int debug = 0;
static int timestamp = 0;
static int flushline = 0;

static unsigned char buf[255];

/* the upper nibble is the segment number */
#define	SEGMENT_OF(n)	(((n) >> 4) & 0xf)

#define	FRAME_BYTES	14	/* 14 bytes in a frame */

#define	NIB_1_OFFSET	0
#define	NIB_1_RS232	0x1
#define NIB_1_AUTO	0x2
#define NIB_1_UNKNOWN	0x4
#define NIB_1_AC	0x8

#define	NIB_POINT	0x80	/* negative sign or decimal point */

#define DIG1_OFFSET	1
#define DIG2_OFFSET	3
#define	DIG3_OFFSET	5
#define	DIG4_OFFSET	7

#define	NIB_A_OFFSET	9
#define NIB_A_DIODE	0x1
#define NIB_A_KILO	0x2
#define NIB_A_NANO	0x4
#define	NIB_A_MICRO	0x8

#define	NIB_B_OFFSET	10
#define NIB_B_BEEP	0x1
#define NIB_B_MEGA	0x2
#define NIB_B_PERCENT	0x4
#define NIB_B_MILLI	0x8

#define	NIB_C_OFFSET	11
#define NIB_C_HOLD	0x1
#define NIB_C_DELTA	0x2
#define NIB_C_OHM	0x4
#define NIB_C_FARAD	0x8

#define	NIB_D_OFFSET	12
#define NIB_D_BATTERY	0x1
#define NIB_D_HERTZ	0x2
#define	NIB_D_VOLT	0x4
#define	NIB_D_AMP	0x8

#define	NIB_E_OFFSET	13
#define NIB_E_UNKNOWN	0xe
#define	NIB_E_CELCIUS	0x1


static void
usage(void)
{
	fprintf(stderr, "usage: parse-ut60e [-d] [-t] [-u] -f device\n");
	fprintf(stderr, "	-d	debug; show raw data from meter\n");
	fprintf(stderr, "	-t	timestamp each reading\n");
	fprintf(stderr, "	-u	force unbuffered stdout\n");
	fprintf(stderr, "	-f	serial line or input file\n");
	fprintf(stderr, "http://perfec.to/ut60e/\n");
	exit(1);
}


static int pushback = -1;
static int bufsize = 0;		/* # bytes read into buf[] */
static int bufptr = 0;		/* index of next byte to read from buf[] */

static void
ungetbyte(unsigned c)
{
	if (pushback != -1) {
		perror("ungetbyte: too many bytes pushed back");
		exit(1);
	}
	pushback = c;
}

static int
getbyte(void)
{
	int i;
	unsigned c;

	if (pushback != -1) {
		c = pushback;
		pushback = -1;
		return c;
	}
	if (bufptr == bufsize) {
		if ((bufsize = read(fd, buf, sizeof(buf))) == -1) {
			perror("read:");
			exit(1);
		}
		if (bufsize == 0)
			return -1;
		if (debug) {
			fputs("raw: ", stdout);
			for (i = 0; i < bufsize; ++i)
				printf("%02x ", buf[i]);
			putchar('\n');
		}
		bufptr = 0;
	}
	return buf[bufptr++];
}


static int
getframe(unsigned char *frame)
{
	int c;
	int i;

	for (;;) {
		/* look for sync byte */
		while ((c = getbyte()) != -1 && SEGMENT_OF(c) != 1)
			;
		if (c == -1)
			return 0;
		frame[0] = c;

		/* read the rest of the frame */
		/* segments are numbered starting from 1 */
		for (i = 1; i < FRAME_BYTES; ++i) {
			if ((c = getbyte()) == -1)
				return 0;
			if (SEGMENT_OF(c) != i+1) {
				ungetbyte(c);
				break;
			}
			frame[i] = c;
		}
		if (i == FRAME_BYTES)
			return 1;
	}
}


static void
digit(unsigned char *p, char symbol)
{
	unsigned char c;

	c = (p[0] << 4) | (p[1] & 0xf);
	if (c & NIB_POINT) {
		putchar(symbol);
		c &= ~NIB_POINT;
	}
	switch (c) {
	case 0x00: c = ' '; break;
	case 0x7d: c = '0'; break;
	case 0x05: c = '1'; break;
	case 0x5b: c = '2'; break;
	case 0x1f: c = '3'; break;
	case 0x27: c = '4'; break;
	case 0x3e: c = '5'; break;
	case 0x7e: c = '6'; break;
	case 0x15: c = '7'; break;
	case 0x7f: c = '8'; break;
	case 0x3f: c = '9'; break;
	case 0x68: c = 'L'; break;
	default: c = '?';
	}
	putchar(c);
}


static void
parse(unsigned char *buf)
{
	struct timeval t;
	struct timezone tz;

	if (timestamp) {
		if (gettimeofday(&t, &tz) == -1) {
			perror("gettimeofday:");
			exit(1);
		}
		printf("%ld.%06ld ", t.tv_sec, t.tv_usec);
	}

	digit(buf+DIG1_OFFSET, '-');
	digit(buf+DIG2_OFFSET, '.');
	digit(buf+DIG3_OFFSET, '.');
	digit(buf+DIG4_OFFSET, '.');

	putchar(' ');

	if (buf[NIB_A_OFFSET] & NIB_A_NANO)
		putchar('n');
	else if (buf[NIB_A_OFFSET] & NIB_A_MICRO)
		putchar('u');
	else if (buf[NIB_B_OFFSET] & NIB_B_MILLI)
		putchar('m');
	else if (buf[NIB_A_OFFSET] & NIB_A_KILO)
		putchar('k');
	else if (buf[NIB_B_OFFSET] & NIB_B_MEGA)
		putchar('M');

	if (buf[NIB_C_OFFSET] & NIB_C_FARAD)
		putchar('F');
	else if (buf[NIB_C_OFFSET] & NIB_C_OHM)
		fputs("Ohm", stdout);
	else if (buf[NIB_D_OFFSET] & NIB_D_AMP)
		putchar('A');
	else if (buf[NIB_D_OFFSET] & NIB_D_VOLT)
		putchar('V');
	else if (buf[NIB_D_OFFSET] & NIB_D_HERTZ)
		fputs("Hz", stdout);
	else if (buf[NIB_B_OFFSET] & NIB_B_PERCENT)
		putchar('%');
	else if (buf[NIB_E_OFFSET] & NIB_E_CELCIUS)
		putchar('C');

	if (buf[NIB_1_OFFSET] & NIB_1_AC)
		fputs(" AC", stdout);

	if (buf[NIB_C_OFFSET] & NIB_C_DELTA)
		fputs(" Rel", stdout);

	if (buf[NIB_C_OFFSET] & NIB_C_HOLD)
		fputs(" Hold", stdout);

	if (buf[NIB_D_OFFSET] & NIB_D_BATTERY)
		fputs(" LowBattery", stdout);

	if (buf[NIB_A_OFFSET] & NIB_A_DIODE)
		fputs(" Diode", stdout);

	if (buf[NIB_B_OFFSET] & NIB_B_BEEP)
		fputs(" Beep", stdout);

	putchar('\n');
	if (flushline)
		fflush(stdout);
}


int
main(int argc, char **argv)
{
 	struct termios t;
	int c;
	unsigned char frame[FRAME_BYTES];
	char *device = NULL;
	int state;

	while ((c = getopt(argc, argv, "df:tu")) != -1) {
		switch (c) {
		case 'd':
			debug = 1;
			break;
		case 'f':
			device = optarg;
			break;
		case 't':
			timestamp = 1;
			break;
		case 'u':
			flushline = 1;
			break;
		default:
			usage();
			break;
		}
	}
	if (device == NULL)
		usage();

	if ((fd = open(device, O_RDONLY)) == -1) {
		perror("open:");
		exit(1);
	}

	if (isatty(fd)) {
		if (tcgetattr(fd, &t) == -1) {
			perror("tcgetattr:");
			exit(1);
 		}

		cfsetspeed(&t, B2400);
		cfmakeraw(&t);
		t.c_iflag &= ~IGNPAR;	/* don't ignore parity/frame errors */
		t.c_iflag |= PARMRK;	/* mark parity/frame errors */
		t.c_iflag |= INPCK;	/* enable input parity/frame checking */
		t.c_cflag |= CREAD;	/* enable receiver */
		t.c_cflag |= CLOCAL;	/* ignore modem control lines */
		t.c_cflag &= ~CSIZE;	/* 8bit */
		t.c_cflag |= CS8;
		t.c_cflag &= ~PARENB;	/* disable parity */
		t.c_cflag &= ~CSTOPB;	/* one stop bit, not two */
		t.c_cc[VTIME] = 0;
		t.c_cc[VMIN] = FRAME_BYTES;

		if (tcsetattr(fd, TCSANOW, &t) == -1) {
			perror("tcsetattr:");
			exit(1);
 		}

		if (ioctl(fd, TIOCMGET, &state) == -1) {
			perror("ioctl:");
			exit(1);
 		}
		state &= ~TIOCM_RTS;	/* uts60e doesn't like RTS */
		if (ioctl(fd, TIOCMSET, &state) == -1) {
			perror("ioctl:");
			exit(1);
		}
		tcflush(fd, TCIFLUSH);
	}

	while (getframe(frame))
		parse(frame);
		;
	exit(0);
}