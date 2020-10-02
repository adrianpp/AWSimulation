EXECUTABLE=AWSimulation

SQLITE_BUILD_DIR=sqlite/build

# sqlite3 first because the generated headers are a dependency for our application
SRCS=$(SQLITE_BUILD_DIR)/sqlite3.c ConsoleApplication1.cpp MasterBoard.cpp Minion.cpp
OBJS=$(subst .c,.o,$(subst .cpp,.o,$(SRCS)))

.PHONY: all clean distclean

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

# generate, and use dependency files (if available)
CPPFLAGS+= -MMD
-include $(OBJS:.o=.d)

$(SQLITE_BUILD_DIR)/sqlite3.h: $(SQLITE_BUILD_DIR)/Makefile

$(SQLITE_BUILD_DIR)/sqlite3.c: $(SQLITE_BUILD_DIR)/Makefile
	$(MAKE) -C $(SQLITE_BUILD_DIR) sqlite3.c

$(SQLITE_BUILD_DIR)/Makefile: $(SQLITE_BUILD_DIR)/.tag
	cd $(SQLITE_BUILD_DIR) && ../configure

$(SQLITE_BUILD_DIR)/.tag:
	mkdir $(SQLITE_BUILD_DIR) && touch $@

clean:
	$(RM) $(OBJS)

distclean: clean
	$(RM) -rf $(EXECUTABLE) *.d $(SQLITE_BUILD_DIR)


