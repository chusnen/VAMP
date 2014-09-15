mkdir /Volumes/tmp
vagrant up
defaults write com.apple.finder ShowMountedServersOnDesktop 1
/usr/local/bin/sshfs vagrant@192.168.44.44:/var/www/ /Volumes/tmp -ovolname=vagrant,reconnect -ocache=no -onolocalcaches 
