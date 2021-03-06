// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct InputDirectoryData : InputDirectoryProtocol {
    public var id: String
    public var path: String

        enum CodingKeys: String, CodingKey {case id = "id"
        case path = "path"
        }

  public init(id: String, path: String)  {
    self.id = id
    self.path = path
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.id = try container.decode(String.self, forKey: .id)
    self.path = try container.decode(String.self, forKey: .path)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.path, forKey: .path)
  }
}

extension DataFactory {
  public static func createInputDirectoryProtocol(id: String, path: String) -> InputDirectoryProtocol {
    return InputDirectoryData(id: id, path: path)
  }
}
