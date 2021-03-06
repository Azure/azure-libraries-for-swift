// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ServiceBusDataSourcePropertiesData : ServiceBusDataSourcePropertiesProtocol {
    public var serviceBusNamespace: String?
    public var sharedAccessPolicyName: String?
    public var sharedAccessPolicyKey: String?

        enum CodingKeys: String, CodingKey {case serviceBusNamespace = "serviceBusNamespace"
        case sharedAccessPolicyName = "sharedAccessPolicyName"
        case sharedAccessPolicyKey = "sharedAccessPolicyKey"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.serviceBusNamespace) {
        self.serviceBusNamespace = try container.decode(String?.self, forKey: .serviceBusNamespace)
    }
    if container.contains(.sharedAccessPolicyName) {
        self.sharedAccessPolicyName = try container.decode(String?.self, forKey: .sharedAccessPolicyName)
    }
    if container.contains(.sharedAccessPolicyKey) {
        self.sharedAccessPolicyKey = try container.decode(String?.self, forKey: .sharedAccessPolicyKey)
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
    if self.serviceBusNamespace != nil {try container.encode(self.serviceBusNamespace, forKey: .serviceBusNamespace)}
    if self.sharedAccessPolicyName != nil {try container.encode(self.sharedAccessPolicyName, forKey: .sharedAccessPolicyName)}
    if self.sharedAccessPolicyKey != nil {try container.encode(self.sharedAccessPolicyKey, forKey: .sharedAccessPolicyKey)}
  }
}

extension DataFactory {
  public static func createServiceBusDataSourcePropertiesProtocol() -> ServiceBusDataSourcePropertiesProtocol {
    return ServiceBusDataSourcePropertiesData()
  }
}
