NAME = librilutils
SOURCES = librilutils.c \
	  record_stream.c
SOURCES := $(foreach source, $(SOURCES), librilutils/$(source))
CPPFLAGS += -Iinclude -Idebian/include -Dchar16_t=uint16_t -fPIC
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lpthread -L/usr/lib/android -L. -llog

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so
	protoc --proto_path=. --nanopb_out=. --plugin=/usr/bin/protoc-gen-nanopb librilutils/proto/sap-api.proto

clean:
	$(RM) $(NAME).so*
