
# This Makefile works in both GNU Make and BSDmake provided you have BSD tar
#     For GNU, we use $(shell which is ignored by BSD make.
#     For BSD make, we use != which is also ignored by GNU make.
SRC = $(shell find . -type f -name '*.reds')
SRC != find . -type f -name '*.reds'

ZIPVER = $(shell sed -n 's/.*Version() -> String = "\([0-9\.]*\)".*/\1/p' Codeware.reds)
ZIPVER != sed -n 's/.*Version() -> String = "\([0-9\.]*\)".*/\1/p' Codeware.reds

ZIPDIR = release

REL = Shadowfax-Codeware-macOS
ZIP = $(ZIPDIR)/$(REL)-$(ZIPVER).zip

# macOS, Linux users will need to use the path to an installed bsdtar.
BSDTAR = /usr/bin/tar

.PHONY: all clean

all: $(ZIP)

$(ZIP): $(SRC)
	@mkdir $(ZIPDIR) > /dev/null 2>&1 || true
	@$(BSDTAR) -v --format=zip -s "#^\.#r6/scripts/$(REL)#" -cf $(@) $(SRC)

clean:
	rm -f $(ZIP)
