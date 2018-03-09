// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SrvRecordData : SrvRecordProtocol {
    public var priority: Int32?
    public var weight: Int32?
    public var port: Int32?
    public var target: String?

        enum CodingKeys: String, CodingKey {case priority = "priority"
        case weight = "weight"
        case port = "port"
        case target = "target"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.priority) {
        self.priority = try container.decode(Int32?.self, forKey: .priority)
    }
    if container.contains(.weight) {
        self.weight = try container.decode(Int32?.self, forKey: .weight)
    }
    if container.contains(.port) {
        self.port = try container.decode(Int32?.self, forKey: .port)
    }
    if container.contains(.target) {
        self.target = try container.decode(String?.self, forKey: .target)
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
    if self.priority != nil {try container.encode(self.priority, forKey: .priority)}
    if self.weight != nil {try container.encode(self.weight, forKey: .weight)}
    if self.port != nil {try container.encode(self.port, forKey: .port)}
    if self.target != nil {try container.encode(self.target, forKey: .target)}
  }
}

extension DataFactory {
  public static func createSrvRecordProtocol() -> SrvRecordProtocol {
    return SrvRecordData()
  }
}