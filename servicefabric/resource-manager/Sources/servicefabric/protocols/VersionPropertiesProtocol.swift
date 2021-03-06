// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VersionPropertiesProtocol is the properties of the version resource.
public protocol VersionPropertiesProtocol : Codable {
     var provisioningState: String? { get set }
     var appPackageUrl: String { get set }
     var defaultParameterList: [ApplicationParameterProtocol?]? { get set }
}
