// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ServicePrincipalListResultProtocol is server response for get tenant service principals API call.
public protocol ServicePrincipalListResultProtocol : Codable {
     var value: [ServicePrincipalProtocol?]? { get set }
     var odatanextLink: String? { get set }
}