#/bin/sh
rawdisk="cfme-azure-5.7.0.17-1.raw"
vhddisk="cfme-azure-5.7.0.17-1.vhd"
MB=$((1024*1024))
rounded_size=$((($size/$MB + 1)*$MB))
size=$(qemu-img info -f raw --output json "$rawdisk" | gawk 'match($0, /"virtual-size": ([0-9]+),/, val) {print val[1]}')
rounded_size=$((($size/$MB + 1)*$MB))
qemu-img resize -f raw "$rawdisk" $rounded_size
qemu-img convert -f raw -o subformat=fixed,force_size -O vpc "$rawdisk" "$vhddisk"
