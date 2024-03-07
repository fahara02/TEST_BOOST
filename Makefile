

SRCDIR=./src
LIBDIR=./lib
BUILDDIR=./build


# Compilers definition.
CC = g++


# Compilers setting.
OPT_LEVEL=O0



# Files
SRCS := $(wildcard $(SRCDIR)/*.cpp) 
OBJS := $(SRCS:$(SRCDIR)/%.cpp=$(BUILDDIR)/%.o)

ONLYSRCS+=$(notdir $(foreach file, $(SRCDIR),$(wildcard $(SRCDIR)/*.cpp)))
BUILDOBJ+= $(addprefix $(BUILDDIR)/,$(patsubst %.cpp,%.o, $(ONLYSRCS)))


# Get all subdirectories of LIBDIR
SUBDIRS := $(wildcard $(LIBDIR)/*/)
# BOOSTDIRS:= $(wildcard $(BOOSTLIB)/*/)
# INCBASEBOOST:=$(addprefix -I,$(BOOSTLIB)/)
INCDIRS := $(SUBDIRS)   


CFLAGS_INC= $(foreach dir, $(INCDIRS), $(addprefix -I, $(dir))) 
 

# Compiler flags
CFLAGS =-g -Wall -std=c++14 $(CFLAGS_INC)

# Executable
EXECUTABLE = $(BUILDDIR)/test.exe


# Targets
all: $(BUILDDIR) $(EXECUTABLE)
	@echo "Task completed"

$(BUILDDIR):
	@echo "Building" $<
	@if not exist "$(BUILDDIR)" mkdir "$(BUILDDIR)"

$(EXECUTABLE): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@	

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@


	

clean:
	@echo "Cleaning......." $<
	@echo "$(BUILDOBJ)" $<
	@if exist "$(BUILDDIR)" (for %%i in ($(BUILDDIR)\*.o) do @del /Q "%%i")
	@if exist "$(BUILDDIR)" (for %%i in ($(BUILDDIR)\*.exe) do @del /Q "%%i")
	@if exist "$(BUILDDIR)" rmdir /s /q "$(BUILDDIR)"
	@echo "Cleaning done!" $<

test:	
	@echo "$(CFLAGS_INC)" $<