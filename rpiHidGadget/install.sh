#!/usr/bin/env bash

RULE_NAME='rpi_device.rules'

USB_GADGET_NAME='g_rpi_hid_keyboard'

KERNEL_VERSION=$(uname -r | egrep -o '^[^-+]+')
if [ $KERNEL_VERSION = "5.10.11" ]; then
    echo "Kernel version is already setup"
else
    sudo apt update
    sudo SKIP_WARNING=1 rpi-update 43998c82a7e88df284b7aa30221b2d0d21b2b86a -y
    echo "Kernel version is successfully downgraded to 5.10.11"
fi

# Add "dtoverlay=dwc2" to `/boot/config.txt` if not existe
grep --quiet "^dtoverlay=dwc2$" /boot/config-5.15.63-sunxi
if [ $? -eq 1 ]; then
    echo "dtoverlay=dwc2" | sudo tee -a /boot/config-5.15.63-sunxi
fi
# Add "dwc2" to `/etc/modules` if not existe
grep --quiet "^dwc2$" /etc/modules
if [ $? -eq 1 ]
then
    echo "dwc2" | sudo tee -a /etc/modules
fi
# Add "libcomposite" to `/etc/modules` if not existe
grep --quiet "^libcomposite$" /etc/modules
if [ $? -eq 1 ]
then
    echo "libcomposite" | sudo tee -a /etc/modules
fi
echo "Successfully loaded the USB gadget drivers."

chmod +x ${USB_GADGET_NAME}
sudo cp ${USB_GADGET_NAME} /usr/bin/
# Insert line in /etc/rc.local, if needed
sudo sed -i '/\/usr\/bin\//d' /etc/rc.local
sudo sed -i '/^exit 0/i \/usr/bin/'${USB_GADGET_NAME} /etc/rc.local
echo "Successfully installed gadget descriptor."

sudo cp ${RULE_NAME} /etc/udev/rules.d/

echo "Rebooting RaspberryPi."
sleep 3
sudo reboot