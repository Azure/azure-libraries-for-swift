// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DomainData : DomainProtocol {
    public var additionalProperties: [String:[String: String?]]?
    public var authenticationType: String?
    public var isDefault: Bool?
    public var isVerified: Bool?
    public var name: String

        enum CodingKeys: String, CodingKey {case additionalProperties = ""
        case authenticationType = "authenticationType"
        case isDefault = "isDefault"
        case isVerified = "isVerified"
        case name = "name"
        }

  public init(name: String)  {
    self.name = name
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.additionalProperties) {
        self.additionalProperties = try container.decode([String:[String: String?]]?.self, forKey: .additionalProperties)
    }
    if container.contains(.authenticationType) {
        self.authenticationType = try container.decode(String?.self, forKey: .authenticationType)
    }
    if container.contains(.isDefault) {
        self.isDefault = try container.decode(Bool?.self, forKey: .isDefault)
    }
    if container.contains(.isVerified) {
        self.isVerified = try container.decode(Bool?.self, forKey: .isVerified)
    }
    self.name = try container.decode(String.self, forKey: .name)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.additionalProperties != nil {try container.encode(self.additionalProperties, forKey: .additionalProperties)}
    if self.authenticationType != nil {try container.encode(self.authenticationType, forKey: .authenticationType)}
    if self.isDefault != nil {try container.encode(self.isDefault, forKey: .isDefault)}
    if self.isVerified != nil {try container.encode(self.isVerified, forKey: .isVerified)}
    try container.encode(self.name, forKey: .name)
  }
}

extension DataFactory {
  public static func createDomainProtocol(name: String) -> DomainProtocol {
    return DomainData(name: name)
  }
}