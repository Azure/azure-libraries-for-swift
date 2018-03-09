# Authentication in Azure Management Libraries for Java

To use the APIs in the Azure Management Libraries for Swift, as the first step you need to 
create an authenticated client. 

## Using an authentication file

> ​:warning: Note, file-based authentication is an experimental feature that may or may not be available in later releases. The file format it relies on is subject to change as well.

To create an authenticated Azure client:

```java
var filePath = "my.azureauth"
var applicationTokenCredentials = try ApplicationTokenCredentials.fromFile(path: filePath!)
var azureClient = AzureClient(atc: self.applicationTokenCredentials)
                .withRequestInterceptor(LogRequestInterceptor(showOptions: .all))
                .withResponseInterceptor(LogResponseInterceptor(showOptions: .all))
```

The authentication file, referenced as "my.azureauth" in the example above, contains the information of a service principal. You can generate this file using [Azure CLI 2.0](https://github.com/Azure/azure-cli) through the following command. Make sure you selected your subscription by `az account set --subscription <name or id>` and you have the privileges to create service principals.

```bash
az ad sp create-for-rbac --sdk-auth > my.azureauth
```

If you don't have Azure CLI installed, you can also do this in the [cloud shell](https://docs.microsoft.com/en-us/azure/cloud-shell/quickstart). Alternatively, you can login to Java SDK through other ways of authentication and create an auth file by following [this sample](https://github.com/Azure/azure-sdk-for-java/blob/master/azure-samples/src/main/java/com/microsoft/azure/management/graphrbac/samples/ManageServicePrincipal.java). For detailed explanations of the content in this auth file, or directions to create the auth file manually, please see [Auth file formats](#auth-file-formats).

## Auth file formats

Prior to this release, we've been using Java properties file format containing the following information:

```
subscription=########-####-####-####-############
client=########-####-####-####-############
tenant=########-####-####-####-############
key=XXXXXXXXXXXXXXXX
managementURI=https\://management.core.windows.net/
baseURL=https\://management.azure.com/
authURL=https\://login.windows.net/
```


The `clientId` and `tenantId` are from your service principal registration. If your service principal uses key authentication, `clientSecret` is the password credential added to the service principal. If your service principal uses certificate authentication, `clientCertificate` is the path to your pem or pfx certificate. In the case of a pfx certificate, you also need to provide the `clientCertificatePassword`.

This approach enables unattended authentication for your application (i.e. no interactive user login, no token management needed).  The `subscription` represents the subscription ID you want to use as the default subscription. The remaining URIs and URLs represent the end points for the needed Azure services, defaulted to Azure public cloud.

