MOD_NAME = g_hid
obj-m := $(MOD_NAME).o
hidgmod-y := src/$(MOD_NAME)_main.o
ccflags-y := -Iinclude
CFLAGS += -I`pwd`/include
DEBUG_CFLAGS += $(CFLAGS) -g -DDEBUG

all:
	make -C /lib/modules/$(shell uname -r)/build M=`pwd` modules EXTRA_CFLAGS="$(CFLAGS)"

debug:
	make -C /lib/modules/$(shell uname -r)/build M=`pwd` modules EXTRA_CFLAGS="$(DEBUG_CFLAGS)"

test: debug
	sudo insmod $(MOD_NAME).ko
	read REPLY
	sudo rmmod $(MOD_NAME)

clean:
	make -C /lib/modules/$(shell uname -r)/build M=`pwd` clean
