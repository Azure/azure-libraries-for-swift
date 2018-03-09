// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// DataMaskingRuleProtocol is represents a database data masking rule.
public protocol DataMaskingRuleProtocol : ProxyResourceProtocol {
     var properties: DataMaskingRulePropertiesProtocol? { get set }
     var location: String? { get set }
     var kind: String? { get set }
}