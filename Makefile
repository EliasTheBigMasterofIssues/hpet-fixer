PREFIX ?= /usr
BINDIR ?= $(PREFIX)/bin
SYSTEMDUNITDIR ?= /etc/systemd/system

all:
	pyinstaller --optimize 2 --onefile hpet_fixer.py

install:
	
	install -Dm755 "dist/hpet_fixer" "$(BINDIR)/hpet_fixer"

	# Copy and Paste from https://github.com/hakavlad/mg-lru-helper/blob/main/Makefile
	sed "s|:TARGET_BIN:|$(BINDIR)|g" hpet-fixer.service.in > hpet-fixer.service
	install -m644 hpet-fixer.service $(SYSTEMDUNITDIR)/hpet-fixer.service


uninstall:
	
	systemctl disable hpet-fixer.service
	
	rm -fv $(DESTDIR)$(BINDIR)/hpet_fixer
	
	rm -fv $(DESTDIR)$(SYSTEMDUNITDIR)/hpet-fixer.service

	systemctl daemon-reload

clean: 
	rm -rf dist/ build/ hpet_fixer.spec hpet-fixer.service


