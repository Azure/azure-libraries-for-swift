// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ConnectorProtocol is properties of connector.
public protocol ConnectorProtocol : Codable {
     var connectorId: Int32? { get set }
     var connectorName: String? { get set }
     var connectorType: ConnectorTypesEnum { get set }
     var displayName: String? { get set }
     var description: String? { get set }
     var connectorProperties: [String:[String: String?]] { get set }
     var created: Date? { get set }
     var lastModified: Date? { get set }
     var state: ConnectorStatesEnum? { get set }
     var tenantId: String? { get set }
     var isInternal: Bool? { get set }
}
