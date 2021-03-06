// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DiskUpdateData : DiskUpdateProtocol, ResourceUpdateProtocol {
    public var tags: [String:String]?
    public var sku: DiskSkuProtocol?
    public var properties: DiskUpdatePropertiesProtocol?

        enum CodingKeys: String, CodingKey {case tags = "tags"
        case sku = "sku"
        case properties = "properties"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.tags) {
        self.tags = try container.decode([String:String]?.self, forKey: .tags)
    }
    if container.contains(.sku) {
        self.sku = try container.decode(DiskSkuData?.self, forKey: .sku)
    }
    if container.contains(.properties) {
        self.properties = try container.decode(DiskUpdatePropertiesData?.self, forKey: .properties)
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
    if self.tags != nil {try container.encode(self.tags, forKey: .tags)}
    if self.sku != nil {try container.encode(self.sku as! DiskSkuData?, forKey: .sku)}
    if self.properties != nil {try container.encode(self.properties as! DiskUpdatePropertiesData?, forKey: .properties)}
  }
}

extension DataFactory {
  public static func createDiskUpdateProtocol() -> DiskUpdateProtocol {
    return DiskUpdateData()
  }
}
