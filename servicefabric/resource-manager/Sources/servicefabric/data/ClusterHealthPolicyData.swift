// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ClusterHealthPolicyData : ClusterHealthPolicyProtocol {
    public var maxPercentUnhealthyNodes: Int32?
    public var maxPercentUnhealthyApplications: Int32?

        enum CodingKeys: String, CodingKey {case maxPercentUnhealthyNodes = "maxPercentUnhealthyNodes"
        case maxPercentUnhealthyApplications = "maxPercentUnhealthyApplications"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.maxPercentUnhealthyNodes) {
        self.maxPercentUnhealthyNodes = try container.decode(Int32?.self, forKey: .maxPercentUnhealthyNodes)
    }
    if container.contains(.maxPercentUnhealthyApplications) {
        self.maxPercentUnhealthyApplications = try container.decode(Int32?.self, forKey: .maxPercentUnhealthyApplications)
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
    if self.maxPercentUnhealthyNodes != nil {try container.encode(self.maxPercentUnhealthyNodes, forKey: .maxPercentUnhealthyNodes)}
    if self.maxPercentUnhealthyApplications != nil {try container.encode(self.maxPercentUnhealthyApplications, forKey: .maxPercentUnhealthyApplications)}
  }
}

extension DataFactory {
  public static func createClusterHealthPolicyProtocol() -> ClusterHealthPolicyProtocol {
    return ClusterHealthPolicyData()
  }
}
