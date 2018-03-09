// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SkuProtocol is defines the SKU of an Azure Search Service, which determines price tier and capacity limits.
public protocol SkuProtocol : Codable {
     var name: SkuNameEnum? { get set }
}