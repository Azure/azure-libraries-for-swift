// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ResponseWithContinuationCustomImageProtocol is the response of a list operation.
public protocol ResponseWithContinuationCustomImageProtocol : Codable {
     var value: [CustomImageProtocol?]? { get set }
     var _nextLink: String? { get set }
}