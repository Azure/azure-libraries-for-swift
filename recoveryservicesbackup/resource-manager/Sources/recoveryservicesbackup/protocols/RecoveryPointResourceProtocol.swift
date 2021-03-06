// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// RecoveryPointResourceProtocol is base class for backup copies. Workload-specific backup copies are derived from this
// class.
public protocol RecoveryPointResourceProtocol : ResourceProtocol {
     var properties: RecoveryPointProtocol? { get set }
}
