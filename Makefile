CFLAGS  = -std=gnu99 -fPIC -O0 -ggdb3 -Wall -Wextra -fvisibility=hidden
CPPFLAGS= -Iinclude $(shell pkg-config --cflags libffi)
UNAME   = $(shell uname -s)
LDLIBS  = $(shell pkg-config --libs libffi)
PREFIX	= /usr/local

ifeq ($(UNAME), Linux)
	LDLIBS += -ldl
endif

.PHONY: clean install

all: ctypes.so ctypes.sh

ctypes.so: ctypes.o util.o callback.o types.o unpack.o
	$(CC) $(LDFLAGS) $(CFLAGS) -shared -o $@ $^ $(LDLIBS)

clean:
	rm -f ctypes.so *.o

install: ctypes.so ctypes.sh
	install ctypes.sh $(PREFIX)/bin
	install ctypes.so $(PREFIX)/lib
