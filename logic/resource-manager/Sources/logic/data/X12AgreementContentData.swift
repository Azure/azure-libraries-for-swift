// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct X12AgreementContentData : X12AgreementContentProtocol {
    public var receiveAgreement: X12OneWayAgreementProtocol
    public var sendAgreement: X12OneWayAgreementProtocol

        enum CodingKeys: String, CodingKey {case receiveAgreement = "receiveAgreement"
        case sendAgreement = "sendAgreement"
        }

  public init(receiveAgreement: X12OneWayAgreementProtocol, sendAgreement: X12OneWayAgreementProtocol)  {
    self.receiveAgreement = receiveAgreement
    self.sendAgreement = sendAgreement
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.receiveAgreement = try container.decode(X12OneWayAgreementData.self, forKey: .receiveAgreement)
    self.sendAgreement = try container.decode(X12OneWayAgreementData.self, forKey: .sendAgreement)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.receiveAgreement as! X12OneWayAgreementData, forKey: .receiveAgreement)
    try container.encode(self.sendAgreement as! X12OneWayAgreementData, forKey: .sendAgreement)
  }
}

extension DataFactory {
  public static func createX12AgreementContentProtocol(receiveAgreement: X12OneWayAgreementProtocol, sendAgreement: X12OneWayAgreementProtocol) -> X12AgreementContentProtocol {
    return X12AgreementContentData(receiveAgreement: receiveAgreement, sendAgreement: sendAgreement)
  }
}
