CC ?= gcc # C compiler
CFLAGS ?= -D_GNU_SOURCE -fPIC -Wall -Wextra -Wno-error -O2 -g -I./ # C flags
LDFLAGS ?= -shared  # linking flags
RM ?= rm -f  # rm command
TARGET_LIB ?= libtls.so # target lib

SRCS=	tls.c \
	tls_bio_cb.c \
	tls_client.c \
	tls_config.c \
	tls_conninfo.c \
	tls_keypair.c \
	tls_peer.c \
	tls_server.c \
	tls_util.c \
	tls_ocsp.c \
	tls_verify.c
OBJS = $(SRCS:.c=.o)

.PHONY: all
all: ${TARGET_LIB}

$(TARGET_LIB): $(OBJS)
	$(CC) ${LDFLAGS} -o $@ $^

$(SRCS:.c=.d):%.d:%.c
	$(CC) $(CFLAGS) -MM $< >$@

include $(SRCS:.c=.d)

.PHONY: clean
clean:
	-${RM} ${TARGET_LIB} ${OBJS} $(SRCS:.c=.d)