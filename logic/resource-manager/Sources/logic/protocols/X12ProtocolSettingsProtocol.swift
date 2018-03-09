// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// X12ProtocolSettingsProtocol is the X12 agreement protocol settings.
public protocol X12ProtocolSettingsProtocol : Codable {
     var validationSettings: X12ValidationSettingsProtocol { get set }
     var framingSettings: X12FramingSettingsProtocol { get set }
     var envelopeSettings: X12EnvelopeSettingsProtocol { get set }
     var acknowledgementSettings: X12AcknowledgementSettingsProtocol { get set }
     var messageFilter: X12MessageFilterProtocol { get set }
     var securitySettings: X12SecuritySettingsProtocol { get set }
     var processingSettings: X12ProcessingSettingsProtocol { get set }
     var envelopeOverrides: [X12EnvelopeOverrideProtocol?]? { get set }
     var validationOverrides: [X12ValidationOverrideProtocol?]? { get set }
     var messageFilterList: [X12MessageIdentifierProtocol?]? { get set }
     var schemaReferences: [X12SchemaReferenceProtocol] { get set }
     var x12DelimiterOverrides: [X12DelimiterOverridesProtocol?]? { get set }
}