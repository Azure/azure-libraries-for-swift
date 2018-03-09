// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct IotHubDescriptionData : IotHubDescriptionProtocol, ResourceProtocol {
    public var id: String?
    public var name: String?
    public var type: String?
    public var location: String
    public var tags: [String:String]?
    public var subscriptionid: String
    public var resourcegroup: String
    public var etag: String?
    public var properties: IotHubPropertiesProtocol?
    public var sku: IotHubSkuInfoProtocol

        enum CodingKeys: String, CodingKey {case id = "id"
        case name = "name"
        case type = "type"
        case location = "location"
        case tags = "tags"
        case subscriptionid = "subscriptionid"
        case resourcegroup = "resourcegroup"
        case etag = "etag"
        case properties = "properties"
        case sku = "sku"
        }

  public init(location: String, subscriptionid: String, resourcegroup: String, sku: IotHubSkuInfoProtocol)  {
    self.location = location
    self.subscriptionid = subscriptionid
    self.resourcegroup = resourcegroup
    self.sku = sku
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.id) {
        self.id = try container.decode(String?.self, forKey: .id)
    }
    if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.type) {
        self.type = try container.decode(String?.self, forKey: .type)
    }
    self.location = try container.decode(String.self, forKey: .location)
    if container.contains(.tags) {
        self.tags = try container.decode([String:String]?.self, forKey: .tags)
    }
    self.subscriptionid = try container.decode(String.self, forKey: .subscriptionid)
    self.resourcegroup = try container.decode(String.self, forKey: .resourcegroup)
    if container.contains(.etag) {
        self.etag = try container.decode(String?.self, forKey: .etag)
    }
    if container.contains(.properties) {
        self.properties = try container.decode(IotHubPropertiesData?.self, forKey: .properties)
    }
    self.sku = try container.decode(IotHubSkuInfoData.self, forKey: .sku)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.id != nil {try container.encode(self.id, forKey: .id)}
    if self.name != nil {try container.encode(self.name, forKey: .name)}
    if self.type != nil {try container.encode(self.type, forKey: .type)}
    try container.encode(self.location, forKey: .location)
    if self.tags != nil {try container.encode(self.tags, forKey: .tags)}
    try container.encode(self.subscriptionid, forKey: .subscriptionid)
    try container.encode(self.resourcegroup, forKey: .resourcegroup)
    if self.etag != nil {try container.encode(self.etag, forKey: .etag)}
    if self.properties != nil {try container.encode(self.properties as! IotHubPropertiesData?, forKey: .properties)}
    try container.encode(self.sku as! IotHubSkuInfoData, forKey: .sku)
  }
}

extension DataFactory {
  public static func createIotHubDescriptionProtocol(location: String, subscriptionid: String, resourcegroup: String, sku: IotHubSkuInfoProtocol) -> IotHubDescriptionProtocol {
    return IotHubDescriptionData(location: location, subscriptionid: subscriptionid, resourcegroup: resourcegroup, sku: sku)
  }
}