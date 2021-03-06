// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct CreatePolicyInputPropertiesData : CreatePolicyInputPropertiesProtocol {
    public var providerSpecificInput: PolicyProviderSpecificInputProtocol?

        enum CodingKeys: String, CodingKey {case providerSpecificInput = "providerSpecificInput"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.providerSpecificInput) {
        self.providerSpecificInput = try container.decode(PolicyProviderSpecificInputData?.self, forKey: .providerSpecificInput)
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
    if self.providerSpecificInput != nil {try container.encode(self.providerSpecificInput as! PolicyProviderSpecificInputData?, forKey: .providerSpecificInput)}
  }
}

extension DataFactory {
  public static func createCreatePolicyInputPropertiesProtocol() -> CreatePolicyInputPropertiesProtocol {
    return CreatePolicyInputPropertiesData()
  }
}
