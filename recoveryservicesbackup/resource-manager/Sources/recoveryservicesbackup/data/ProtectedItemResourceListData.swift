// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ProtectedItemResourceListData : ProtectedItemResourceListProtocol, ResourceListProtocol {
    public var _nextLink: String?
    public var value: [ProtectedItemResourceProtocol?]?

        enum CodingKeys: String, CodingKey {case _nextLink = "nextLink"
        case value = "value"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(._nextLink) {
        self._nextLink = try container.decode(String?.self, forKey: ._nextLink)
    }
    if container.contains(.value) {
        self.value = try container.decode([ProtectedItemResourceData?]?.self, forKey: .value)
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
    if self._nextLink != nil {try container.encode(self._nextLink, forKey: ._nextLink)}
    if self.value != nil {try container.encode(self.value as! [ProtectedItemResourceData?]?, forKey: .value)}
  }
}

extension DataFactory {
  public static func createProtectedItemResourceListProtocol() -> ProtectedItemResourceListProtocol {
    return ProtectedItemResourceListData()
  }
}