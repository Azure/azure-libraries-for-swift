// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct AzureSqlProtectedItemData : AzureSqlProtectedItemProtocol, ProtectedItemProtocol {
    public var backupManagementType: BackupManagementTypeEnum?
    public var workloadType: DataSourceTypeEnum?
    public var containerName: String?
    public var sourceResourceId: String?
    public var policyId: String?
    public var lastRecoveryPoint: Date?
    public var backupSetName: String?
    public var protectedItemDataId: String?
    public var protectionState: ProtectedItemStateEnum?
    public var extendedInfo: AzureSqlProtectedItemExtendedInfoProtocol?

        enum CodingKeys: String, CodingKey {case backupManagementType = "backupManagementType"
        case workloadType = "workloadType"
        case containerName = "containerName"
        case sourceResourceId = "sourceResourceId"
        case policyId = "policyId"
        case lastRecoveryPoint = "lastRecoveryPoint"
        case backupSetName = "backupSetName"
        case protectedItemDataId = "protectedItemDataId"
        case protectionState = "protectionState"
        case extendedInfo = "extendedInfo"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.backupManagementType) {
        self.backupManagementType = try container.decode(BackupManagementTypeEnum?.self, forKey: .backupManagementType)
    }
    if container.contains(.workloadType) {
        self.workloadType = try container.decode(DataSourceTypeEnum?.self, forKey: .workloadType)
    }
    if container.contains(.containerName) {
        self.containerName = try container.decode(String?.self, forKey: .containerName)
    }
    if container.contains(.sourceResourceId) {
        self.sourceResourceId = try container.decode(String?.self, forKey: .sourceResourceId)
    }
    if container.contains(.policyId) {
        self.policyId = try container.decode(String?.self, forKey: .policyId)
    }
    if container.contains(.lastRecoveryPoint) {
        self.lastRecoveryPoint = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastRecoveryPoint)), format: .dateTime)
    }
    if container.contains(.backupSetName) {
        self.backupSetName = try container.decode(String?.self, forKey: .backupSetName)
    }
    if container.contains(.protectedItemDataId) {
        self.protectedItemDataId = try container.decode(String?.self, forKey: .protectedItemDataId)
    }
    if container.contains(.protectionState) {
        self.protectionState = try container.decode(ProtectedItemStateEnum?.self, forKey: .protectionState)
    }
    if container.contains(.extendedInfo) {
        self.extendedInfo = try container.decode(AzureSqlProtectedItemExtendedInfoData?.self, forKey: .extendedInfo)
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
    if self.backupManagementType != nil {try container.encode(self.backupManagementType, forKey: .backupManagementType)}
    if self.workloadType != nil {try container.encode(self.workloadType, forKey: .workloadType)}
    if self.containerName != nil {try container.encode(self.containerName, forKey: .containerName)}
    if self.sourceResourceId != nil {try container.encode(self.sourceResourceId, forKey: .sourceResourceId)}
    if self.policyId != nil {try container.encode(self.policyId, forKey: .policyId)}
    if self.lastRecoveryPoint != nil {
        try container.encode(DateConverter.toString(date: self.lastRecoveryPoint!, format: .dateTime), forKey: .lastRecoveryPoint)
    }
    if self.backupSetName != nil {try container.encode(self.backupSetName, forKey: .backupSetName)}
    if self.protectedItemDataId != nil {try container.encode(self.protectedItemDataId, forKey: .protectedItemDataId)}
    if self.protectionState != nil {try container.encode(self.protectionState, forKey: .protectionState)}
    if self.extendedInfo != nil {try container.encode(self.extendedInfo as! AzureSqlProtectedItemExtendedInfoData?, forKey: .extendedInfo)}
  }
}

extension DataFactory {
  public static func createAzureSqlProtectedItemProtocol() -> AzureSqlProtectedItemProtocol {
    return AzureSqlProtectedItemData()
  }
}