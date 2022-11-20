# Virtual HID keyboard Gadget for rpi

## report descriptor

> raw report descriptor

```bash
sudo usbhid-dump --entity=all --address=2:3
```

> spec report descriptor

```bash
sudo usbhid-dump -a2:3 -i0 | grep -v : | xxd -r -p | hidrd-convert -o spec
```

## Steps

- Downgraded kernel to version `5.10.11`.

- Add "dtoverlay=dwc2" to `/boot/config.txt` (`/boot/config-5.15.63-sunxi` on orange-pi).
- Add `libcomposite` and `dwc2` in `/etc/modules`.

- Make executable and copy `g_hid_keyboard` in `/usr/bin/`.
- Update or add `/usr/bin/g_hid_keyboard` in `/etc/rc.local`.

- Copy `rpi_device.rules` to `/etc/udev/rules.d/`.

- reboot
