// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct VirtualMachineScaleSetVMProfileData : VirtualMachineScaleSetVMProfileProtocol {
    public var osProfile: VirtualMachineScaleSetOSProfileProtocol?
    public var storageProfile: VirtualMachineScaleSetStorageProfileProtocol?
    public var networkProfile: VirtualMachineScaleSetNetworkProfileProtocol?
    public var diagnosticsProfile: DiagnosticsProfileProtocol?
    public var extensionProfile: VirtualMachineScaleSetExtensionProfileProtocol?
    public var licenseType: String?
    public var priority: VirtualMachinePriorityTypesEnum?

        enum CodingKeys: String, CodingKey {case osProfile = "osProfile"
        case storageProfile = "storageProfile"
        case networkProfile = "networkProfile"
        case diagnosticsProfile = "diagnosticsProfile"
        case extensionProfile = "extensionProfile"
        case licenseType = "licenseType"
        case priority = "priority"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.osProfile) {
        self.osProfile = try container.decode(VirtualMachineScaleSetOSProfileData?.self, forKey: .osProfile)
    }
    if container.contains(.storageProfile) {
        self.storageProfile = try container.decode(VirtualMachineScaleSetStorageProfileData?.self, forKey: .storageProfile)
    }
    if container.contains(.networkProfile) {
        self.networkProfile = try container.decode(VirtualMachineScaleSetNetworkProfileData?.self, forKey: .networkProfile)
    }
    if container.contains(.diagnosticsProfile) {
        self.diagnosticsProfile = try container.decode(DiagnosticsProfileData?.self, forKey: .diagnosticsProfile)
    }
    if container.contains(.extensionProfile) {
        self.extensionProfile = try container.decode(VirtualMachineScaleSetExtensionProfileData?.self, forKey: .extensionProfile)
    }
    if container.contains(.licenseType) {
        self.licenseType = try container.decode(String?.self, forKey: .licenseType)
    }
    if container.contains(.priority) {
        self.priority = try container.decode(VirtualMachinePriorityTypesEnum?.self, forKey: .priority)
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
    if self.osProfile != nil {try container.encode(self.osProfile as! VirtualMachineScaleSetOSProfileData?, forKey: .osProfile)}
    if self.storageProfile != nil {try container.encode(self.storageProfile as! VirtualMachineScaleSetStorageProfileData?, forKey: .storageProfile)}
    if self.networkProfile != nil {try container.encode(self.networkProfile as! VirtualMachineScaleSetNetworkProfileData?, forKey: .networkProfile)}
    if self.diagnosticsProfile != nil {try container.encode(self.diagnosticsProfile as! DiagnosticsProfileData?, forKey: .diagnosticsProfile)}
    if self.extensionProfile != nil {try container.encode(self.extensionProfile as! VirtualMachineScaleSetExtensionProfileData?, forKey: .extensionProfile)}
    if self.licenseType != nil {try container.encode(self.licenseType, forKey: .licenseType)}
    if self.priority != nil {try container.encode(self.priority, forKey: .priority)}
  }
}

extension DataFactory {
  public static func createVirtualMachineScaleSetVMProfileProtocol() -> VirtualMachineScaleSetVMProfileProtocol {
    return VirtualMachineScaleSetVMProfileData()
  }
}