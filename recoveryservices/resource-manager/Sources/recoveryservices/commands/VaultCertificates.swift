// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// VaultCertificates is the recovery Services Client
import Foundation
import azureSwiftRuntime
extension Commands {
public struct VaultCertificates {
    public static func Create(subscriptionId: String, resourceGroupName: String, vaultName: String, certificateName: String, certificateRequest: CertificateRequestProtocol) -> VaultCertificatesCreate {
        return CreateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, vaultName: vaultName, certificateName: certificateName, certificateRequest: certificateRequest)
    }
}
}
