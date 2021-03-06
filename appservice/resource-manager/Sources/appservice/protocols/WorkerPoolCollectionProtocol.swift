// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// WorkerPoolCollectionProtocol is collection of worker pools.
public protocol WorkerPoolCollectionProtocol : Codable {
     var value: [WorkerPoolResourceProtocol] { get set }
     var _nextLink: String? { get set }
}
