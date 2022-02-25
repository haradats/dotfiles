export PATH := ${HOME}/.local/bin:${HOME}/.node_modules/bin:${HOME}/.cargo/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/bin/core_perl:${HOME}/bin:${HOME}/google-cloud-sdk/bin
export GOPATH := ${HOME}

NODE_PKGS	:= babel-eslint bash-language-server cloc create-nuxt-app create-react-app webpack
NODE_PKGS	+= dockerfile-language-server-nodejs eslint eslint-cli eslint-config-vue netlify-cli
NODE_PKGS	+= eslint-plugin-react eslint-plugin-vue@next expo-cli firebase-tools fx heroku 
NODE_PKGS	+= indium intelephense javascript-typescript-langserver logo.svg @marp-team/marp-cli
NODE_PKGS	+= mermaid mermaid.cli ngrok now prettier parcel-bundler typescript-language-server
NODE_PKGS	+= @vue/cli vue-language-server vue-native-cli jshint

PIP_PKGS	:= ansible ansible-lint beautifulsoup4 black cheat chromedriver-binary diagrams django djangorestframework
PIP_PKGS	+= django-nested-admin django-ses faker gif-for-cli graph-cli httpie importmagic ipywidgets
PIP_PKGS	+= jupyter jupyterlab jupyterthemes litecli matplotlib neovim nose pandas pipenv poetry pre-commit
PIP_PKGS	+= progressbar2 psycopg2-binary py-spy pydantic pydoc_utils r7insight_python redis requests_mock
PIP_PKGS	+= rtv scipy scrapy seaborn selenium speedtest-cli streamlink tldr trash-cli truffleHog virtualenv
PIP_PKGS	+= virtualenvwrapper zappa time termdown

PACKAGES	:= base go zsh git vim tmux keychain evince unrar hugo ethtool zsh-completions xsel emacs gvfs-smb
PACKAGES	+= unace iperf valgrind noto-fonts-emoji inkscape file-roller xclip atool debootstrap oath-toolkit 
PACKAGES	+= imagemagick lynx the_silver_searcher cifs-utils elinks flameshot ruby-rdoc ipcalc traceroute
PACKAGES	+= cups-pdf firefox firefox-i18n-ja gimp strace lhasa hub bookworm tig sysprof pkgfile dconf-editor
PACKAGES	+= rsync nodejs debian-archive-keyring gauche cpio aria2 nmap poppler-data ffmpeg asciidoc sbcl 
PACKAGES	+= aspell aspell-en screen mosh diskus gdb wmctrl pwgen linux-docs htop tcpdump gvfs p7zip lzop fzf 
PACKAGES	+= gpaste optipng arch-install-scripts pandoc jq pkgstats ruby highlight alsa-utils geckodriver
PACKAGES	+= texlive-langjapanese tokei texlive-latexextra ctags hdparm eog curl parallel arc-gtk-theme npm 
PACKAGES	+= typescript llvm llvm-libs lldb tree w3m whois qreator pass zsh-syntax-highlighting shellcheck
PACKAGES	+= bash-completion mathjax expect obs-studio cscope postgresql-libs pdfgrep gnu-netcat cmatrix btop
PACKAGES	+= jpegoptim nethogs mlocate pacman-contrib x11-ssh-askpass libreoffice-fresh-ja python-prompt_toolkit
PACKAGES	+= jhead peek ncdu gnome-screenshot sshfs fping syncthing terraform bat lshw xdotool sshuttle packer 
PACKAGES	+= ripgrep stunnel vimiv adapta-gtk-theme gnome-tweaks firejail opencv hexedit discord pv perl-net-ip
PACKAGES	+= smartmontools gnome-logs wireshark-cli wl-clipboard lsof mapnik editorconfig-core-c watchexec
PACKAGES	+= gtop gopls convmv mpv browserpass-firefox man-db baobab ioping ruby-irb mkcert code findomain
PACKAGES	+= guetzli fabric python-language-server detox usleep libvterm bind asunder lame git-lfs hex miller
PACKAGES	+= diffoscope dust rbw exa sslscan abiword pyright miniserve fdupes

BASE_PKGS	:= filesystem gcc-libs glibc bash coreutils file findutils gawk grep procps-ng sed tar gettext
BASE_PKGS	+= pciutils psmisc shadow util-linux bzip2 gzip xz licenses pacman systemd systemd-sysvcompat 
BASE_PKGS	+= iputils iproute2 autoconf sudo automake binutils bison fakeroot flex gcc groff libtool m4 
BASE_PKGS	+= make patch pkgconf texinfo which

PACMAN		:= sudo pacman -S 
SYSTEMD_ENABLE	:= sudo systemctl --now enable
FLUTTER_URL	:= https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.8.1-stable.tar.xz

.DEFAULT_GOAL := help
.PHONY: all allinstall nextinstall allupdate allbackup

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: allinstall nextinstall allupdate allbackup

${HOME}/.local:
	mkdir -p $<

rclone: ## Init rclone
	$(PACMAN) $@
	chmod 600 ${PWD}/.config/rclone/rclone.conf
	test -L ${HOME}/.config/rclone || rm -rf ${HOME}/.config/rclone
	ln -vsfn ${PWD}/.config/rclone ${HOME}/.config/rclone

gnupg: ## Deploy gnupg (Run after rclone)
	$(PACMAN) $@ git-crypt
	mkdir -p ${HOME}/.$@
	ln -vsf {${PWD},${HOME}}/.$@/gpg-agent.conf

ssh: ## Init ssh
	$(PACMAN) open$@
	mkdir -p ${HOME}/.$@
	ln -vsf {${PWD},${HOME}}/.ssh/{config,known_hosts}
	chmod 600 ${HOME}/.ssh/id_rsa

init: ## Initial deploy dotfiles
	test -L ${HOME}/.emacs.d || rm -rf ${HOME}/.emacs.d
	ln -vsfn ${PWD}/.emacs.d ${HOME}/.emacs.d
	ln -vsf ${PWD}/.lesskey ${HOME}/.lesskey
	lesskey
	for item in zshrc vimrc bashrc npmrc myclirc tmux.conf screenrc aspell.conf gitconfig netrc authinfo; do
		ln -vsf {${PWD},${HOME}}/.$$item
	done
	mkdir -p ${HOME}/.config/mpv
	ln -vsf {${PWD},${HOME}}/.config/mpv/mpv.conf
	ln -vsf {${PWD},${HOME}}/.config/hub
	sudo ln -vsf {${PWD},}/etc/hosts


base: ## Install base and base-devel package
	$(PACMAN) $(BASE_PKGS)

install: ## Install arch linux packages using pacman
	$(PACMAN) $(PACKAGES)
	sudo pkgfile --update

pipinstall: ${HOME}/.local ## Install python packages
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python ${PWD}/get-pip.py --user
	sudo ln -vsf ${PWD}/usr/share/zsh/site-functions/_pipenv /usr/share/zsh/site-functions/_pipenv
	pip install --user --upgrade pip
	pip install --user $(PIP_PKGS)
	rm -fr get-pip.py

goinstall: ${HOME}/.local ## Install go packages
	go install golang.org/x/tools/gopls@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/x-motemen/ghq@latest
	go install github.com/kyoshidajp/ghkw@latest
	go install github.com/simeji/jid/cmd/jid@latest
	go install github.com/jmhodges/jsonpp@latest
	go install github.com/mithrandie/csvq@latest

nodeinstall: ## Install node packages
	sudo pacman -S yarn
	mkdir -p ${HOME}/.node_modules
	for pkg in $(NODE_PKGS); do yarn global add $$pkg; done

rustinstall: ## Install rust and rust language server
	sudo pacman -S rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src

neomutt: ## Init neomutt mail client
	$(PACMAN) neomutt
	mkdir -p ${HOME}/.mutt
	ln -vsf ${PWD}/.muttrc ${HOME}/.muttrc
	for item in mailcap certifcates aliases signature; do ln -vsf {${PWD},${HOME}}/.mutt/$$item; done
	ln -vsf {${PWD},${HOME}}/.goobookrc
	yay -S goobook-git
	goobook authenticate

alacritty: ## Init alacritty
	$(PACMAN) $@
	test -L ${HOME}/.config/$@/$@.yml || rm -rf ${HOME}/.config/$@/$@.yml
	ln -vsf {${PWD},${HOME}}/.config/$@/$@.yml

urxvt: ## Init rxvt-unicode terminal
	$(PACMAN) $@-perls rxvt-unicode
	ln -vsf ${PWD}/.Xresources ${HOME}/.Xresources
	for item in urxvt{,c,-tabbed}; do sudo ln -vsf {${PWD},}/usr/share/applications/$$item.desktop; done
	mkdir -p ${HOME}/.config/autostart
	chmod a+x ${PWD}/.auto_start.sh
	ln -vsf {${PWD},${HOME}}/.auto_start.sh
	ln -vsf ${PWD}/.config/autostart/autostart.desktop ${HOME}/.config/autostart/autostart.desktop

xterm: ## Init xterm terminal
	$(PACMAN) $@
	ln -vsf {${PWD},${HOME}}/.Xresources
	for item in {,u}term; do sudo ln -vsf {${PWD},}/usr/share/applications/$$item.desktop; done

mlterm: ## Init mlterm terminal
	yay -S $@
	mkdir -p ${HOME}/.$@
	for item in main color aafont key; do
		ln -vsf {${PWD},${HOME}}/.$@/$$item
	done
	sudo ln -vsf {${PWD},}/usr/share/applications/$@.desktop
	sudo ln -vsf {${PWD},}/usr/share/applications/mlclient.desktop

termite: ## Init termite terminal
	yay -S $@
	mkdir -p ${HOME}/.config/$@
	ln -vsf {${PWD},${HOME}}/.config/$@/config

dnsmasq: ## Init dnsmasq
	$(PACMAN) $@
	sudo ln -vsf ${PWD}/etc/$@/resolv.$@.conf /etc/resolv.$@.conf
	sudo ln -vsf ${PWD}/etc/$@/$@.conf /etc/$@.conf
	sudo mkdir -p /etc/NetworkManager
	sudo ln -vsf {${PWD},}/etc/NetworkManager/NetworkManager.conf

tlp: ## Setting for power saving and preventing battery deterioration
	$(PACMAN) $@ powertop
	sudo ln -vsf {${PWD},}/etc/default/$@
	$(SYSTEMD_ENABLE) $@.service $@-sleep.service

lvfs: ## For Linux Vendor Firmware Service
	$(PACMAN) fwupd dmidecode
	sudo dmidecode -s bios-version

uefiupdate: ## Update system firmware and uefi
	for action in refresh get-updates update; do fwupdmgr $$action; done

thinkpad: ## Workaround for Intel throttling issues in Linux
	$(PACMAN) throttled
	$(SYSTEMD_ENABLE) lenovo_fix.service

keyring: ${HOME}/.local ## Init gnome keyrings
	$(PACMAN) seahorse
	test -L ${HOME}/.local/share/keyrings || rm -rf ${HOME}/.local/share/keyrings
	ln -vsfn ${HOME}/{backup,.local/share}/keyrings

ibusmozc: ## Install ibus-mozc
	test -L ${HOME}/.mozc || rm -rf ${HOME}/.mozc
	ln -vsfn ${HOME}/backup/mozc ${HOME}/.mozc
	mkdir -p ${HOME}/.config/autostart
	ln -vsf {${PWD},${HOME}}/.config/autostart/ibus.desktop
	yay -S ibus-mozc
	ibus-daemon -drx

fcitx-mozc: ## Install fcitx-mozc
	$(PACMAN) $@
	sudo ln -vsf ${PWD}/etc/environment /etc/environment
	mkdir -p ${HOME}/.config/fcitx/addon
	ln -vsf {${PWD},${HOME}}/.config/fcitx/addon/fcitx-clipboard.conf
	test -L ${HOME}/.mozc || rm -rf ${HOME}/.mozc
	ln -vsfn ${HOME}/backup/mozc ${HOME}/.mozc

ttf-cica: ## Install Cica font
	yay -S $@

localhostssl: # Set ssl for localhost
	mkcert -install
	mkcert localhost

docker: ## Docker initial setup
	$(PACMAN) $@ $@-compose
	sudo usermod -aG $@ ${USER}
	$(SYSTEMD_ENABLE) $@.service

podman: ## Podman initial setup
	$(PACMAN) $@
	$(SYSTEMD_ENABLE) io.$@.service

php: ## Init php setting
	$(PACMAN) $@ $@-intl
	sudo ln -vsf {${PWD},}/etc/php/php.ini

circle-ci-cli: ## Install circle ci cli and setup
	curl -fLSs https://circle.ci/cli | sudo bash
	circleci update install

maria-db: mariadb
mariadb: ## Mariadb initial setup
	sudo ln -vsf {${PWD},}/etc/sysctl.d/40-max-user-watches.conf
	$(PACMAN) $@ $@-clients
	sudo ln -vsf {${PWD},}/etc/my.cnf
	sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
	$(SYSTEMD_ENABLE) $@.service
	sudo mysql -u root < ${PWD}/$@/init.sql
	mysql_secure_installation
	mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql

tailscale: ## tailscale initial setup
	$(PACMAN) $@
	$(SYSTEMD_ENABLE) $@d
	sudo $@ up

.ONESHELL:
postgresql: ## PostgreSQL initial setup
	$(PACMAN) $@
	cd /home
	sudo -u postgres initdb -E UTF8 --no-locale -D '/var/lib/postgres/data'
	$(SYSTEMD_ENABLE) postgresql.service
	sudo -u postgres createuser --interactive

remotedesktop: ## Install remotedesktop
	$(PACMAN) remmina freerdp libvncserver

eralchemy: ## Install eralchemy
	sudo pacman -S graphviz
	pip install --user $@

mycli: ## Init mycli
	mkdir -p ${HOME}/backup/$@
	pip install --user $@
	ln -vsf ${HOME}{/backup/$@,}/.$@-history

pgcli: ## Init pgcli
	mkdir -p ${HOME}/backup
	pip install --user $@
	test -L ${HOME}/.config/$@ || rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME}/{backup,.config}/$@

gcloud: ## Install google cloud SDK and setting
	$(PACMAN) $@ kubectl kubectx kustomize helm
	curl https://sdk.cloud.google.com | bash
	test -L ${HOME}/.config/gcloud || rm -rf ${HOME}/.config/gcloud
	ln -vsfn ${HOME}/{backup,.config}/gcloud
	yay -S stern-bin

minikube: ## Setup minikube with kvm2
	$(PACMAN) $@ libvirt qemu-headless ebtables docker-machine
	yay -S docker-machine-driver-kvm2
	sudo usermod -a -G libvirt ${USER}
	$(SYSTEMD_ENABLE) libvirtd.service
	$(SYSTEMD_ENABLE) virtlogd.service
	$@ config set vm-driver kvm2

kind: ## Setup kind (Kubernetes In Docker)
	go install sigs.k8s.io/kind@v0.11.1
	sudo sh -c "kind completion zsh > /usr/share/zsh/site-functions/_kind"

redis: ## Redis inital setup
	$(PACMAN) $@
	$(SYSTEMD_ENABLE) $@.service

dingo: ## Install dingo Google DNS over HTTPS
	$(PACMAN) $@
	$(SYSTEMD_ENABLE) $@.service

ccls: ## Install c,c++ language server
	yay -S ccls

android: ## Install android-studio
	yay -S android-studio

dart: ## Install dart and language server
	$(PACMAN) $@
	pub global activate $@_language_server

flutter: ## Install flutter
	mkdir -p ~/src/github.com/$@
	wget -O- $(FLUTTER_URL) | tar -C ~/src/github.com/$@ xf-

jdk: ## Install jdk
	$(PACMAN) jdk-openjdk

mpsyt: ## Install and deploy mps-youtube
	pip install --user mps-youtube youtube-dl
	mkdir -p ${HOME}/.config/mps-youtube
	test -L ${HOME}/.config/mps-youtube/playlists || rm -rf ${HOME}/.config/mps-youtube/playlists
	ln -vsfn ${HOME}/backup/youtube/playlists ${HOME}/.config/mps-youtube/playlists

spotify: ## Install spotify
	gpg --keyserver hkp://keyserver.ubuntu.com --receive-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
	yay -S spotify

sxiv: ## Init sxiv
	$(PACMAN) $@
	mkdir -p ${HOME}/.config/$@/exec
	ln -vsf {${PWD},${HOME}}/.config/$@/exec/image-info && chmod +x $$_

zeal: ## Deploy zeal config and docsets
	yay -S $@
	sudo pacman -S qt5-styleplugins qt5ct
	sudo ln -vsf ${PWD}/etc/environment /etc/environment
	mkdir -p ${HOME}/.config/Zeal
	ln -vsf {${PWD},${HOME}}/.config/Zeal/Zeal.conf

emacspeak: ## Install emacspeak for blind person
	yay -S $@

intel: ## Setup Intel Graphics
	sudo ln -vsf {${PWD},}/etc/X11/xorg.conf.d/20-intel.conf

yay: ## Install yay using yay
	yay -S $@

aur: ## Install arch linux AUR packages using yay
	yay -S downgrade git-secrets nvm rgxg slack-desktop zoom

sequeler: ## Install gui database tools
	yay -S $@-git

beekeeper: ## Setup beekeeper-studio
	yay -S $@-studio-bin
	test -L ${HOME}/.config/$@-studio || rm -rf ${HOME}/.config/$@-studio
	ln -vsfn ${HOME}/{backup,.config}/$@-studio

gh: ## Install and setup github-cli
	$(PACMAN) github-cli
	test -L ${HOME}/.config/$@ || rm -rf ${HOME}/.config/$@
	ln -vsfn ${HOME}/{backup,.config}/$@

aurplus: ## Install arch linux AUR packages using yay
	yay -S appimagelauncher drone-cli nkf pencil rtags skypeforlinux-stable-bin trivy-bin

terraformer: ## Install terraformer
	curl -LO https://github.com/GoogleCloudPlatform/$@/releases/download/`curl -s https://api.github.com/repos/GoogleCloudPlatform/$@/releases/latest | grep tag_name | cut -d '"' -f 4`/$@-aws-linux-amd64
	sudo install -m 755 $@-aws-linux-amd64 /usr/local/bin/$@ && rm $@-aws-linux-amd64

bluetooth: # Setup bluetooth for AS801 by AfterShokz
	$(PACMAN) bluez
	$(SYSTEMD_ENABLE) $@

desktop: ## Update desktop entry
	for item in vim xterm uxterm urxvt urxvtc urxvt-tabbed; do
		sudo ln -vsf {${PWD},}/usr/share/applications/$${item}.desktop
	done

toggle: ## Prepare command that toggle between emacs and browser
	sudo ln -vsf {${PWD},}/usr/share/applications/$@.desktop
	sudo install ${PWD}/.$@.sh /usr/local/bin/$@

aws: ${HOME}/.local ## Init aws cli
	pip install --user awscli
	ln -vsfn {${PWD},${HOME}}/.$@

awsv2: ## Init aws cli version 2
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	test -L ${HOME}/.aws || rm -rf ${HOME}/.aws
	ln -vsfn ${PWD}/.aws ${HOME}/.aws
	rm -fr awscliv2.zip aws
	pip install --user awslogs

tmuxp: ${HOME}/.local ## Install tmuxp
	pip install --user $@
	sudo ln -vsf {${PWD},${HOME}}/.config/main.yaml

roswell: ## Install ros and lem
	$(PACMAN) $@
	ros install cxxxr/lem

sylpheed: ## Init sylpheed
	$(PACMAN) $@
	test -L ${HOME}/.sylpheed-2.0 || rm -rf ${HOME}/.sylpheed-2.0
	ln -vsfn ${HOME}/{backup/sylpheed,}/.sylpheed-2.0

psd: ## Profile-Sync-Daemon initial setup
	yay -S profile-sync-daemon
	mkdir -p ${HOME}/.config/psd
	ln -vsf ${PWD}/.config/psd/psd.conf ${HOME}/.config/psd/psd.conf
	echo "${USER} ALL=(ALL) NOPASSWD: /usr/bin/psd-overlay-helper" | sudo EDITOR='tee -a' visudo
	systemctl --user --now enable psd.service

chromium: ## Install chromium and noto-fonts and browserpass
	$(PACMAN) $@ browserpass-$@ noto-fonts noto-fonts-cjk
	make -C /usr/lib/browserpass hosts-$@-user
	test -L ${HOME}/.password-store || rm -rf ${HOME}/.password-store
	ln -vsfn ${HOME}/backup/browserpass ${HOME}/.password-store

chrome: ## Install chrome and noto-fonts and browserpass
	$(PACMAN) google-$@ browserpass-$@ noto-fonts noto-fonts-cjk libpipewire02
	$(MAKE) -C /usr/lib/browserpass hosts-$@-user
	test -L ${HOME}/.password-store || rm -rf ${HOME}/.password-store
	ln -vsfn ${HOME}/backup/browserpass ${HOME}/.password-store

neovim: ## Init neovim
	$(PACMAN) $@
	mkdir -p ${HOME}/.config/nvim
	for item in init installer; do \
		ln -vsf {${PWD},${HOME}}/.config/nvim/$$item.vim
	bash ${HOME}/.config/nvim/installer.sh ${HOME}/.config/nvim
	sudo ln -vsf {${PWD},}/usr/share/applications/nvim.desktop

varnish: ## Varnish inital setup
	$(PACMAN) $@
	sudo ln -vsf {${PWD},}/etc/$@/default.vcl
	$(SYSTEMD_ENABLE) $@.service

mongodb: ## Mongodb initial setup
	$(PACMAN) $@ $@-tools
	$(SYSTEMD_ENABLE) $@.service

gnuglobal: ${HOME}/.local ## Install gnu global
	pip install --user pygments
	yay -S global

.ONESHELL:
SHELL = /bin/bash
elixir-ls: ## Install elixir-ls(Recompile if the version of elixir changes)
	sudo pacman -S elixir
	git clone git@github.com:JakeBecker/elixir-ls.git ${HOME}/src/github.com/JakeBecker/$@
	cd $$_ && mkdir rel
	mix deps.get && mix compile
	mix elixir_ls.release -o rel

emacs-devel: ## Install development version of emacs
	git clone -b emacs-27 git@github.com:emacs-mirror/emacs.git ${HOME}/src/github.com/masasam/emacs
	cd ${HOME}/src/github.com/masasam/emacs && ./autogen.sh && ./configure && make && sudo make install && make clean
	rm -rf ${HOME}/.emacs.d/elpa

screenkey: ## Init screenkey
	yay -S screenkey
	mkdir -p ${HOME}/.config
	ln -vsf ${PWD}/.config/screenkey.json ${HOME}/.config/screenkey.json

rbenv: ## Install rvenv ruby-build
	yay -S $@
	yay -S ruby-build
	$@ install 2.7.2
	$@ rehash
	gem install bundle

rubygem: ## Install rubygem package
	gem install bundler jekyll sass compass solargraph rawler rdoc irb rails

django: ## Create django project from scratch
	mkdir -p ${HOME}/src/github.com/masasam/djangoproject && cd $$_ && touch Pipfile && \
	pipenv --python=3.8.6 && \
	pipenv install $@ && \
	pipenv run $@-admin startproject config .

.ONESHELL:
rails: rubygem rbenv ## Create rails project from scratch
	export RBENV_ROOT="${HOME}/.rbenv"
	if [ -d "${RBENV_ROOT}" ]; then
	  export PATH="${RBENV_ROOT}/bin:${PATH}"
	  eval "$(rbenv init -)"
	fi
	rbenv global 2.7.2
	rbenv rehash
	mkdir -p ${HOME}/src/github.com/masasam/$@; cd $$_
	rbenv local 2.7.2
	bundle init
	echo "gem '$@', '~> 6.0.3.3'" >> Gemfile
	bundle install --path vendor/bundle
	bundle exec $@ new . --database=mysql --skip-test --skip-turbolinks
	bundle exec $@ webpacker:install

tym: ## Init tym terminal
	yay -S $@
	mkdir -p ${HOME}/.config/$@
	ln -vsf {${PWD},${HOME}}/.config/$@/config.lua
	sudo ln -vsf {${PWD},}/usr/share/applications/$@.desktop

backup: ## Backup arch linux packages
	mkdir -p ${PWD}/archlinux
	pacman -Qnq > ${PWD}/archlinux/pacmanlist
	pacman -Qqem > ${PWD}/archlinux/aurlist

update: ## Update arch linux packages and save packages cache 3 generations
	yay -Syu; paccache -ruk0

pipbackup: ## Backup python packages
	mkdir -p ${PWD}/archlinux
	pip freeze > ${PWD}/archlinux/requirements.txt

piprecover: ## Recover python packages
	mkdir -p ${PWD}/archlinux
	pip install --user -r ${PWD}/archlinux/requirements.txt

pipupdate: ## Update python packages
	pip list --user | cut -d" " -f 1 | tail -n +3 | xargs pip install -U --user

rustupdate: ## Update rust packages
	cargo install-update -a

yarnupdate: ## Update yarn packages
	yarn global upgrade

mysite: ## My site and blogs source(This is private repository)
	ghq get -p masasam/solist
	ghq get -p masasam/solistblog
	ghq get -p masasam/PPAP

docker_image: docker
	docker build -t dotfiles ${PWD}

testbackup: docker_image ## Test this Makefile with mount backup directory
	docker run -it --name make$@ -v /home/${USER}/backup:${HOME}/backup:cached --name makefiletest -d dotfiles:latest /bin/bash
	for target in install init neomutt aur pipinstall goinstall nodeinstall; do
		docker exec -it make$@ sh -c "cd ${PWD}; make $${target}"
	done

test: docker_image ## Test this Makefile with docker without backup directory
	docker run -it --name make$@ -d dotfiles:latest /bin/bash
	for target in install init neomutt aur pipinstall goinstall nodeinstall; do
		docker exec -it make$@ sh -c "cd ${PWD}; make $${target}"
	done

testpath: ## Echo PATH
	PATH=$$PATH
	@echo $$PATH
	GOPATH=$$GOPATH
	@echo $$GOPATH

allinstall: rclone gnupg ssh install init keyring urxvt xterm termite yay tlp thinkpad ttf-cica dnsmasq pipinstall goinstall fcitx-mozc neomutt docker nodeinstall zeal lvfs gcloud awsv2 toggle aur beekeeper kind eralchemy mpsyt gh

nextinstall: chrome rubygem rbenv rustinstall postgresql maria-db mycli pgcli

allupdate: update pipupdate rustupdate goinstall yarnupdate

allbackup: backup pipbackup
