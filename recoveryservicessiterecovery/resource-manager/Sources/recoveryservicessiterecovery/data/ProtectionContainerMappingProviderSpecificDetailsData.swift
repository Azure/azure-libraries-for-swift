// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ProtectionContainerMappingProviderSpecificDetailsData : ProtectionContainerMappingProviderSpecificDetailsProtocol {
    public var instanceType: String?

        enum CodingKeys: String, CodingKey {case instanceType = "instanceType"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.instanceType) {
        self.instanceType = try container.decode(String?.self, forKey: .instanceType)
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
    if self.instanceType != nil {try container.encode(self.instanceType, forKey: .instanceType)}
  }
}

extension DataFactory {
  public static func createProtectionContainerMappingProviderSpecificDetailsProtocol() -> ProtectionContainerMappingProviderSpecificDetailsProtocol {
    return ProtectionContainerMappingProviderSpecificDetailsData()
  }
}
