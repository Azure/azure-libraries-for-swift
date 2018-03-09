// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// WindowsPropertiesProtocol is windows specific update configuration.
public protocol WindowsPropertiesProtocol : Codable {
     var includedUpdateClassifications: WindowsUpdateClassesEnum? { get set }
     var excludedKbNumbers: [String]? { get set }
}