// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct VirtualMachineScaleSetOSDiskData : VirtualMachineScaleSetOSDiskProtocol {
    public var name: String?
    public var caching: CachingTypesEnum?
    public var writeAcceleratorEnabled: Bool?
    public var createOption: DiskCreateOptionTypesEnum
    public var osType: OperatingSystemTypesEnum?
    public var image: VirtualHardDiskProtocol?
    public var vhdContainers: [String]?
    public var managedDisk: VirtualMachineScaleSetManagedDiskParametersProtocol?

        enum CodingKeys: String, CodingKey {case name = "name"
        case caching = "caching"
        case writeAcceleratorEnabled = "writeAcceleratorEnabled"
        case createOption = "createOption"
        case osType = "osType"
        case image = "image"
        case vhdContainers = "vhdContainers"
        case managedDisk = "managedDisk"
        }

  public init(createOption: DiskCreateOptionTypesEnum)  {
    self.createOption = createOption
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.caching) {
        self.caching = try container.decode(CachingTypesEnum?.self, forKey: .caching)
    }
    if container.contains(.writeAcceleratorEnabled) {
        self.writeAcceleratorEnabled = try container.decode(Bool?.self, forKey: .writeAcceleratorEnabled)
    }
    self.createOption = try container.decode(DiskCreateOptionTypesEnum.self, forKey: .createOption)
    if container.contains(.osType) {
        self.osType = try container.decode(OperatingSystemTypesEnum?.self, forKey: .osType)
    }
    if container.contains(.image) {
        self.image = try container.decode(VirtualHardDiskData?.self, forKey: .image)
    }
    if container.contains(.vhdContainers) {
        self.vhdContainers = try container.decode([String]?.self, forKey: .vhdContainers)
    }
    if container.contains(.managedDisk) {
        self.managedDisk = try container.decode(VirtualMachineScaleSetManagedDiskParametersData?.self, forKey: .managedDisk)
    }
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.name != nil {try container.encode(self.name, forKey: .name)}
    if self.caching != nil {try container.encode(self.caching, forKey: .caching)}
    if self.writeAcceleratorEnabled != nil {try container.encode(self.writeAcceleratorEnabled, forKey: .writeAcceleratorEnabled)}
    try container.encode(self.createOption, forKey: .createOption)
    if self.osType != nil {try container.encode(self.osType, forKey: .osType)}
    if self.image != nil {try container.encode(self.image as! VirtualHardDiskData?, forKey: .image)}
    if self.vhdContainers != nil {try container.encode(self.vhdContainers as! [String]?, forKey: .vhdContainers)}
    if self.managedDisk != nil {try container.encode(self.managedDisk as! VirtualMachineScaleSetManagedDiskParametersData?, forKey: .managedDisk)}
  }
}

extension DataFactory {
  public static func createVirtualMachineScaleSetOSDiskProtocol(createOption: DiskCreateOptionTypesEnum) -> VirtualMachineScaleSetOSDiskProtocol {
    return VirtualMachineScaleSetOSDiskData(createOption: createOption)
  }
}
