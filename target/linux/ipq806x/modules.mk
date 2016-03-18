define KernelPackage/usb-phy-qcom-dwc3
  TITLE:=DWC3 USB QCOM PHY driver
  DEPENDS:=@TARGET_ipq806x
  KCONFIG:= CONFIG_PHY_QCOM_DWC3
  FILES:= $(LINUX_DIR)/drivers/phy/phy-qcom-dwc3.ko
  AUTOLOAD:=$(call AutoLoad,45,phy-qcom-dwc3,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-phy-qcom-dwc3/description
 This driver provides support for the integrated DesignWare
 USB3 IP Core within the QCOM SoCs.
endef

$(eval $(call KernelPackage,usb-phy-qcom-dwc3))


define KernelPackage/usb-dwc3-qcom
  TITLE:=DWC3 USB QCOM controller driver
  DEPENDS:=@TARGET_ipq806x +kmod-usb-dwc3 +kmod-usb-phy-qcom-dwc3
  KCONFIG:= CONFIG_USB_DWC3_QCOM
  FILES:= $(LINUX_DIR)/drivers/usb/dwc3/dwc3-qcom.ko
  AUTOLOAD:=$(call AutoLoad,53,dwc3-qcom,1)
  $(call AddDepends/usb)
endef

define KernelPackage/usb-dwc3-qcom/description
 This driver provides support for the integrated DesignWare
 USB3 IP Core within the QCOM SoCs.
endef

$(eval $(call KernelPackage,usb-dwc3-qcom))


define KernelPackage/mangle-bootargs-atag-dtb
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Mangle Bootargs for dual boot
  KCONFIG:= \
		CONFIG_MANGLE_BOOTARGS_ATAG_DTB=y \
		CONFIG_ARM_ATAG_DTB_COMPAT=y \
		CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y	
endef

define KernelPackage/mangle-bootargs-atag-dtb/description
This option enables reading bootloader supplied bootargs and
append them to the DTB as a new key (bootloader-args), so that
they are known but won't break the automatisms OpenWrt uses.
It appends to the kernel command line the mumber of the mtd partition
that has to be set as root (this is needed for the dual boot mechanism)
using the option mangled_rootblock=XX
Needs the following options to be set in Kernel config
		CONFIG_ARM_ATAG_DTB_COMPAT=y 
		CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y	
endef

$(eval $(call KernelPackage,mangle-bootargs-atag-dtb))
