# My dotfiles based on Makefile

## Synopsis

![emacs](https://raw.githubusercontent.com/masasam/image/image/emacs.png)

![mutt](https://raw.githubusercontent.com/masasam/image/image/mutt.png)

## Let's build environment with Makefile

This dotfiles is for Arch linux.
Since there is no such as a distribution without make,
if you make [Makefile](https://github.com/masasam/dotfiles/blob/master/Makefile),
you can correspond to any distribution.
Let's make a [Makefile](https://github.com/masasam/dotfiles/blob/master/Makefile) immediately.

### With Makefile, such a good thing

Easy to build development environment with this command.

    make install

I never have to worry about setting my laptop again.

### Deploying dotfiles can be done in a moment

After make install you can deploy dotfiles with this command.

    make init

### With Makefile, you will be able to recover your usual environment in 1 hour

![make](https://raw.githubusercontent.com/masasam/image/image/make.png)

### Commands for allinstall

	make allinstall

You can install all with this command.
You can install anything written after allinstall in the makefile.

    make backup

The ArchLinux package list installed by this command is backed up in the archlinux directory.

	make allbackup

You can backup packages all with this command.

	make allupdate

You can update packages all with this command.

## Synchronize backup directory to cloud

[rclone](https://github.com/rclone/rclone) setting

- google drive is [here](https://rclone.org/drive/)

- dropbox is [here](https://rclone.org/dropbox/)

Synchronize the backup directory to your favorite cloud using the [rclone](https://github.com/rclone/rclone).

	rclone sync ${HOME}/backup drive:backup
	rclone sync ${HOME}/backup dropbox:backup

Synchronize the ~/backup directory to your favorite cloud in this command.
This command is a one-way synchronization to the cloud from your laptop or desktop.
The following command is a one-way synchronization to your laptop or desktop from the cloud.

	rclone sync drive:backup ${HOME}/backup
	rclone sync dropbox:backup ${HOME}/backup

Since configuration file of [rclone](https://github.com/rclone/rclone) is encrypted with [git-crypt](https://github.com/AGWA/git-crypt),
you install and set up [git-crypt](https://github.com/AGWA/git-crypt) at first step.
Backup directory sample is [here](https://github.com/masasam/dotfiles/tree/master/backup_sample).

## How to use git-crypt

	git-crypt init

Set the name of the file you want to encrypt to .gitattributes

    rclone.conf filter=git-crypt diff=git-crypt

Commit the .gitattributes to git.

	git add .gitattributes
	git commit -m 'Add encrypted file config'

Specify the key used to encrypt.

	git-crypt add-gpg-user YOUR_GNUPG_ID

It is encrypted except in your laptop or desktop after you commit rclone.conf.

	git-crypt unlock

After cloning a repository with encrypted files, unlock with gnupg at this command.

#### Criteria of things managed by backup directory

- What can not be placed on github

	scripts that password was written, etc.

- Because it makes a lot of update file, it is troublesome to synchronize with github

    .zsh_history
	.mozc

- Those that can not be opened but need to protect data

   Sylpheed configuration file and mail data etc.

# Arch Linux install

Why Arch linux?

- Unless your laptop breaks, arch linux is a rolling release so you don't have to reinstall it.
  Even if it gets broken, I made a [Makefile](https://github.com/masasam/dotfiles/blob/master/Makefile) so I can return in 1 hour and it's unbeatable.

- Arch linux is good because it is difficult for my development environment to be old packages.

- I like customization but if customization is done too much, it is not good because it can not receive the benefit of the community. Since Arch linux is unsuitable for excessive customization, it is fit to me.
  In principle the package of Arch linux is a policy to build from the source of vanilla (Vanilla means that it does not apply its own patch for arch linux)
  It is good because Arch linux unique problems are unlikely.

- Arch linux is lightweight because there is no extra thing.

![top](https://raw.githubusercontent.com/masasam/image/image/top.png)

Download Arch linux.

https://www.archlinux.org/releng/releases/

Create USB installation media.
Run the following command, replacing /dev/sdx with your drive, e.g. /dev/sdb. (Do not append a partition number, so do not use something like /dev/sdb1)

	sudo dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync

![baobao](https://raw.githubusercontent.com/masasam/image/image/baobao.png)

SSD has only 250G, but it is sufficient for the environment that uses arch linux and emacs.

#### Boot in USB memory

Change it to boot from usb in BIOS UEFI.

	Security > Secure Boot: Disable
	Set Config -> Sleep State: "linux"(This may be a peculiar setting of my thinkpad x1 gen6).
	Set Config -> Thunderbolt BIOS Assist Mode: "Enabled"(This may be a peculiar setting of my thinkpad x1 gen6).
	Security > I/O Port Access > Wireless WAN: Disable(for power save)
	Security > I/O Port Access > Memory Card Slot: Disable(for power save)
	Security > I/O Port Access > Fingerprint Reader: Disable(for power save)
	Config -> Network -> Wake On LAN: Disabled(for power save)
	Config -> Network -> Wake On LAN from Dock: Disabled(for power save)

Partitioning

* Use UEFI and GPT

  Choose according to your hardware.

* Partition / only

* No swap

Install archlinux

	gdisk /dev/sda

clear the partition

	Command (? for help):o

Make ESP(EFI System Partition).
Because I want to do UEFI boot, I make a FAT32 formatted partition.

	Command (? for help):n
	Permission number: 1
	First sector     : enter
	Last sector      : +512M
	Hex code or GUID : EF00

Set all the rest to / partition

	Command (? for help):n
	Permission number: 2
	First sector     : enter
	Last sector      : enter
	Hex code or GUID : 8300

Format and mount with fat32 and ext4

	mkfs.vfat -F32 /dev/sda1
	mkfs.ext4 /dev/sda2
	mount /dev/sda2 /mnt
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot

Connect internet with wifi

	ip link
	rfkill list
	rfkill unblock 0
	wifi-menu wifi0

Make sure the earliest mirror is selected.
Write the closest mirror on the top.

	sudo pacman -S vi vim
	vi /etc/pacman.d/mirrorlist

Install bese bese-devel of arch

    pacstrap /mnt base base-devel linux linux-firmware

Generate fstab

    genfstab -U -p /mnt >> /mnt/etc/fstab

Mount and log in as bash login shell

    arch-chroot /mnt /bin/bash

Set the host name

    echo thinkpad > /etc/hostname

vi /etc/locale.gen

	en_US.UTF-8 UTF-8
	ja_JP.UTF-8 UTF-8

Next execute

    locale-gen

Shell is in English environment

    export LANG=C

This neighborhood will be UTF-8

    echo LANG=ja_JP.UTF-8 > /etc/locale.conf

Time zone example

	ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
	ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
	ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime

Time adjustment

    hwclock --systohc --utc

Generate kernel image

    mkinitcpio -p linux

Generate user

    useradd -m -G wheel -s /bin/bash ${USER}

Set password

    passwd ${USER}

Set groups and permissions

    visudo

Uncomment comment out following

	Defaults env_keep += “ HOME ”
	%wheel ALL=(ALL) ALL

Set boot loader

	pacman -S grub dosfstools efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck --debug
	grub-mkconfig -o /boot/grub/grub.cfg

#### Prepare drivers and Xorg Gnome

Install drivers that match your environment

	lspci | grep VGA
	pacman -S intel-media-driver intel-ucode libva-utils
	pacman -S xorg-server xorg-apps

Gnome can be put as small as necessary

	pacman -S gnome-backgrounds
	pacman -S gnome-control-center
	pacman -S gnome-keyring
	pacman -S nautilus

Terminal uses urxvt and termite

	sudo pacman -S rxvt-unicode urxvt-perls
	sudo pacman -S termite

Enable graphical login with gdm

	pacman -S gdm
	systemctl enable gdm.service

Preparing the net environment

	pacman -S networkmanager
	systemctl enable NetworkManager.service
	pacman -S otf-ipafont

Audio setting

	sudo pacman -S pipewire-pulse pipewire-media-session
	exit
	reboot

#### Login with ${USER} to arrange home directory

	sudo pacman -S xdg-user-dirs
	LANG=C xdg-user-dirs-update --force
	sudo pacman -S zsh git
	sudo pacman -S noto-fonts noto-fonts-cjk chromium

Install yay

	mkdir -p ~/src/github.com
	cd src/github.com
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si

#### Preparing dotfiles

	sudo pacman -S cifs-utils gvfs gvfs-smb git-crypt gnupg openssh

Import the gpg key that has been backed up.

	gpg --import /path/to/private.key
	gpg --import /path/to/public.key
	gpg --edit-key masasam@users.noreply.github.com
	gpg> trust

Run the following after set the ssh key

    mkdir -p ~/src/github.com/masasam
    cd src/github.com/masasam
	git clone git@github.com:masasam/dotfiles.git
	cd dotfiles
	git-crypt unlock
	make install
	make init

	# Below is for posting images of github
	cd ~/Pictures
	git clone -b image git@github.com:masasam/image.git

### dconf setting

    sudo pacman -S dconf-editor

	dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"
	dconf write /org/gnome/desktop/interface/gtk-theme "'Adwaita-dark'"
	dconf write /org/gnome/desktop/interface/gtk-key-theme "'Emacs'"
	dconf write /org/gnome/desktop/interface/text-scaling-factor 1.25
	dconf write /org/gnome/desktop/interface/cursor-size 30
	dconf write /org/gnome/desktop/interface/clock-show-date true
	dconf write /org/gnome/desktop/interface/clock-show-weekday true
	dconf write /org/gnome/desktop/interface/show-battery-percentage true
	dconf write /org/gnome/desktop/wm/preferences/num-workspaces 1
	dconf write /org/gnome/desktop/wm/keybindings/activate-window-menu "['']"
	dconf write /org/gnome/desktop/search-providers/disable-external true
	dconf write /org/gnome/desktop/privacy/remember-recent-files false
	dconf write /org/gnome/shell/keybindings/toggle-overview "['<Alt>space']"
	dconf write /org/gnome/mutter/dynamic-workspaces false

--------------------------------------

You can make install from here

--------------------------------------

## Development environment install

#### Install using pacman

    sudo pacman -S firefox firefox-i18n-ja fping xdotool
    sudo pacman -S sylpheed emacs curl xsel tmux eog lhasa
    sudo pacman -S zsh-completions keychain syncthing lzop
    sudo pacman -S powertop gimp unrar gnome-screenshot
    sudo pacman -S file-roller xclip atool evince inkscape
    sudo pacman -S seahorse the_silver_searcher zeal vimiv
    sudo pacman -S cups-pdf htop neovim go pkgfile rsync elixir
	sudo pacman -S nodejs whois nmap poppler-data ffmpeg
	sudo pacman -S aspell aspell-en httperf asciidoc sbcl
	sudo pacman -S gdb hub wmctrl gpaste pkgstats ripgrep
	sudo pacman -S linux-docs pwgen gauche screen ipcalc rbw
	sudo pacman -S arch-install-scripts ctags parallel opencv
	sudo pacman -S pandoc texlive-langjapanese texlive-latexextra
	sudo pacman -S shellcheck cscope typescript packer alacritty
	sudo pacman -S noto-fonts-cjk arc-gtk-theme jq dnsmasq exa
	sudo pacman -S zsh-syntax-highlighting terraform wl-clipboard
	sudo pacman -S npm llvm llvm-libs lldb hdparm rxvt-unicode 
	sudo pacman -S mariadb-clients postgresql-libs tig lsof fzf
	sudo pacman -S debootstrap tcpdump pdfgrep sshfs stunnel
	sudo pacman -S alsa-utils mlocate traceroute hugo mpv jhead
	sudo pacman -S nethogs optipng jpegoptim noto-fonts-emoji
	sudo pacman -S debian-archive-keyring tree rclone gnome-tweaks
	sudo pacman -S mathjax strace valgrind p7zip unace postgresql
	sudo pacman -S yarn geckodriver w3m neomutt iperf redis convmv
	sudo pacman -S highlight lynx elinks mediainfo cpio flameshot
	sudo pacman -S oath-toolkit imagemagick peek sshuttle lshw
	sudo pacman -S bookworm ruby ruby-rdoc pacman-contrib ncdu
	sudo pacman -S dart sxiv adapta-gtk-theme podman firejail
	sudo pacman -S pyenv hexedit tokei aria2 discord pv findomain
	sudo pacman -S gnome-logs qreator diskus sysprof bat mapnik
	sudo pacman -S obs-studio wireshark-cli browserpass-chromium
	sudo pacman -S editorconfig-core-c watchexec browserpass-firefox
	sudo pacman -S man-db baobab ioping mkcert code detox git-lfs
	sudo pacman -S guetzli fabric gtop pass github-cli libvterm
	sudo pacman -S perl-net-ip hex miller btop diffoscope dust
	sudo pacman -S sslscan abiword pyright miniserve fdupes deno
	sudo pacman -S serverless mold fx httpie bash-language-server

![activity](https://raw.githubusercontent.com/masasam/image/image/activity.png)

#### Install using yay

	yay -S appimagelauncher
	yay -S beekeeper-studio-bin
	yay -S drone-cli
	yay -S git-secrets
	yay -S global
	yay -S goobook-git
	yay -S ibus-mozc
	yay -S mozc
	yay -S nkf
	yay -S nvm
	yay -S pencil
	yay -S rbenv
	yay -S rgxg
	yay -S ripgrep-all
	yay -S rtags
	yay -S ruby-build
	yay -S screenkey
	yay -S sequeler-git
	yay -S slack-desktop
	yay -S tableplus
	yay -S terraformer
	yay -S yay

##### Install using pip

	mkdir -p ${HOME}/.local
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py --user
	pip install --user --upgrade pip
	pip install --user ansible
	pip install --user ansible-container
	pip install --user ansible-lint
	pip install --user autopep8
	pip install --user awscli
	pip install --user black
	pip install --user cheat
	pip install --user chromedriver-binary
	pip install --user diagrams
	pip install --user eralchemy
	pip install --user faker
	pip install --user flake8
	pip install --user graph-cli
	pip install --user importmagic
	pip install --user ipywidgets
	pip install --user jedi
	pip install --user jupyter
	pip install --user jupyterlab
	pip install --user jupyterthemes
	pip install --user litecli
	pip install --user matplotlib
	pip install --user mps-youtube
	pip install --user mycli
	pip install --user neovim
	pip install --user nose
	pip install --user opencv-python
	pip install --user pandas
	pip install --user pgcli
	pip install --user pipenv
	pip install --user poetry
	pip install --user pre-commit
	pip install --user progressbar2
	pip install --user psycopg2-binary
	pip install --user py-spy
	pip install --user pydoc_utils
	pip install --user pyflakes
	pip install --user pygments
	pip install --user pylint
	pip install --user python-language-server
	pip install --user r7insight_python
	pip install --user ranger-fm
	pip install --user redis
	pip install --user rope
	pip install --user rtv
	pip install --user scikit-learn
	pip install --user scipy
	pip install --user scrapy
	pip install --user seaborn
	pip install --user selenium
	pip install --user speedtest-cli
	pip install --user streamlink
	pip install --user termdown
	pip install --user tldr
	pip install --user tmuxp
	pip install --user trash-cli
	pip install --user truffleHog
	pip install --user virtualenv
	pip install --user virtualenvwrapper
	pip install --user yapf
	pip install --user youtube-dl

#### Install using golang

	mkdir -p ${HOME}/{bin,src}
	go install golang.org/x/tools/gopls@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/x-motemen/ghq@latest
	go install github.com/kyoshidajp/ghkw@latest
	go install github.com/simeji/jid/cmd/jid@latest
	go install github.com/jmhodges/jsonpp@latest
	go install github.com/mithrandie/csvq@latest

#### Install using yarn

	mkdir -p ${HOME}/.node_modules
	yarn global add babel-eslint
	yarn global add cloc
	yarn global add create-component-app
	yarn global add create-nuxt-app
	yarn global add create-react-app
	yarn global add dockerfile-language-server-nodejs
	yarn global add esbuild-linux-64
	yarn global add eslint
	yarn global add eslint-cli
	yarn global add eslint-config-vue
	yarn global add eslint-plugin-react
	yarn global add eslint-plugin-vue@next
	yarn global add expo-cli
	yarn global add firebase-tools
	yarn global add fx
	yarn global add gulp
	yarn global add	gulp-cli
	yarn global add heroku
	yarn global add indium
	yarn global add javascript-typescript-langserver
	yarn global add jshint
	yarn global add logo.svg
	yarn global add @marp-team/marp-cli
	yarn global add mermaid
	yarn global add mermaid.cli
	yarn global add netlify-cli
	yarn global add ngrok
	yarn global add now
	yarn global add prettier
	yarn global add parcel-bundler
	yarn global add @vue/cli
	yarn global add vue-language-server
	yarn global add vue-native-cli
	yarn global add webpack

#### Kubernetes

docker

	sudo pacman -S docker docker-compose
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.service

Google Kubernetes Engine

	curl https://sdk.cloud.google.com | bash
	test -L ${HOME}/.config/gcloud || rm -rf ${HOME}/.config/gcloud
	ln -vsfn ${HOME}/backup/gcloud   ${HOME}/.config/gcloud
	sudo pacman -S kubectl kubectx kustomize helm
	yay -S stern-bin

kind(Kubernetes IN Docker)

	go install sigs.k8s.io/kind@v0.14.0
	sudo sh -c "kind completion zsh > /usr/share/zsh/site-functions/_kind"

minikube with kvm2

	sudo pacman -S minikube libvirt qemu-headless ebtables docker-machine kubectx
	yay -S docker-machine-driver-kvm2
	sudo usermod -a -G libvirt ${USER}
	sudo systemctl start libvirtd.service
	sudo systemctl enable libvirtd.service
	sudo systemctl start virtlogd.service
	sudo systemctl enable virtlogd.service
	minikube config set vm-driver kvm2
	
#### rbenv rails

	yay -S rbenv
	yay -S ruby-build
	rbenv install 2.5.1

#### Install rust and language server

	sudo pacman -S rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src

# Terminal

![terminal](https://raw.githubusercontent.com/masasam/image/image/tmux.png)

Terminal uses urxvt

# TLP

Setting for power save and to prevent battery deterioration.

	sudo pacman -S tlp powertop
	sudo ln -vsf ${PWD}/etc/default/tlp /etc/default/tlp
	systemctl enable tlp.service
	systemctl enable tlp-sleep.service

![PowerTop](https://raw.githubusercontent.com/masasam/image/image/powertop.png)

# UEFI BIOS update with Linux

	sudo pacman -S fwupd dmidecode
	sudo dmidecode -s bios-version
	fwupdmgr refresh
	fwupdmgr get-updates
	fwupdmgr update

After you update the UEFI BIOS, you will need to reconfigure grub when next boot. Boot with arch linux usb memory and do as follows.
This work is not necessary after the second time.

	mount /dev/sda2 /mnt
	mount /dev/sda1 /mnt/boot
	arch-chroot /mnt /bin/bash
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck --debug
	grub-mkconfig -o /boot/grub/grub.cfg

# Enable DNS cache

Install dnsmasq

	sudo pacman -S dnsmasq

/etc/NetworkManager/NetworkManager.conf

	[main]
	dns=dnsmasq

When restarting NetworkManager, dnsmasq is set to be automatically usable.

	sudo systemctl restart NetworkManager

![dnsmasq](https://raw.githubusercontent.com/masasam/image/image/dnsmasq.png)

# Mozc

ibus-mozc

Make input sources mozc only for region and language.
My key setting is based on Kotoeri (closest to emacs key binding).

>「Input before conversion」「Shift+Space」「Disable IME」
>「Converting」「Shift+Space」「Disable IME」
>「Direct input」「Shift+Space」「Enable IME」
>「No input character」「Shift+Space」「Disable IME」
>Delete other Shift-space entangled shortcuts.
>「Converting」cansel Ctrl-g

reboot

Once mozc is set up

    ln -sfn ~/backup/mozc ~/.mozc

And set the mozc setting to backup directory.
With this it will not have to be set again.

    ibus-setup

Open the emoji tab
Since <Control>semicolon is set in the shortcut of emoji ruby, delete it.

## How to test Makefile

#### When using Makefile

Test this [Makefile](https://github.com/masasam/dotfiles/blob/master/Makefile) using docker

	make test

Test this [Makefile](https://github.com/masasam/dotfiles/blob/master/Makefile) using docker with backup directory

	make testbackup

#### When executing manually

1.Build this Dockerfile

	docker build -t dotfiles /home/${USER}/src/github.com/masasam/dotfiles

2.Run 'docker run' mounting the backup directory

	docker run -t -i -v /home/${USER}/backup:/home/${USER}/backup:cached --name arch dotfiles /bin/bash

3.Execute the following command in the docker container

	cd /home/${USER}/src/github.com/masasam/dotfiles
	make install
	make init
