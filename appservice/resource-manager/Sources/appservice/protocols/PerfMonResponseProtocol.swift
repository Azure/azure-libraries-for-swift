// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PerfMonResponseProtocol is performance monitor API response.
public protocol PerfMonResponseProtocol : Codable {
     var code: String? { get set }
     var message: String? { get set }
     var data: PerfMonSetProtocol? { get set }
}