// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// X12ValidationSettingsProtocol is the X12 agreement validation settings.
public protocol X12ValidationSettingsProtocol : Codable {
     var validateCharacterSet: Bool { get set }
     var checkDuplicateInterchangeControlNumber: Bool { get set }
     var interchangeControlNumberValidityDays: Int32 { get set }
     var checkDuplicateGroupControlNumber: Bool { get set }
     var checkDuplicateTransactionSetControlNumber: Bool { get set }
     var validateEdiTypes: Bool { get set }
     var validateXsdTypes: Bool { get set }
     var allowLeadingAndTrailingSpacesAndZeroes: Bool { get set }
     var trimLeadingAndTrailingSpacesAndZeroes: Bool { get set }
     var trailingSeparatorPolicy: TrailingSeparatorPolicyEnum { get set }
}
