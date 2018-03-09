// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct MobilityServiceUpdateData : MobilityServiceUpdateProtocol {
    public var version: String?
    public var rebootStatus: String?
    public var osType: String?

        enum CodingKeys: String, CodingKey {case version = "version"
        case rebootStatus = "rebootStatus"
        case osType = "osType"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.version) {
        self.version = try container.decode(String?.self, forKey: .version)
    }
    if container.contains(.rebootStatus) {
        self.rebootStatus = try container.decode(String?.self, forKey: .rebootStatus)
    }
    if container.contains(.osType) {
        self.osType = try container.decode(String?.self, forKey: .osType)
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
    if self.rebootStatus != nil {try container.encode(self.rebootStatus, forKey: .rebootStatus)}
    if self.osType != nil {try container.encode(self.osType, forKey: .osType)}
  }
}

extension DataFactory {
  public static func createMobilityServiceUpdateProtocol() -> MobilityServiceUpdateProtocol {
    return MobilityServiceUpdateData()
  }
}