// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ImportRDBParametersData : ImportRDBParametersProtocol {
    public var format: String?
    public var files: [String]

        enum CodingKeys: String, CodingKey {case format = "format"
        case files = "files"
        }

  public init(files: [String])  {
    self.files = files
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.format) {
        self.format = try container.decode(String?.self, forKey: .format)
    }
    self.files = try container.decode([String].self, forKey: .files)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.format != nil {try container.encode(self.format, forKey: .format)}
    try container.encode(self.files as! [String], forKey: .files)
  }
}

extension DataFactory {
  public static func createImportRDBParametersProtocol(files: [String]) -> ImportRDBParametersProtocol {
    return ImportRDBParametersData(files: files)
  }
}
