// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct InquiryInfoData : InquiryInfoProtocol {
    public var status: String?
    public var errorDetail: ErrorDetailProtocol?
    public var inquiryDetails: [WorkloadInquiryDetailsProtocol?]?

        enum CodingKeys: String, CodingKey {case status = "status"
        case errorDetail = "errorDetail"
        case inquiryDetails = "inquiryDetails"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.status) {
        self.status = try container.decode(String?.self, forKey: .status)
    }
    if container.contains(.errorDetail) {
        self.errorDetail = try container.decode(ErrorDetailData?.self, forKey: .errorDetail)
    }
    if container.contains(.inquiryDetails) {
        self.inquiryDetails = try container.decode([WorkloadInquiryDetailsData?]?.self, forKey: .inquiryDetails)
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
    if self.status != nil {try container.encode(self.status, forKey: .status)}
    if self.errorDetail != nil {try container.encode(self.errorDetail as! ErrorDetailData?, forKey: .errorDetail)}
    if self.inquiryDetails != nil {try container.encode(self.inquiryDetails as! [WorkloadInquiryDetailsData?]?, forKey: .inquiryDetails)}
  }
}

extension DataFactory {
  public static func createInquiryInfoProtocol() -> InquiryInfoProtocol {
    return InquiryInfoData()
  }
}
