// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// BatchAccountKeysProtocol is a set of Azure Batch account keys.
public protocol BatchAccountKeysProtocol : Codable {
     var accountName: String? { get set }
     var primary: String? { get set }
     var secondary: String? { get set }
}
