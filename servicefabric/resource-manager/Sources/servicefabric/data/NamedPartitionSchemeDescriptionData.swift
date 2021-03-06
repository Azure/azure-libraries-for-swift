// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct NamedPartitionSchemeDescriptionData : NamedPartitionSchemeDescriptionProtocol, PartitionSchemeDescriptionProtocol {
    public var count: Int32
    public var names: [String]

        enum CodingKeys: String, CodingKey {case count = "Count"
        case names = "Names"
        }

  public init(count: Int32, names: [String])  {
    self.count = count
    self.names = names
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.count = try container.decode(Int32.self, forKey: .count)
    self.names = try container.decode([String].self, forKey: .names)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.count, forKey: .count)
    try container.encode(self.names as! [String], forKey: .names)
  }
}

extension DataFactory {
  public static func createNamedPartitionSchemeDescriptionProtocol(count: Int32, names: [String]) -> NamedPartitionSchemeDescriptionProtocol {
    return NamedPartitionSchemeDescriptionData(count: count, names: names)
  }
}
