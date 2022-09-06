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
