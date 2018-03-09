// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// TransparentDataEncryptionActivityPropertiesProtocol is represents the properties of a database transparent data
// encryption Scan.
public protocol TransparentDataEncryptionActivityPropertiesProtocol : Codable {
     var status: TransparentDataEncryptionActivityStatusEnum? { get set }
     var percentComplete: Double? { get set }
}