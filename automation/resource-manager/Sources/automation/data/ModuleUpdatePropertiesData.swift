// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ModuleUpdatePropertiesData : ModuleUpdatePropertiesProtocol {
    public var contentLink: ContentLinkProtocol?

        enum CodingKeys: String, CodingKey {case contentLink = "contentLink"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.contentLink) {
        self.contentLink = try container.decode(ContentLinkData?.self, forKey: .contentLink)
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
    if self.contentLink != nil {try container.encode(self.contentLink as! ContentLinkData?, forKey: .contentLink)}
  }
}

extension DataFactory {
  public static func createModuleUpdatePropertiesProtocol() -> ModuleUpdatePropertiesProtocol {
    return ModuleUpdatePropertiesData()
  }
}
