# kywy/devkit

This repo provides container tooling for local development and CI/CD pipelines for the Kywy project. The `devkit` image
is built on top of Espressif's `espressif/idf` container with a few extra tools installed for testing, linting, and also
building assets (e.g. font and image binary data).

## Local Setup

The goal here is to run everything in the `devkit` container to avoid having to fiddle with dependencies on your local
machine. We can make this happen for almost everything, but unfortunately there are still two main areas that require
local dependencies besides the `devkit` image.

### 1. Language Server

Your IDE's language server cannot access the ESP-IDF dependencies on the `devkit` image. While developing for Kywy you
will want to be able to see these files though as they are very helpful for understanding what is going on behind the
scenes.

Fortunately, this is a dependencies that you'll want to have installed anyway if you are developing _using_ Kywy (versus
developing Kywy itself). You can follow the ESP-IDF [Getting Started
Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/) to install the tool.

You will want to fulfil the following prerequisites:

1. Install the same version of the IDF that the `devkit` uses. You can find this version at the top of the
   [Dockerfile](Dockerfile).
1. Activate the IDF. On Mac/Linux this looks like `. $HOME/esp/esp-idf/export.sh`. You can find the instructions for
   this in the getting started guide as well. It's part of the basic ESP-IDF development workflow.
1. Make sure your `IDF_PATH` and `IDF_TOOLS_PATH` environment variables are up to date. These are required to remap
   dependency paths from the `devkit` container to your local machine when generating the compilation database for your
   IDE's language server.

### 2. Device Flashing/Monitoring

If you need to flash a Kywy repo to device, access to the USB port is not available by default. Fortunately there is a
workaround supplied by Espressif. Follow the documentation
[here](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/tools/idf-docker-image.html#using-remote-serial-port)
to flash via a remote serial port that's forwarded to the container.

Note that you will likely need to change the target device for the Telnet server. By default it's `/dev/ttyUSB0`, but
you can find the appropriate device by running `ls /dev` before and after your device is plugged in seeing what devices
are added. Sometimes there may be two devices added. E.g. on a Mac I see

```
>>> ls /dev
...
/dev/tty.usbserial-1420
/dev/tty.SLAB_USBtoUART
...
```

In this case `/dev/tty.SLAB_USBtoUART` was the proper device to use.
