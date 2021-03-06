// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// WebJobPropertiesProtocol is webJob resource specific properties
public protocol WebJobPropertiesProtocol : Codable {
     var name: String? { get set }
     var runCommand: String? { get set }
     var url: String? { get set }
     var extraInfoUrl: String? { get set }
     var jobType: WebJobTypeEnum? { get set }
     var error: String? { get set }
     var usingSdk: Bool? { get set }
     var settings: [String:[String: String?]]? { get set }
}
