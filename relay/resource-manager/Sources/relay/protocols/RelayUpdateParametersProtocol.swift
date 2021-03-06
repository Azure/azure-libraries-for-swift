// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// RelayUpdateParametersProtocol is description of a namespace resource.
public protocol RelayUpdateParametersProtocol : ResourceNamespacePatchProtocol {
     var sku: SkuProtocol? { get set }
     var properties: RelayNamespacePropertiesProtocol? { get set }
}
