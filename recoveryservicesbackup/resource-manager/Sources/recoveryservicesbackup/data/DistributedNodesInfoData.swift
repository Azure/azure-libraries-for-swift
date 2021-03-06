// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DistributedNodesInfoData : DistributedNodesInfoProtocol {
    public var nodeName: String?
    public var status: String?
    public var errorDetail: ErrorDetailProtocol?

        enum CodingKeys: String, CodingKey {case nodeName = "nodeName"
        case status = "status"
        case errorDetail = "errorDetail"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.nodeName) {
        self.nodeName = try container.decode(String?.self, forKey: .nodeName)
    }
    if container.contains(.status) {
        self.status = try container.decode(String?.self, forKey: .status)
    }
    if container.contains(.errorDetail) {
        self.errorDetail = try container.decode(ErrorDetailData?.self, forKey: .errorDetail)
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
    if self.nodeName != nil {try container.encode(self.nodeName, forKey: .nodeName)}
    if self.status != nil {try container.encode(self.status, forKey: .status)}
    if self.errorDetail != nil {try container.encode(self.errorDetail as! ErrorDetailData?, forKey: .errorDetail)}
  }
}

extension DataFactory {
  public static func createDistributedNodesInfoProtocol() -> DistributedNodesInfoProtocol {
    return DistributedNodesInfoData()
  }
}
