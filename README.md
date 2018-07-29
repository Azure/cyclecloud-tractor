
# Tractor

CycleCloud project for the Pixar Tractor render farm job queue and work distribution system.

See the [Tractor project site](https://rmanwiki.pixar.com/display/TRA/Tractor+2) for an overview.

This [Project](https://docs.microsoft.com/en-us/azure/cyclecloud/projects) installs Tractor, itself, and configures the Tractor UI on the Master/Engine node.   In general, a Renderer (such as [Blender](https://github.com/Azure/cyclecloud-blender) must be installed on top of Tractor as an additional cluster-init project.

## Getting Tractor

To use the Tractor cluster type, you must first (download)[https://renderman.pixar.com/forum/download.php] the binaries (both Tractor and the PixarLicenseServer contained in the "License Utilities" bundle, and obtain a license serial number from (Pixar)[https://renderman.pixar.com/store].

## Pixar License Server

Use of Tractor requires a license server with a valid license file.
Once you receive your license serial number, you will have to generate a license file and configure a license server host.

First, install the license server on the license server host:

``` bash
sudo su - 
cd /tmp
rpm -ivh /tmp/PixarLicense-LA-21.0_1634130-linuxRHEL6_gcc44icc150.x86_64.rpm

```

Next use the license tool to obtain your hostid:
``` bash
cd /opt/pixar/PixarLicense-LA-21.0/
./PixarLicenseServer -hostid
Pixar RenderMan host identifier: ip-xxxxx 000d123abcd

```
In this example, you will use hostname: `ip-xxxxx` and hostid: `000d123abcd` to generate your license in the next step.

Now, go to the (Pixar license generator)[https://renderman.pixar.com/forum/entitlement.php] and enter your license server details from above.   This should result in a `pixar.license` file being downloaded.  Copy that `pixar.license` file to `/opt/pixar/pixar.license` on your license server.

Finally, install and start the license server as a linux service:

``` bash
cd /opt/pixar/PixarLicense-LA-21.0/
./linux_installService.sh

```

If the license server starts successfully, it should log to `/var/tmp/PixarLicenseServer.log`.
To verify, run:

``` bash
systemctl status pixarlicenseserver
```



# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
