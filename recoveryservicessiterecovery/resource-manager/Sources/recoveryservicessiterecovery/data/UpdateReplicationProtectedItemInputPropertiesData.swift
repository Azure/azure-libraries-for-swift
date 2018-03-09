// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct UpdateReplicationProtectedItemInputPropertiesData : UpdateReplicationProtectedItemInputPropertiesProtocol {
    public var recoveryAzureVMName: String?
    public var recoveryAzureVMSize: String?
    public var selectedRecoveryAzureNetworkId: String?
    public var selectedSourceNicId: String?
    public var enableRdpOnTargetOption: String?
    public var vmNics: [VMNicInputDetailsProtocol?]?
    public var licenseType: LicenseTypeEnum?
    public var recoveryAvailabilitySetId: String?
    public var providerSpecificDetails: UpdateReplicationProtectedItemProviderInputProtocol?

        enum CodingKeys: String, CodingKey {case recoveryAzureVMName = "recoveryAzureVMName"
        case recoveryAzureVMSize = "recoveryAzureVMSize"
        case selectedRecoveryAzureNetworkId = "selectedRecoveryAzureNetworkId"
        case selectedSourceNicId = "selectedSourceNicId"
        case enableRdpOnTargetOption = "enableRdpOnTargetOption"
        case vmNics = "vmNics"
        case licenseType = "licenseType"
        case recoveryAvailabilitySetId = "recoveryAvailabilitySetId"
        case providerSpecificDetails = "providerSpecificDetails"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.recoveryAzureVMName) {
        self.recoveryAzureVMName = try container.decode(String?.self, forKey: .recoveryAzureVMName)
    }
    if container.contains(.recoveryAzureVMSize) {
        self.recoveryAzureVMSize = try container.decode(String?.self, forKey: .recoveryAzureVMSize)
    }
    if container.contains(.selectedRecoveryAzureNetworkId) {
        self.selectedRecoveryAzureNetworkId = try container.decode(String?.self, forKey: .selectedRecoveryAzureNetworkId)
    }
    if container.contains(.selectedSourceNicId) {
        self.selectedSourceNicId = try container.decode(String?.self, forKey: .selectedSourceNicId)
    }
    if container.contains(.enableRdpOnTargetOption) {
        self.enableRdpOnTargetOption = try container.decode(String?.self, forKey: .enableRdpOnTargetOption)
    }
    if container.contains(.vmNics) {
        self.vmNics = try container.decode([VMNicInputDetailsData?]?.self, forKey: .vmNics)
    }
    if container.contains(.licenseType) {
        self.licenseType = try container.decode(LicenseTypeEnum?.self, forKey: .licenseType)
    }
    if container.contains(.recoveryAvailabilitySetId) {
        self.recoveryAvailabilitySetId = try container.decode(String?.self, forKey: .recoveryAvailabilitySetId)
    }
    if container.contains(.providerSpecificDetails) {
        self.providerSpecificDetails = try container.decode(UpdateReplicationProtectedItemProviderInputData?.self, forKey: .providerSpecificDetails)
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
    if self.recoveryAzureVMName != nil {try container.encode(self.recoveryAzureVMName, forKey: .recoveryAzureVMName)}
    if self.recoveryAzureVMSize != nil {try container.encode(self.recoveryAzureVMSize, forKey: .recoveryAzureVMSize)}
    if self.selectedRecoveryAzureNetworkId != nil {try container.encode(self.selectedRecoveryAzureNetworkId, forKey: .selectedRecoveryAzureNetworkId)}
    if self.selectedSourceNicId != nil {try container.encode(self.selectedSourceNicId, forKey: .selectedSourceNicId)}
    if self.enableRdpOnTargetOption != nil {try container.encode(self.enableRdpOnTargetOption, forKey: .enableRdpOnTargetOption)}
    if self.vmNics != nil {try container.encode(self.vmNics as! [VMNicInputDetailsData?]?, forKey: .vmNics)}
    if self.licenseType != nil {try container.encode(self.licenseType, forKey: .licenseType)}
    if self.recoveryAvailabilitySetId != nil {try container.encode(self.recoveryAvailabilitySetId, forKey: .recoveryAvailabilitySetId)}
    if self.providerSpecificDetails != nil {try container.encode(self.providerSpecificDetails as! UpdateReplicationProtectedItemProviderInputData?, forKey: .providerSpecificDetails)}
  }
}

extension DataFactory {
  public static func createUpdateReplicationProtectedItemInputPropertiesProtocol() -> UpdateReplicationProtectedItemInputPropertiesProtocol {
    return UpdateReplicationProtectedItemInputPropertiesData()
  }
}