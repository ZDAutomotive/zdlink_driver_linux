#!/bin/sh

# install zd-link1000 linux kernel driver

path=$(uname -r)
ZDLINK_DRIVER_FILE_compliant="zdlink-compliant.ko"
ZDLINK_DRIVER_FILE_legacy="zdlink-legacy.ko"
KERNEL_DRIVER_MODULE="lan78xx.ko"
KERNEL_DRIVER_BACKUP="lan78xx.ubuntu"

KERNEL_DRIVE_PATH="/lib/modules/"$(uname -r)"/kernel/drivers/net/usb/"


echo
echo "******* Installation of zd-link1000 kernel driver by ZD-Automotive GmbH *******"
echo "Notice: Before installation, disconnect zd-link1000 usb cable"
echo "        It's ok if rmmod implies Module is not currently loaded"
echo

if [ -d $path ] ; then
    echo "current linux kernel version $path"
else 
    echo "no driver found for current kernel version $path"
    echo "please goto https://github.com/ZDAutomotive/zdlink_driver_linux/releases to download latest driver"
    exit 1
fi

if [ -z $1 ] ; then
    echo "installing compliant driver..."


    sudo rmmod ${KERNEL_DRIVER_MODULE}
    if [ -f ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_BACKUP} ] ; then
        echo "ubuntu system driver is backuped"
    else 
        sudo mv -n ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_MODULE} ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_BACKUP}
    fi
    sudo cp -f $path/${ZDLINK_DRIVER_FILE_compliant} ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_MODULE}

    printf "OK: zd-link1000 driver(compliant) is installed to ${KERNEL_DRIVE_PATH}\n"
    printf "OK: ubuntu system driver is backuped as <${KERNEL_DRIVER_BACKUP}>\n"

elif [ $1 == '--legacy' ]; then
    echo "installing legacy driver..."
    echo "current linux kernel version $path"

    sudo rmmod ${KERNEL_DRIVER_MODULE}
    if [ -f ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_BACKUP} ] ; then
        echo "ubuntu system driver is backuped"
    else 
        sudo mv -n ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_MODULE} ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_BACKUP}
    fi

    sudo cp -f $path/${ZDLINK_DRIVER_FILE_legacy} ${KERNEL_DRIVE_PATH}${KERNEL_DRIVER_MODULE}

    printf "OK: zd-link1000 driver(legacy) is installed to ${KERNEL_DRIVE_PATH}\n"
    printf "OK: ubuntu system driver is backuped as <${KERNEL_DRIVER_BACKUP}>\n"
    
else 
    echo "wrong argument, using --legacy to install driver for legacy mode"
fi



