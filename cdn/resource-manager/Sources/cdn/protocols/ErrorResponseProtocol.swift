// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ErrorResponseProtocol is error reponse indicates CDN service is not able to process the incoming request. The reason
// is provided in the error message.
public protocol ErrorResponseProtocol : Codable {
     var code: String? { get set }
     var message: String? { get set }
}
