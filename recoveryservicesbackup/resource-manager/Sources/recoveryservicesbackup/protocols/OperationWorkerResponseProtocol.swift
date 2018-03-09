// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// OperationWorkerResponseProtocol is this is the base class for operation result responses.
public protocol OperationWorkerResponseProtocol : Codable {
     var statusCode: HttpStatusCodeEnum? { get set }
     var headers: [String:[String]?]? { get set }
}