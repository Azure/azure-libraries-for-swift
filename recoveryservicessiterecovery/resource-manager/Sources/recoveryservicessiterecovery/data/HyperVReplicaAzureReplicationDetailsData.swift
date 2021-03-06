// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct HyperVReplicaAzureReplicationDetailsData : HyperVReplicaAzureReplicationDetailsProtocol, ReplicationProviderSpecificSettingsProtocol {
    public var azureVmDiskDetails: [AzureVmDiskDetailsProtocol?]?
    public var recoveryAzureVmName: String?
    public var recoveryAzureVMSize: String?
    public var recoveryAzureStorageAccount: String?
    public var recoveryAzureLogStorageAccountId: String?
    public var lastReplicatedTime: Date?
    public var rpoInSeconds: Int64?
    public var lastRpoCalculatedTime: Date?
    public var vmId: String?
    public var vmProtectionState: String?
    public var vmProtectionStateDescription: String?
    public var initialReplicationDetails: InitialReplicationDetailsProtocol?
    public var vmNics: [VMNicDetailsProtocol?]?
    public var selectedRecoveryAzureNetworkId: String?
    public var selectedSourceNicId: String?
    public var encryption: String?
    public var oSDetails: OSDetailsProtocol?
    public var sourceVmRamSizeInMB: Int32?
    public var sourceVmCpuCount: Int32?
    public var enableRdpOnTargetOption: String?
    public var recoveryAzureResourceGroupId: String?
    public var recoveryAvailabilitySetId: String?
    public var useManagedDisks: String?
    public var licenseType: String?

        enum CodingKeys: String, CodingKey {case azureVmDiskDetails = "azureVmDiskDetails"
        case recoveryAzureVmName = "recoveryAzureVmName"
        case recoveryAzureVMSize = "recoveryAzureVMSize"
        case recoveryAzureStorageAccount = "recoveryAzureStorageAccount"
        case recoveryAzureLogStorageAccountId = "recoveryAzureLogStorageAccountId"
        case lastReplicatedTime = "lastReplicatedTime"
        case rpoInSeconds = "rpoInSeconds"
        case lastRpoCalculatedTime = "lastRpoCalculatedTime"
        case vmId = "vmId"
        case vmProtectionState = "vmProtectionState"
        case vmProtectionStateDescription = "vmProtectionStateDescription"
        case initialReplicationDetails = "initialReplicationDetails"
        case vmNics = "vmNics"
        case selectedRecoveryAzureNetworkId = "selectedRecoveryAzureNetworkId"
        case selectedSourceNicId = "selectedSourceNicId"
        case encryption = "encryption"
        case oSDetails = "oSDetails"
        case sourceVmRamSizeInMB = "sourceVmRamSizeInMB"
        case sourceVmCpuCount = "sourceVmCpuCount"
        case enableRdpOnTargetOption = "enableRdpOnTargetOption"
        case recoveryAzureResourceGroupId = "recoveryAzureResourceGroupId"
        case recoveryAvailabilitySetId = "recoveryAvailabilitySetId"
        case useManagedDisks = "useManagedDisks"
        case licenseType = "licenseType"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.azureVmDiskDetails) {
        self.azureVmDiskDetails = try container.decode([AzureVmDiskDetailsData?]?.self, forKey: .azureVmDiskDetails)
    }
    if container.contains(.recoveryAzureVmName) {
        self.recoveryAzureVmName = try container.decode(String?.self, forKey: .recoveryAzureVmName)
    }
    if container.contains(.recoveryAzureVMSize) {
        self.recoveryAzureVMSize = try container.decode(String?.self, forKey: .recoveryAzureVMSize)
    }
    if container.contains(.recoveryAzureStorageAccount) {
        self.recoveryAzureStorageAccount = try container.decode(String?.self, forKey: .recoveryAzureStorageAccount)
    }
    if container.contains(.recoveryAzureLogStorageAccountId) {
        self.recoveryAzureLogStorageAccountId = try container.decode(String?.self, forKey: .recoveryAzureLogStorageAccountId)
    }
    if container.contains(.lastReplicatedTime) {
        self.lastReplicatedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastReplicatedTime)), format: .dateTime)
    }
    if container.contains(.rpoInSeconds) {
        self.rpoInSeconds = try container.decode(Int64?.self, forKey: .rpoInSeconds)
    }
    if container.contains(.lastRpoCalculatedTime) {
        self.lastRpoCalculatedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastRpoCalculatedTime)), format: .dateTime)
    }
    if container.contains(.vmId) {
        self.vmId = try container.decode(String?.self, forKey: .vmId)
    }
    if container.contains(.vmProtectionState) {
        self.vmProtectionState = try container.decode(String?.self, forKey: .vmProtectionState)
    }
    if container.contains(.vmProtectionStateDescription) {
        self.vmProtectionStateDescription = try container.decode(String?.self, forKey: .vmProtectionStateDescription)
    }
    if container.contains(.initialReplicationDetails) {
        self.initialReplicationDetails = try container.decode(InitialReplicationDetailsData?.self, forKey: .initialReplicationDetails)
    }
    if container.contains(.vmNics) {
        self.vmNics = try container.decode([VMNicDetailsData?]?.self, forKey: .vmNics)
    }
    if container.contains(.selectedRecoveryAzureNetworkId) {
        self.selectedRecoveryAzureNetworkId = try container.decode(String?.self, forKey: .selectedRecoveryAzureNetworkId)
    }
    if container.contains(.selectedSourceNicId) {
        self.selectedSourceNicId = try container.decode(String?.self, forKey: .selectedSourceNicId)
    }
    if container.contains(.encryption) {
        self.encryption = try container.decode(String?.self, forKey: .encryption)
    }
    if container.contains(.oSDetails) {
        self.oSDetails = try container.decode(OSDetailsData?.self, forKey: .oSDetails)
    }
    if container.contains(.sourceVmRamSizeInMB) {
        self.sourceVmRamSizeInMB = try container.decode(Int32?.self, forKey: .sourceVmRamSizeInMB)
    }
    if container.contains(.sourceVmCpuCount) {
        self.sourceVmCpuCount = try container.decode(Int32?.self, forKey: .sourceVmCpuCount)
    }
    if container.contains(.enableRdpOnTargetOption) {
        self.enableRdpOnTargetOption = try container.decode(String?.self, forKey: .enableRdpOnTargetOption)
    }
    if container.contains(.recoveryAzureResourceGroupId) {
        self.recoveryAzureResourceGroupId = try container.decode(String?.self, forKey: .recoveryAzureResourceGroupId)
    }
    if container.contains(.recoveryAvailabilitySetId) {
        self.recoveryAvailabilitySetId = try container.decode(String?.self, forKey: .recoveryAvailabilitySetId)
    }
    if container.contains(.useManagedDisks) {
        self.useManagedDisks = try container.decode(String?.self, forKey: .useManagedDisks)
    }
    if container.contains(.licenseType) {
        self.licenseType = try container.decode(String?.self, forKey: .licenseType)
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
    if self.azureVmDiskDetails != nil {try container.encode(self.azureVmDiskDetails as! [AzureVmDiskDetailsData?]?, forKey: .azureVmDiskDetails)}
    if self.recoveryAzureVmName != nil {try container.encode(self.recoveryAzureVmName, forKey: .recoveryAzureVmName)}
    if self.recoveryAzureVMSize != nil {try container.encode(self.recoveryAzureVMSize, forKey: .recoveryAzureVMSize)}
    if self.recoveryAzureStorageAccount != nil {try container.encode(self.recoveryAzureStorageAccount, forKey: .recoveryAzureStorageAccount)}
    if self.recoveryAzureLogStorageAccountId != nil {try container.encode(self.recoveryAzureLogStorageAccountId, forKey: .recoveryAzureLogStorageAccountId)}
    if self.lastReplicatedTime != nil {
        try container.encode(DateConverter.toString(date: self.lastReplicatedTime!, format: .dateTime), forKey: .lastReplicatedTime)
    }
    if self.rpoInSeconds != nil {try container.encode(self.rpoInSeconds, forKey: .rpoInSeconds)}
    if self.lastRpoCalculatedTime != nil {
        try container.encode(DateConverter.toString(date: self.lastRpoCalculatedTime!, format: .dateTime), forKey: .lastRpoCalculatedTime)
    }
    if self.vmId != nil {try container.encode(self.vmId, forKey: .vmId)}
    if self.vmProtectionState != nil {try container.encode(self.vmProtectionState, forKey: .vmProtectionState)}
    if self.vmProtectionStateDescription != nil {try container.encode(self.vmProtectionStateDescription, forKey: .vmProtectionStateDescription)}
    if self.initialReplicationDetails != nil {try container.encode(self.initialReplicationDetails as! InitialReplicationDetailsData?, forKey: .initialReplicationDetails)}
    if self.vmNics != nil {try container.encode(self.vmNics as! [VMNicDetailsData?]?, forKey: .vmNics)}
    if self.selectedRecoveryAzureNetworkId != nil {try container.encode(self.selectedRecoveryAzureNetworkId, forKey: .selectedRecoveryAzureNetworkId)}
    if self.selectedSourceNicId != nil {try container.encode(self.selectedSourceNicId, forKey: .selectedSourceNicId)}
    if self.encryption != nil {try container.encode(self.encryption, forKey: .encryption)}
    if self.oSDetails != nil {try container.encode(self.oSDetails as! OSDetailsData?, forKey: .oSDetails)}
    if self.sourceVmRamSizeInMB != nil {try container.encode(self.sourceVmRamSizeInMB, forKey: .sourceVmRamSizeInMB)}
    if self.sourceVmCpuCount != nil {try container.encode(self.sourceVmCpuCount, forKey: .sourceVmCpuCount)}
    if self.enableRdpOnTargetOption != nil {try container.encode(self.enableRdpOnTargetOption, forKey: .enableRdpOnTargetOption)}
    if self.recoveryAzureResourceGroupId != nil {try container.encode(self.recoveryAzureResourceGroupId, forKey: .recoveryAzureResourceGroupId)}
    if self.recoveryAvailabilitySetId != nil {try container.encode(self.recoveryAvailabilitySetId, forKey: .recoveryAvailabilitySetId)}
    if self.useManagedDisks != nil {try container.encode(self.useManagedDisks, forKey: .useManagedDisks)}
    if self.licenseType != nil {try container.encode(self.licenseType, forKey: .licenseType)}
  }
}

extension DataFactory {
  public static func createHyperVReplicaAzureReplicationDetailsProtocol() -> HyperVReplicaAzureReplicationDetailsProtocol {
    return HyperVReplicaAzureReplicationDetailsData()
  }
}
