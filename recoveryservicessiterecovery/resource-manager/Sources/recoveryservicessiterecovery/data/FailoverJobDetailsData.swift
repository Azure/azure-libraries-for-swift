// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct FailoverJobDetailsData : FailoverJobDetailsProtocol, JobDetailsProtocol {
    public var affectedObjectDetails: [String:String]?
    public var protectedItemDetails: [FailoverReplicationProtectedItemDetailsProtocol?]?

        enum CodingKeys: String, CodingKey {case affectedObjectDetails = "affectedObjectDetails"
        case protectedItemDetails = "protectedItemDetails"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.affectedObjectDetails) {
        self.affectedObjectDetails = try container.decode([String:String]?.self, forKey: .affectedObjectDetails)
    }
    if container.contains(.protectedItemDetails) {
        self.protectedItemDetails = try container.decode([FailoverReplicationProtectedItemDetailsData?]?.self, forKey: .protectedItemDetails)
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
    if self.affectedObjectDetails != nil {try container.encode(self.affectedObjectDetails, forKey: .affectedObjectDetails)}
    if self.protectedItemDetails != nil {try container.encode(self.protectedItemDetails as! [FailoverReplicationProtectedItemDetailsData?]?, forKey: .protectedItemDetails)}
  }
}

extension DataFactory {
  public static func createFailoverJobDetailsProtocol() -> FailoverJobDetailsProtocol {
    return FailoverJobDetailsData()
  }
}
