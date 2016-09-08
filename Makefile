#
#  Makefile
#

UNOCONV = /usr/bin/unoconv -vf
CP = /bin/cp
TOUCH = /usr/bin/touch
GIT = GIT_SSH='./my_ssh' /usr/bin/git

SRC_PT = alexei.odt
SRC_EN = alexei-english.odt letter-booking.odt
SRC    = $(SRC_PT) $(SRC_EN)

OUT_PT = alexei.pdf alexei.doc alexei.html
OUT_EN = alexei-english.pdf alexei-english.doc alexei-english.html letter-booking.pdf
OUT    = $(OUT_PT) $(OUT_EN)

DBOX_DIR = $(HOME)/Dropbox/Public/CV
DBOX_OUT = $(DBOX_DIR)/alexei.odt \
	$(DBOX_DIR)/alexei.doc \
	$(DBOX_DIR)/alexei.pdf \
	$(DBOX_DIR)/alexei-english.odt \
	$(DBOX_DIR)/alexei-english.pdf \
	$(DBOX_DIR)/alexei-english.doc

all: cv git

cv: cv_pt cv_en

cv_pt: $(OUT_PT)

$(OUT_PT): $(SRC_PT)
	$(UNOCONV) doc  $(SRC_PT)
	$(UNOCONV) pdf  $(SRC_PT)
	$(UNOCONV) html $(SRC_PT)

cv_en: $(OUT_EN)

$(OUT_EN): $(SRC_EN)
	$(UNOCONV) doc  $(SRC_EN)
	$(UNOCONV) pdf  $(SRC_EN)
	$(UNOCONV) html $(SRC_EN)

git:
	@if [ -n "`$(GIT) status -s`" ]; then \
        $(GIT) pull; \
        $(GIT) add $(SRC) $(OUT); \
        $(GIT) commit $(SRC) $(OUT) \
			-m "Semi-automatic commit at `date +%Y.%m.%d-%H.%M.%S`"; \
		$(GIT) push; \
	fi

dropbox: $(DBOX_OUT)

$(DBOX_OUT): $(OUT_PT) $(OUT_EN)
	$(CP) $(SRC_PT) $(OUT_PT) $(SRC_EN) $(OUT_EN) $(DBOX_DIR)

force:
	$(TOUCH) $(SRC)
	$(MAKE)
    
