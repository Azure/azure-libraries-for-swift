// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ErrorDetailProtocol is error Detail class which encapsulates Code, Message and Recommendations.
public protocol ErrorDetailProtocol : Codable {
     var code: String? { get set }
     var message: String? { get set }
     var recommendations: [String]? { get set }
}
