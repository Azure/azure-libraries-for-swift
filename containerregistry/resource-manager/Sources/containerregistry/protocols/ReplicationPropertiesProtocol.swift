// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ReplicationPropertiesProtocol is the properties of a replication.
public protocol ReplicationPropertiesProtocol : Codable {
     var provisioningState: ProvisioningStateEnum? { get set }
     var status: StatusProtocol? { get set }
}
