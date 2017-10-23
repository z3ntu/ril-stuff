NAME = libprotobuf-c-nano
SOURCES = pb_decode.c \
	  pb_encode.c
#SOURCES := $(foreach source, $(SOURCES), $(source))
CPPFLAGS += -Iinclude -Idebian/include -Dchar16_t=uint16_t -fPIC
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lpthread -L/usr/lib/android -L. -llog

build: $(SOURCES)
	$(CC) -c pb_decode.c -o pb_decode.o $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	$(CC) -c pb_encode.c -o pb_encode.o $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	$(AR) rcs $(NAME).a pb_decode.o pb_encode.o

clean:
	$(RM) $(NAME).a
