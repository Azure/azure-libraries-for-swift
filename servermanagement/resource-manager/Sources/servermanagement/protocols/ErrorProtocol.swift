// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ErrorProtocol is error message.
public protocol ErrorProtocol : Codable {
     var code: Int32? { get set }
     var message: String? { get set }
     var fields: String? { get set }
}