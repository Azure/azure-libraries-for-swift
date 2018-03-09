[![Build Status](https://travis-ci.org/Azure/azure-libraries-for-java.svg?style=flat-square&label=build)](https://travis-ci.org/Azure/azure-libraries-for-java)

# Azure Management Libraries for Swift (BETA)


The Azure Management Libraries for Swift is a higher-level, object-oriented API for *managing* Azure resources, that is optimized for ease of use, succinctness and consistency.

## Table of contents
* [Feature availability](#feature-availability)
* [Code snippets and samples](#code-snippets-and-samples)
  * [Virtual machines](#virtual-machines)
* [Prerequisites](#prerequisites)
* [Help and issues](#help-and-issues)
* [Contribute code](#contribute-code)
* [More information](#more-information)

## Feature Availability

> This is a Preview release.  The goal for the preview is to be able to determine the community need for Azure management swift libraires and to get feedback from the community on the usability and approach of the current generated librairies. 

## Code snippets and samples

### Azure Authentication

To learn more about authentication in the Azure Libraries for Swift, see [AUTH.md](AUTH.md).

### Virtual Machines

#### Create a Virtual Machine

You can create a virtual machine instance by using a `define() … create()` method chain.

```swift
        let resourceGroupName = "swiftTestResourceGroup1"
        let vmName = "<vm name>"
        let osDiskName = "<os disk name>"
        let adminUsername = "<user name>"
        let adminPassword = "<password>"
        let computerName = "<computer name>"
        let nicId = "<id for nic>"
        var vmProperties = compute.DataFactory.createVirtualMachinePropertiesProtocol()
        
        var hardwareProfile  = compute.DataFactory.createHardwareProfileProtocol()
        hardwareProfile.vmSize = VirtualMachineSizeTypesEnum.VirtualMachineSizeTypesBasicA0
        vmProperties.hardwareProfile = hardwareProfile
        
        var networkProfile = compute.DataFactory.createNetworkProfileProtocol()
        networkProfile.networkInterfaces = [NetworkInterfaceReferenceProtocol?]()
        var networkInterface = compute.DataFactory.createNetworkInterfaceReferenceProtocol()
        networkInterface.id = nicId
        networkProfile.networkInterfaces?.append(networkInterface)
        vmProperties.networkProfile = networkProfile
        
        var storageProfile = compute.DataFactory.createStorageProfileProtocol();
        var imageReference = compute.DataFactory.createImageReferenceProtocol()
        imageReference.sku = "16.04-LTS"
        imageReference.publisher = "Canonical"
        imageReference.version = "latest"
        imageReference.offer = "UbuntuServer"
        storageProfile.imageReference = imageReference
        
        var osDisk = compute.DataFactory.createOSDiskProtocol(createOption: DiskCreateOptionTypesEnum.DiskCreateOptionTypesFromImage)
        osDisk.name = osDiskName
        osDisk.caching = CachingTypesEnum.CachingTypesReadWrite
        osDisk.managedDisk = compute.DataFactory.createManagedDiskParametersProtocol()
        osDisk.managedDisk?.storageAccountType = StorageAccountTypesEnum.StandardLRS
        storageProfile.osDisk = osDisk
        vmProperties.storageProfile = storageProfile
        
        var osProfile = compute.DataFactory.createOSProfileProtocol()
        osProfile = compute.DataFactory.createOSProfileProtocol()
        osProfile.adminUsername = adminUsername
        osProfile.adminPassword = adminPassword
        osProfile.computerName = computerName
        vmProperties.osProfile = osProfile
        
        var vm = compute.DataFactory.createVirtualMachineProtocol(location: "west us");
        vm.name = vmName
        vm.properties = vmProperties;
        
        let e = expectation(description: "Wait for HTTP request to complete")
        // This is an example of a functional test case.
        var command = compute.Commands.VirtualMachines.CreateOrUpdate(
            resourceGroupName: resourceGroupName,
            vmName: vm.name!,
            subscriptionId: applicationTokenCredentials.defaultSubscriptionId!,
            parameters: vm)
        command.execute(client: self.azureClient, completionHandler: {
            (resource, error) -> Void in
            e.fulfill()
            print("done");
        });
        
        waitForExpectations(timeout: 600, handler: nil)
```

## Prerequisites

- Swift 4
- Azure Service Principal - see [how to create authentication info](./AUTH.md).

## Help and Issues

If you encounter any bugs with these libraries, please file issues via [Issues](https://github.com/Azure/azure-libraries-for-swift/issues).

## Contribute Code

If you would like to become an active contributor to this project please follow the instructions provided in [Microsoft Azure Projects Contribution Guidelines](http://azure.github.io/guidelines.html).

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

---

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.