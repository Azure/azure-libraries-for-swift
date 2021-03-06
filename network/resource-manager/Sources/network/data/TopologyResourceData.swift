// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct TopologyResourceData : TopologyResourceProtocol {
    public var name: String?
    public var id: String?
    public var location: String?
    public var associations: [TopologyAssociationProtocol?]?

        enum CodingKeys: String, CodingKey {case name = "name"
        case id = "id"
        case location = "location"
        case associations = "associations"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.id) {
        self.id = try container.decode(String?.self, forKey: .id)
    }
    if container.contains(.location) {
        self.location = try container.decode(String?.self, forKey: .location)
    }
    if container.contains(.associations) {
        self.associations = try container.decode([TopologyAssociationData?]?.self, forKey: .associations)
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
    if self.name != nil {try container.encode(self.name, forKey: .name)}
    if self.id != nil {try container.encode(self.id, forKey: .id)}
    if self.location != nil {try container.encode(self.location, forKey: .location)}
    if self.associations != nil {try container.encode(self.associations as! [TopologyAssociationData?]?, forKey: .associations)}
  }
}

extension DataFactory {
  public static func createTopologyResourceProtocol() -> TopologyResourceProtocol {
    return TopologyResourceData()
  }
}
