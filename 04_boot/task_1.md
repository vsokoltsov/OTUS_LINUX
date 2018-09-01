## Select OS

During the boot, press any button and you will see this screen

![ØS select](./os_select.png)

Press `e` and the loader config will appeared

![Loader](./loader.png)

## rd.break

Add `rd.break` after line started with `linux16`

![RD break](./rd_break.png)

After that, press `Ctrl+X`, and you will see a bash terminal

![RD break result](./rd_break_result.png)

## init

Replace `ro` with `rw init=/sysroot/bin/sh` and remove `console=ttySO` in line `linux16`

![Boot init](./boot_init.png)

After that, you will see a bash terminal 

![Boot result](./boot_init_result.png)
