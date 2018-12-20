sudo mkdir mount
sudo mount linux.iso mount
sudo mkdir kickstartBuild
rsync -av mount/ kickstartBuild
cp ks.cfg kickstartBuild
cp custom.seed kickstartBuild/preseed
echo "label install
  menu label ^AutoInstall
  kernel /install/vmlinuz
  append  file=/cdrom/preseed/custom.seed locale=en_US.UTF-8 keyboard-config/layoutcode=US initrd=/install/initrd.gz ks=cdrom:/ks.cfg ---
" >> kickstartBuild/isolinux/txt.cfg
cd kickstartBuild
sudo mkisofs -o desired/path/to/kickstart.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V kickstartInstall .
cd ..
mv kickstartBuild/kickstart.iso kickstart.iso
sudo umount mount
sudo rm -r mount
sudo rm -r kickstartBuild



