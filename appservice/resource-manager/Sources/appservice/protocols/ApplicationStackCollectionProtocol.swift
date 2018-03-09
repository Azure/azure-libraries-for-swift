// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// ApplicationStackCollectionProtocol is collection of Application Stacks
public protocol ApplicationStackCollectionProtocol : Codable {
     var value: [ApplicationStackProtocol] { get set }
     var _nextLink: String? { get set }
}
