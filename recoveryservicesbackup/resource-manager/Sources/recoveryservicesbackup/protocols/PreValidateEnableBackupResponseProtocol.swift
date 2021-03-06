// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PreValidateEnableBackupResponseProtocol is response contract for enable backup validation request
public protocol PreValidateEnableBackupResponseProtocol : Codable {
     var status: ValidationStatusEnum? { get set }
     var errorCode: String? { get set }
     var errorMessage: String? { get set }
     var recommendation: String? { get set }
     var containerName: String? { get set }
     var protectedItemName: String? { get set }
}
