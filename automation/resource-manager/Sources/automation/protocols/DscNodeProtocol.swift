// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// DscNodeProtocol is definition of the dsc node type.
public protocol DscNodeProtocol : ProxyResourceProtocol {
     var lastSeen: Date? { get set }
     var registrationTime: Date? { get set }
     var ip: String? { get set }
     var accountId: String? { get set }
     var nodeConfiguration: DscNodeConfigurationAssociationPropertyProtocol? { get set }
     var status: String? { get set }
     var nodeId: String? { get set }
     var etag: String? { get set }
     var extensionHandler: [DscNodeExtensionHandlerAssociationPropertyProtocol?]? { get set }
}
