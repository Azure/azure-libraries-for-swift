// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DscNodeUpdateParametersData : DscNodeUpdateParametersProtocol {
    public var nodeId: String?
    public var nodeConfiguration: DscNodeConfigurationAssociationPropertyProtocol?

        enum CodingKeys: String, CodingKey {case nodeId = "nodeId"
        case nodeConfiguration = "nodeConfiguration"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.nodeId) {
        self.nodeId = try container.decode(String?.self, forKey: .nodeId)
    }
    if container.contains(.nodeConfiguration) {
        self.nodeConfiguration = try container.decode(DscNodeConfigurationAssociationPropertyData?.self, forKey: .nodeConfiguration)
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
    if self.nodeId != nil {try container.encode(self.nodeId, forKey: .nodeId)}
    if self.nodeConfiguration != nil {try container.encode(self.nodeConfiguration as! DscNodeConfigurationAssociationPropertyData?, forKey: .nodeConfiguration)}
  }
}

extension DataFactory {
  public static func createDscNodeUpdateParametersProtocol() -> DscNodeUpdateParametersProtocol {
    return DscNodeUpdateParametersData()
  }
}
