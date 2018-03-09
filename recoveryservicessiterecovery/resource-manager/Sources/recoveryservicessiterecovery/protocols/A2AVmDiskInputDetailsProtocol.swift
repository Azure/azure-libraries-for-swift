// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// A2AVmDiskInputDetailsProtocol is azure VM disk input details.
public protocol A2AVmDiskInputDetailsProtocol : Codable {
     var diskUri: String? { get set }
     var recoveryAzureStorageAccountId: String? { get set }
     var primaryStagingAzureStorageAccountId: String? { get set }
}