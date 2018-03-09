// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// IntegrationAccountAgreementPropertiesProtocol is the integration account agreement properties.
public protocol IntegrationAccountAgreementPropertiesProtocol : Codable {
     var createdTime: Date? { get set }
     var changedTime: Date? { get set }
     var metadata: [String: String?]? { get set }
     var agreementType: AgreementTypeEnum { get set }
     var hostPartner: String { get set }
     var guestPartner: String { get set }
     var hostIdentity: BusinessIdentityProtocol { get set }
     var guestIdentity: BusinessIdentityProtocol { get set }
     var content: AgreementContentProtocol { get set }
}