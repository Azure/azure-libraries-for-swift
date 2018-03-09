// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct VersionDetailsData : VersionDetailsProtocol {
    public var version: String?
    public var expiryDate: Date?
    public var status: AgentVersionStatusEnum?

        enum CodingKeys: String, CodingKey {case version = "version"
        case expiryDate = "expiryDate"
        case status = "status"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.version) {
        self.version = try container.decode(String?.self, forKey: .version)
    }
    if container.contains(.expiryDate) {
        self.expiryDate = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .expiryDate)), format: .dateTime)
    }
    if container.contains(.status) {
        self.status = try container.decode(AgentVersionStatusEnum?.self, forKey: .status)
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
    if self.version != nil {try container.encode(self.version, forKey: .version)}
    if self.expiryDate != nil {
        try container.encode(DateConverter.toString(date: self.expiryDate!, format: .dateTime), forKey: .expiryDate)
    }
    if self.status != nil {try container.encode(self.status, forKey: .status)}
  }
}

extension DataFactory {
  public static func createVersionDetailsProtocol() -> VersionDetailsProtocol {
    return VersionDetailsData()
  }
}
