// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct AzureWorkloadSQLPointInTimeRestoreRequestData : AzureWorkloadSQLPointInTimeRestoreRequestProtocol, AzureWorkloadSQLRestoreRequestProtocol, AzureWorkloadRestoreRequestProtocol, RestoreRequestProtocol {
    public var recoveryType: RecoveryTypeEnum?
    public var sourceResourceId: String?
    public var propertyBag: [String:String]?
    public var shouldUseAlternateTargetLocation: Bool?
    public var isNonRecoverable: Bool?
    public var targetInfo: TargetRestoreInfoProtocol?
    public var alternateDirectoryPaths: [SQLDataDirectoryMappingProtocol?]?
    public var pointInTime: Date?

        enum CodingKeys: String, CodingKey {case recoveryType = "recoveryType"
        case sourceResourceId = "sourceResourceId"
        case propertyBag = "propertyBag"
        case shouldUseAlternateTargetLocation = "shouldUseAlternateTargetLocation"
        case isNonRecoverable = "isNonRecoverable"
        case targetInfo = "targetInfo"
        case alternateDirectoryPaths = "alternateDirectoryPaths"
        case pointInTime = "pointInTime"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.recoveryType) {
        self.recoveryType = try container.decode(RecoveryTypeEnum?.self, forKey: .recoveryType)
    }
    if container.contains(.sourceResourceId) {
        self.sourceResourceId = try container.decode(String?.self, forKey: .sourceResourceId)
    }
    if container.contains(.propertyBag) {
        self.propertyBag = try container.decode([String:String]?.self, forKey: .propertyBag)
    }
    if container.contains(.shouldUseAlternateTargetLocation) {
        self.shouldUseAlternateTargetLocation = try container.decode(Bool?.self, forKey: .shouldUseAlternateTargetLocation)
    }
    if container.contains(.isNonRecoverable) {
        self.isNonRecoverable = try container.decode(Bool?.self, forKey: .isNonRecoverable)
    }
    if container.contains(.targetInfo) {
        self.targetInfo = try container.decode(TargetRestoreInfoData?.self, forKey: .targetInfo)
    }
    if container.contains(.alternateDirectoryPaths) {
        self.alternateDirectoryPaths = try container.decode([SQLDataDirectoryMappingData?]?.self, forKey: .alternateDirectoryPaths)
    }
    if container.contains(.pointInTime) {
        self.pointInTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .pointInTime)), format: .dateTime)
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
    if self.recoveryType != nil {try container.encode(self.recoveryType, forKey: .recoveryType)}
    if self.sourceResourceId != nil {try container.encode(self.sourceResourceId, forKey: .sourceResourceId)}
    if self.propertyBag != nil {try container.encode(self.propertyBag, forKey: .propertyBag)}
    if self.shouldUseAlternateTargetLocation != nil {try container.encode(self.shouldUseAlternateTargetLocation, forKey: .shouldUseAlternateTargetLocation)}
    if self.isNonRecoverable != nil {try container.encode(self.isNonRecoverable, forKey: .isNonRecoverable)}
    if self.targetInfo != nil {try container.encode(self.targetInfo as! TargetRestoreInfoData?, forKey: .targetInfo)}
    if self.alternateDirectoryPaths != nil {try container.encode(self.alternateDirectoryPaths as! [SQLDataDirectoryMappingData?]?, forKey: .alternateDirectoryPaths)}
    if self.pointInTime != nil {
        try container.encode(DateConverter.toString(date: self.pointInTime!, format: .dateTime), forKey: .pointInTime)
    }
  }
}

extension DataFactory {
  public static func createAzureWorkloadSQLPointInTimeRestoreRequestProtocol() -> AzureWorkloadSQLPointInTimeRestoreRequestProtocol {
    return AzureWorkloadSQLPointInTimeRestoreRequestData()
  }
}
