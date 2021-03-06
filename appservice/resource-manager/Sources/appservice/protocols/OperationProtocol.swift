// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// OperationProtocol is an operation on a resource.
public protocol OperationProtocol : Codable {
     var id: String? { get set }
     var name: String? { get set }
     var status: OperationStatusEnum? { get set }
     var errors: [ErrorEntityProtocol?]? { get set }
     var createdTime: Date? { get set }
     var modifiedTime: Date? { get set }
     var expirationTime: Date? { get set }
     var geoMasterOperationId: String? { get set }
}
