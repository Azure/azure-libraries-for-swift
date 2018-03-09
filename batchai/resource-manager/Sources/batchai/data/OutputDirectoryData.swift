// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct OutputDirectoryData : OutputDirectoryProtocol {
    public var id: String
    public var pathPrefix: String
    public var pathSuffix: String?
    public var type: OutputTypeEnum?
    public var createNew: Bool?

        enum CodingKeys: String, CodingKey {case id = "id"
        case pathPrefix = "pathPrefix"
        case pathSuffix = "pathSuffix"
        case type = "type"
        case createNew = "createNew"
        }

  public init(id: String, pathPrefix: String)  {
    self.id = id
    self.pathPrefix = pathPrefix
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.id = try container.decode(String.self, forKey: .id)
    self.pathPrefix = try container.decode(String.self, forKey: .pathPrefix)
    if container.contains(.pathSuffix) {
        self.pathSuffix = try container.decode(String?.self, forKey: .pathSuffix)
    }
    if container.contains(.type) {
        self.type = try container.decode(OutputTypeEnum?.self, forKey: .type)
    }
    if container.contains(.createNew) {
        self.createNew = try container.decode(Bool?.self, forKey: .createNew)
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
    try container.encode(self.id, forKey: .id)
    try container.encode(self.pathPrefix, forKey: .pathPrefix)
    if self.pathSuffix != nil {try container.encode(self.pathSuffix, forKey: .pathSuffix)}
    if self.type != nil {try container.encode(self.type, forKey: .type)}
    if self.createNew != nil {try container.encode(self.createNew, forKey: .createNew)}
  }
}

extension DataFactory {
  public static func createOutputDirectoryProtocol(id: String, pathPrefix: String) -> OutputDirectoryProtocol {
    return OutputDirectoryData(id: id, pathPrefix: pathPrefix)
  }
}