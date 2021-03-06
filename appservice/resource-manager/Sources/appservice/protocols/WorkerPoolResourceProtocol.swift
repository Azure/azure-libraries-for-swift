// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// WorkerPoolResourceProtocol is worker pool of an App Service Environment ARM resource.
public protocol WorkerPoolResourceProtocol : ProxyOnlyResourceProtocol {
     var properties: WorkerPoolProtocol? { get set }
     var sku: SkuDescriptionProtocol? { get set }
}
