// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AADObjectProtocol is the properties of an Active Directory object.
public protocol AADObjectProtocol : Codable {
     var additionalProperties: [String:[String: String?]]? { get set }
     var objectId: String? { get set }
     var objectType: String? { get set }
     var displayName: String? { get set }
     var userPrincipalName: String? { get set }
     var mail: String? { get set }
     var mailEnabled: Bool? { get set }
     var mailNickname: String? { get set }
     var securityEnabled: Bool? { get set }
     var signInName: String? { get set }
     var servicePrincipalNames: [String]? { get set }
     var userType: String? { get set }
     var usageLocation: String? { get set }
     var appId: String? { get set }
     var appPermissions: [String]? { get set }
     var availableToOtherTenants: Bool? { get set }
     var identifierUris: [String]? { get set }
     var replyUrls: [String]? { get set }
     var homepage: String? { get set }
}
