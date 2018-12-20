sudo mkdir mount
sudo mount linux.iso mount
sudo mkdir kickstartBuild
rsync -av mount/ kickstartBuild
cp ks.cfg kickstartBuild
echo "label ks
  menu label ^Kickstart
  menu default
  kernel vmlinuz
  append initrd=initrd.img inst.stage2=hd:LABEL=CentOS\x207\x20x86_64 inst.ks=cdrom:/dev/cdrom:/ks.cfg ip=dhcp" >> kickstartBuild/isolinux/isolinux.cfg
cd kickstartBuild
sudo mkisofs -o kickstart.iso -b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -V "CentOS 7 x86_64" -R -J -v -T isolinux/. .
cd ..
mv kickstartBuild/kickstart.iso kickstart.iso
sudo umount mount
sudo rm -r mount
sudo rm -r kickstartBuild



