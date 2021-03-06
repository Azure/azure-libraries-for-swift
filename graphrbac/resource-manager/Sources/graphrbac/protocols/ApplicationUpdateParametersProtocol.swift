// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ApplicationUpdateParametersProtocol is request parameters for updating an existing application.
public protocol ApplicationUpdateParametersProtocol : Codable {
     var additionalProperties: [String:[String: String?]]? { get set }
     var availableToOtherTenants: Bool? { get set }
     var displayName: String? { get set }
     var homepage: String? { get set }
     var identifierUris: [String]? { get set }
     var replyUrls: [String]? { get set }
     var keyCredentials: [KeyCredentialProtocol?]? { get set }
     var passwordCredentials: [PasswordCredentialProtocol?]? { get set }
     var oauth2AllowImplicitFlow: Bool? { get set }
     var requiredResourceAccess: [RequiredResourceAccessProtocol?]? { get set }
}
