// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ResourceProtocol is a definition of an Azure resource.
public protocol ResourceProtocol : Codable {
     var id: String? { get set }
     var name: String? { get set }
     var type: String? { get set }
     var location: String? { get set }
     var tags: [String:String]? { get set }
}