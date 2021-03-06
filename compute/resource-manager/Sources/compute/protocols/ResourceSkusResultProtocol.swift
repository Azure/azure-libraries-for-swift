// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ResourceSkusResultProtocol is the Compute List Skus operation response.
public protocol ResourceSkusResultProtocol : Codable {
     var value: [ResourceSkuProtocol] { get set }
     var _nextLink: String? { get set }
}
