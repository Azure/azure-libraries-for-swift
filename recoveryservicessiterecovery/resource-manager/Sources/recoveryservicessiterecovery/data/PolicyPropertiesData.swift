// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct PolicyPropertiesData : PolicyPropertiesProtocol {
    public var friendlyName: String?
    public var providerSpecificDetails: PolicyProviderSpecificDetailsProtocol?

        enum CodingKeys: String, CodingKey {case friendlyName = "friendlyName"
        case providerSpecificDetails = "providerSpecificDetails"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.friendlyName) {
        self.friendlyName = try container.decode(String?.self, forKey: .friendlyName)
    }
    if container.contains(.providerSpecificDetails) {
        self.providerSpecificDetails = try container.decode(PolicyProviderSpecificDetailsData?.self, forKey: .providerSpecificDetails)
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
    if self.friendlyName != nil {try container.encode(self.friendlyName, forKey: .friendlyName)}
    if self.providerSpecificDetails != nil {try container.encode(self.providerSpecificDetails as! PolicyProviderSpecificDetailsData?, forKey: .providerSpecificDetails)}
  }
}

extension DataFactory {
  public static func createPolicyPropertiesProtocol() -> PolicyPropertiesProtocol {
    return PolicyPropertiesData()
  }
}
