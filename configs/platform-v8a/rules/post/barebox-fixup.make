# Firmware blobs for Rockchip platforms
BAREBOX_INJECT_FILES	+= rk3568_bl31_v1.24.elf:firmware/rk3568-bl31.bin
BAREBOX_INJECT_FILES	+= rk3568_bl32_v1.05.bin:firmware/rk3568-op-tee.bin
BAREBOX_INJECT_FILES	+= rk3568_ddr_1560MHz_v1.08.bin:arch/arm/boards/rockchip-rk3568-evb/sdram-init.bin
BAREBOX_INJECT_FILES	+= rk3568_ddr_1560MHz_v1.08.bin:arch/arm/boards/radxa-rock3/sdram-init.bin
BAREBOX_PROGS_HOST	+= rk-usb-loader

# Firmware blobs for NXP i.MX8M platforms
BAREBOX_INJECT_FILES	+= imx8mm-bl31.bin:firmware/imx8mm-bl31.bin
BAREBOX_INJECT_FILES	+= imx8mp-bl31.bin:firmware/imx8mp-bl31.bin
BAREBOX_INJECT_FILES	+= imx8mq-bl31.bin:firmware/imx8mq-bl31.bin
BAREBOX_INJECT_FILES	+= ddr/synopsys/lpddr4_pmu_train_1d_dmem.bin:firmware/lpddr4_pmu_train_1d_dmem.bin
BAREBOX_INJECT_FILES	+= ddr/synopsys/lpddr4_pmu_train_1d_imem.bin:firmware/lpddr4_pmu_train_1d_imem.bin
BAREBOX_INJECT_FILES	+= ddr/synopsys/lpddr4_pmu_train_2d_dmem.bin:firmware/lpddr4_pmu_train_2d_dmem.bin
BAREBOX_INJECT_FILES	+= ddr/synopsys/lpddr4_pmu_train_2d_imem.bin:firmware/lpddr4_pmu_train_2d_imem.bin
BAREBOX_PROGS_HOST	+= imx/imx-usb-loader
