// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// CustomHostnameAnalysisResultPropertiesProtocol is customHostnameAnalysisResult resource specific properties
public protocol CustomHostnameAnalysisResultPropertiesProtocol : Codable {
     var isHostnameAlreadyVerified: Bool? { get set }
     var customDomainVerificationTest: DnsVerificationTestResultEnum? { get set }
     var customDomainVerificationFailureInfo: ErrorEntityProtocol? { get set }
     var hasConflictOnScaleUnit: Bool? { get set }
     var hasConflictAcrossSubscription: Bool? { get set }
     var conflictingAppResourceId: String? { get set }
     var cNameRecords: [String]? { get set }
     var txtRecords: [String]? { get set }
     var aRecords: [String]? { get set }
     var alternateCNameRecords: [String]? { get set }
     var alternateTxtRecords: [String]? { get set }
}
