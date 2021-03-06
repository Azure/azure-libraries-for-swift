// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// Certificates is the REST API for Azure Logic Apps.
import Foundation
import azureSwiftRuntime
extension Commands {
public struct Certificates {
    public static func CreateOrUpdate(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, certificateName: String, certificate: IntegrationAccountCertificateProtocol) -> CertificatesCreateOrUpdate {
        return CreateOrUpdateCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, integrationAccountName: integrationAccountName, certificateName: certificateName, certificate: certificate)
    }
    public static func Delete(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, certificateName: String) -> CertificatesDelete {
        return DeleteCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, integrationAccountName: integrationAccountName, certificateName: certificateName)
    }
    public static func Get(subscriptionId: String, resourceGroupName: String, integrationAccountName: String, certificateName: String) -> CertificatesGet {
        return GetCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, integrationAccountName: integrationAccountName, certificateName: certificateName)
    }
    public static func ListByIntegrationAccounts(subscriptionId: String, resourceGroupName: String, integrationAccountName: String) -> CertificatesListByIntegrationAccounts {
        return ListByIntegrationAccountsCommand(subscriptionId: subscriptionId, resourceGroupName: resourceGroupName, integrationAccountName: integrationAccountName)
    }
}
}
