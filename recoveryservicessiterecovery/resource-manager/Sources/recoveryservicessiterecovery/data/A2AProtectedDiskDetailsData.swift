// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct A2AProtectedDiskDetailsData : A2AProtectedDiskDetailsProtocol {
    public var diskUri: String?
    public var recoveryAzureStorageAccountId: String?
    public var primaryDiskAzureStorageAccountId: String?
    public var recoveryDiskUri: String?
    public var diskName: String?
    public var diskCapacityInBytes: Int64?
    public var primaryStagingAzureStorageAccountId: String?
    public var diskType: String?
    public var resyncRequired: Bool?
    public var monitoringPercentageCompletion: Int32?
    public var monitoringJobType: String?
    public var dataPendingInStagingStorageAccountInMB: Double?
    public var dataPendingAtSourceAgentInMB: Double?

        enum CodingKeys: String, CodingKey {case diskUri = "diskUri"
        case recoveryAzureStorageAccountId = "recoveryAzureStorageAccountId"
        case primaryDiskAzureStorageAccountId = "primaryDiskAzureStorageAccountId"
        case recoveryDiskUri = "recoveryDiskUri"
        case diskName = "diskName"
        case diskCapacityInBytes = "diskCapacityInBytes"
        case primaryStagingAzureStorageAccountId = "primaryStagingAzureStorageAccountId"
        case diskType = "diskType"
        case resyncRequired = "resyncRequired"
        case monitoringPercentageCompletion = "monitoringPercentageCompletion"
        case monitoringJobType = "monitoringJobType"
        case dataPendingInStagingStorageAccountInMB = "dataPendingInStagingStorageAccountInMB"
        case dataPendingAtSourceAgentInMB = "dataPendingAtSourceAgentInMB"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.diskUri) {
        self.diskUri = try container.decode(String?.self, forKey: .diskUri)
    }
    if container.contains(.recoveryAzureStorageAccountId) {
        self.recoveryAzureStorageAccountId = try container.decode(String?.self, forKey: .recoveryAzureStorageAccountId)
    }
    if container.contains(.primaryDiskAzureStorageAccountId) {
        self.primaryDiskAzureStorageAccountId = try container.decode(String?.self, forKey: .primaryDiskAzureStorageAccountId)
    }
    if container.contains(.recoveryDiskUri) {
        self.recoveryDiskUri = try container.decode(String?.self, forKey: .recoveryDiskUri)
    }
    if container.contains(.diskName) {
        self.diskName = try container.decode(String?.self, forKey: .diskName)
    }
    if container.contains(.diskCapacityInBytes) {
        self.diskCapacityInBytes = try container.decode(Int64?.self, forKey: .diskCapacityInBytes)
    }
    if container.contains(.primaryStagingAzureStorageAccountId) {
        self.primaryStagingAzureStorageAccountId = try container.decode(String?.self, forKey: .primaryStagingAzureStorageAccountId)
    }
    if container.contains(.diskType) {
        self.diskType = try container.decode(String?.self, forKey: .diskType)
    }
    if container.contains(.resyncRequired) {
        self.resyncRequired = try container.decode(Bool?.self, forKey: .resyncRequired)
    }
    if container.contains(.monitoringPercentageCompletion) {
        self.monitoringPercentageCompletion = try container.decode(Int32?.self, forKey: .monitoringPercentageCompletion)
    }
    if container.contains(.monitoringJobType) {
        self.monitoringJobType = try container.decode(String?.self, forKey: .monitoringJobType)
    }
    if container.contains(.dataPendingInStagingStorageAccountInMB) {
        self.dataPendingInStagingStorageAccountInMB = try container.decode(Double?.self, forKey: .dataPendingInStagingStorageAccountInMB)
    }
    if container.contains(.dataPendingAtSourceAgentInMB) {
        self.dataPendingAtSourceAgentInMB = try container.decode(Double?.self, forKey: .dataPendingAtSourceAgentInMB)
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
    if self.diskUri != nil {try container.encode(self.diskUri, forKey: .diskUri)}
    if self.recoveryAzureStorageAccountId != nil {try container.encode(self.recoveryAzureStorageAccountId, forKey: .recoveryAzureStorageAccountId)}
    if self.primaryDiskAzureStorageAccountId != nil {try container.encode(self.primaryDiskAzureStorageAccountId, forKey: .primaryDiskAzureStorageAccountId)}
    if self.recoveryDiskUri != nil {try container.encode(self.recoveryDiskUri, forKey: .recoveryDiskUri)}
    if self.diskName != nil {try container.encode(self.diskName, forKey: .diskName)}
    if self.diskCapacityInBytes != nil {try container.encode(self.diskCapacityInBytes, forKey: .diskCapacityInBytes)}
    if self.primaryStagingAzureStorageAccountId != nil {try container.encode(self.primaryStagingAzureStorageAccountId, forKey: .primaryStagingAzureStorageAccountId)}
    if self.diskType != nil {try container.encode(self.diskType, forKey: .diskType)}
    if self.resyncRequired != nil {try container.encode(self.resyncRequired, forKey: .resyncRequired)}
    if self.monitoringPercentageCompletion != nil {try container.encode(self.monitoringPercentageCompletion, forKey: .monitoringPercentageCompletion)}
    if self.monitoringJobType != nil {try container.encode(self.monitoringJobType, forKey: .monitoringJobType)}
    if self.dataPendingInStagingStorageAccountInMB != nil {try container.encode(self.dataPendingInStagingStorageAccountInMB, forKey: .dataPendingInStagingStorageAccountInMB)}
    if self.dataPendingAtSourceAgentInMB != nil {try container.encode(self.dataPendingAtSourceAgentInMB, forKey: .dataPendingAtSourceAgentInMB)}
  }
}

extension DataFactory {
  public static func createA2AProtectedDiskDetailsProtocol() -> A2AProtectedDiskDetailsProtocol {
    return A2AProtectedDiskDetailsData()
  }
}