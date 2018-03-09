// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct BackupEngineExtendedInfoData : BackupEngineExtendedInfoProtocol {
    public var databaseName: String?
    public var protectedItemsCount: Int32?
    public var protectedServersCount: Int32?
    public var diskCount: Int32?
    public var usedDiskSpace: Double?
    public var availableDiskSpace: Double?
    public var refreshedAt: Date?
    public var azureProtectedInstances: Int32?

        enum CodingKeys: String, CodingKey {case databaseName = "databaseName"
        case protectedItemsCount = "protectedItemsCount"
        case protectedServersCount = "protectedServersCount"
        case diskCount = "diskCount"
        case usedDiskSpace = "usedDiskSpace"
        case availableDiskSpace = "availableDiskSpace"
        case refreshedAt = "refreshedAt"
        case azureProtectedInstances = "azureProtectedInstances"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.databaseName) {
        self.databaseName = try container.decode(String?.self, forKey: .databaseName)
    }
    if container.contains(.protectedItemsCount) {
        self.protectedItemsCount = try container.decode(Int32?.self, forKey: .protectedItemsCount)
    }
    if container.contains(.protectedServersCount) {
        self.protectedServersCount = try container.decode(Int32?.self, forKey: .protectedServersCount)
    }
    if container.contains(.diskCount) {
        self.diskCount = try container.decode(Int32?.self, forKey: .diskCount)
    }
    if container.contains(.usedDiskSpace) {
        self.usedDiskSpace = try container.decode(Double?.self, forKey: .usedDiskSpace)
    }
    if container.contains(.availableDiskSpace) {
        self.availableDiskSpace = try container.decode(Double?.self, forKey: .availableDiskSpace)
    }
    if container.contains(.refreshedAt) {
        self.refreshedAt = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .refreshedAt)), format: .dateTime)
    }
    if container.contains(.azureProtectedInstances) {
        self.azureProtectedInstances = try container.decode(Int32?.self, forKey: .azureProtectedInstances)
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
    if self.databaseName != nil {try container.encode(self.databaseName, forKey: .databaseName)}
    if self.protectedItemsCount != nil {try container.encode(self.protectedItemsCount, forKey: .protectedItemsCount)}
    if self.protectedServersCount != nil {try container.encode(self.protectedServersCount, forKey: .protectedServersCount)}
    if self.diskCount != nil {try container.encode(self.diskCount, forKey: .diskCount)}
    if self.usedDiskSpace != nil {try container.encode(self.usedDiskSpace, forKey: .usedDiskSpace)}
    if self.availableDiskSpace != nil {try container.encode(self.availableDiskSpace, forKey: .availableDiskSpace)}
    if self.refreshedAt != nil {
        try container.encode(DateConverter.toString(date: self.refreshedAt!, format: .dateTime), forKey: .refreshedAt)
    }
    if self.azureProtectedInstances != nil {try container.encode(self.azureProtectedInstances, forKey: .azureProtectedInstances)}
  }
}

extension DataFactory {
  public static func createBackupEngineExtendedInfoProtocol() -> BackupEngineExtendedInfoProtocol {
    return BackupEngineExtendedInfoData()
  }
}