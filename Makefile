#
#  Makefile
#

UNOCONV = /usr/bin/unoconv --stdout -vf
CP = /bin/cp -u
GIT = /usr/bin/git

SRC_PT = alexei.odt
SRC_EN = alexei-english.odt
SRC_ALL= $(SRC_PT) $(SRC_EN)

OUT_PT = out/$(SRC_PT) out/alexei.pdf out/alexei.doc
OUT_EN = out/$(SRC_EN) out/alexei-english.pdf out/alexei-english.doc

DBOX_DIR = $(HOME)/Dropbox/Public/CV
DBOX_OUT = $(DBOX_DIR)/alexei.odt \
	$(DBOX_DIR)/alexei.doc \
	$(DBOX_DIR)/alexei.pdf \
	$(DBOX_DIR)/alexei-english.odt \
	$(DBOX_DIR)/alexei-english.pdf \
	$(DBOX_DIR)/alexei-english.doc

all: cv git dropbox

cv: cv_pt cv_en

cv_pt: $(OUT_PT)

$(OUT_PT): $(SRC_PT)
	$(CP) $(SRC_PT) out/$(SRC_PT)
	$(UNOCONV) doc $(SRC_PT) >out/`basename $(SRC_PT) .odt`.doc
	$(UNOCONV) pdf $(SRC_PT) >out/`basename $(SRC_PT) .odt`.pdf

cv_en: $(OUT_EN)

$(OUT_EN): $(SRC_EN)
	$(CP) $(SRC_EN) out/$(SRC_EN)
	$(UNOCONV) doc $(SRC_EN) >out/`basename $(SRC_EN) .odt`.doc
	$(UNOCONV) pdf $(SRC_EN) >out/`basename $(SRC_EN) .odt`.pdf

git:
	[ -n "`$(GIT) status -s`" ] && ( $(GIT) add . ; \
		$(GIT) commit -m "CV: Semi-automated commit at `date +%Y.%m.%d-%H.%M`"; \
		$(GIT) push )

dropbox: $(DBOX_OUT)

$(DBOX_OUT): $(SRC_PT) $(OUT_PT) $(SRC_EN) $(OUT_EN)
	$(CP) $(SRC_PT) $(OUT_PT) $(SRC_EN) $(OUT_EN) $(DBOX_DIR)


