NAME = libril
SOURCES = RilSapSocket.cpp \
	  RilSocket.cpp \
	  ril.cpp \
	  ril_event.cpp
SOURCES := $(foreach source, $(SOURCES), libril/$(source))
CPPFLAGS += -Iinclude -I.. -Ilibril -I/usr/include/android -Dchar16_t=uint16_t -fPIC
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/android -lpthread -L/usr/lib/android -L. -llog

build: $(SOURCES)
	$(CC) $^ -o $(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so

clean:
	$(RM) $(NAME).so*
