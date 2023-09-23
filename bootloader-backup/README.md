# Bootloader backup

According to [Fedora's wiki](https://fedoraproject.org/wiki/Architectures/RISC-V/Allwinner#U-boot), the
bootloader part will be at most (32MB - 8KB) long. I copied the bootloader from the official image using
the command below:

```bash
dd if=system-image.img bs=1024 skip=8 count=32760 | xz > backup.bin.xz
# or, maybe faster
# dd if=system-image.img bs=8192 skip=1 count=4095 | xz > backup.bin.xz
```

To restore the bootloader, use the command below:

__WARNING: you have to make sure all of your partitions starts after 32MB!__

```bash
xzcat backup.bin.xz | dd of=/path/to/sdX bs=8192 seek=1
```
