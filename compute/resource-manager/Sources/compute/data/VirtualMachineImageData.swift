// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct VirtualMachineImageData : VirtualMachineImageProtocol, VirtualMachineImageResourceProtocol, SubResourceProtocol {
    public var id: String?
    public var name: String
    public var location: String
    public var tags: [String:String]?
    public var properties: VirtualMachineImagePropertiesProtocol?

        enum CodingKeys: String, CodingKey {case id = "id"
        case name = "name"
        case location = "location"
        case tags = "tags"
        case properties = "properties"
        }

  public init(name: String, location: String)  {
    self.name = name
    self.location = location
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.id) {
        self.id = try container.decode(String?.self, forKey: .id)
    }
    self.name = try container.decode(String.self, forKey: .name)
    self.location = try container.decode(String.self, forKey: .location)
    if container.contains(.tags) {
        self.tags = try container.decode([String:String]?.self, forKey: .tags)
    }
    if container.contains(.properties) {
        self.properties = try container.decode(VirtualMachineImagePropertiesData?.self, forKey: .properties)
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
    if self.id != nil {try container.encode(self.id, forKey: .id)}
    try container.encode(self.name, forKey: .name)
    try container.encode(self.location, forKey: .location)
    if self.tags != nil {try container.encode(self.tags, forKey: .tags)}
    if self.properties != nil {try container.encode(self.properties as! VirtualMachineImagePropertiesData?, forKey: .properties)}
  }
}

extension DataFactory {
  public static func createVirtualMachineImageProtocol(name: String, location: String) -> VirtualMachineImageProtocol {
    return VirtualMachineImageData(name: name, location: location)
  }
}
