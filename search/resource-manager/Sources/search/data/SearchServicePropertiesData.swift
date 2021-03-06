// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SearchServicePropertiesData : SearchServicePropertiesProtocol {
    public var replicaCount: Int32?
    public var partitionCount: Int32?
    public var hostingMode: HostingModeEnum?
    public var status: SearchServiceStatusEnum?
    public var statusDetails: String?
    public var provisioningState: ProvisioningStateEnum?

        enum CodingKeys: String, CodingKey {case replicaCount = "replicaCount"
        case partitionCount = "partitionCount"
        case hostingMode = "hostingMode"
        case status = "status"
        case statusDetails = "statusDetails"
        case provisioningState = "provisioningState"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.replicaCount) {
        self.replicaCount = try container.decode(Int32?.self, forKey: .replicaCount)
    }
    if container.contains(.partitionCount) {
        self.partitionCount = try container.decode(Int32?.self, forKey: .partitionCount)
    }
    if container.contains(.hostingMode) {
        self.hostingMode = try container.decode(HostingModeEnum?.self, forKey: .hostingMode)
    }
    if container.contains(.status) {
        self.status = try container.decode(SearchServiceStatusEnum?.self, forKey: .status)
    }
    if container.contains(.statusDetails) {
        self.statusDetails = try container.decode(String?.self, forKey: .statusDetails)
    }
    if container.contains(.provisioningState) {
        self.provisioningState = try container.decode(ProvisioningStateEnum?.self, forKey: .provisioningState)
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
    if self.replicaCount != nil {try container.encode(self.replicaCount, forKey: .replicaCount)}
    if self.partitionCount != nil {try container.encode(self.partitionCount, forKey: .partitionCount)}
    if self.hostingMode != nil {try container.encode(self.hostingMode, forKey: .hostingMode)}
    if self.status != nil {try container.encode(self.status, forKey: .status)}
    if self.statusDetails != nil {try container.encode(self.statusDetails, forKey: .statusDetails)}
    if self.provisioningState != nil {try container.encode(self.provisioningState, forKey: .provisioningState)}
  }
}

extension DataFactory {
  public static func createSearchServicePropertiesProtocol() -> SearchServicePropertiesProtocol {
    return SearchServicePropertiesData()
  }
}
