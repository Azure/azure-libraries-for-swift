// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// HostNameBindingPropertiesProtocol is hostNameBinding resource specific properties
public protocol HostNameBindingPropertiesProtocol : Codable {
     var siteName: String? { get set }
     var domainId: String? { get set }
     var azureResourceName: String? { get set }
     var azureResourceType: AzureResourceTypeEnum? { get set }
     var customHostNameDnsRecordType: CustomHostNameDnsRecordTypeEnum? { get set }
     var hostNameType: HostNameTypeEnum? { get set }
     var sslState: SslStateEnum? { get set }
     var thumbprint: String? { get set }
     var virtualIP: String? { get set }
}
