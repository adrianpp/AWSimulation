EXECUTABLE=AWSimulation
TOP_DIR=$(shell pwd)
SQLITE_BUILD_DIR=build/sqlite

# sqlite3 first because the generated headers are a dependency for our application
SRCS=$(SQLITE_BUILD_DIR)/sqlite3.c ConsoleApplication1.cpp MasterBoard.cpp Minion.cpp
OBJS=$(subst .c,.o,$(subst .cpp,.o,$(SRCS)))

.PHONY: all clean distclean

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

# generate, and use dependency files (if available)
CPPFLAGS+= -MMD -I$(SQLITE_BUILD_DIR)
-include $(OBJS:.o=.d)

$(SQLITE_BUILD_DIR)/sqlite3.h: $(SQLITE_BUILD_DIR)/Makefile

$(SQLITE_BUILD_DIR)/sqlite3.c: $(SQLITE_BUILD_DIR)/Makefile
	$(MAKE) -C $(SQLITE_BUILD_DIR) sqlite3.c

$(SQLITE_BUILD_DIR)/Makefile: $(SQLITE_BUILD_DIR)/.tag
	cd $(SQLITE_BUILD_DIR) && $(TOP_DIR)/sqlite/configure

$(SQLITE_BUILD_DIR)/.tag:
	mkdir -p $(SQLITE_BUILD_DIR) && touch $@

clean:
	$(RM) $(OBJS)

distclean: clean
	$(RM) -rf $(EXECUTABLE) *.d $(SQLITE_BUILD_DIR)


