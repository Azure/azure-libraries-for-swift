// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// AzureWorkloadErrorInfoProtocol is azure storage specific error information
public protocol AzureWorkloadErrorInfoProtocol : Codable {
     var errorCode: Int32? { get set }
     var errorString: String? { get set }
     var errorTitle: String? { get set }
     var recommendations: [String]? { get set }
     var additionalDetails: String? { get set }
}
