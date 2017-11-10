import Foundation
import azureSwiftRuntime
// ListServiceSAS list service SAS credentials of a specific resource.
class StorageAccountsListServiceSASCommand : BaseCommand {
    var resourceGroupName : String?
    var accountName : String?
    var subscriptionId : String?
    var apiVersion : String? = "2017-06-01"
    var parameters :  ServiceSasParametersTypeProtocol?

    override init() {
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/ListServiceSas"
    }

    override func preCall()  {
        if self.resourceGroupName != nil { pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName!) }
        if self.accountName != nil { pathParameters["{accountName}"] = String(describing: self.accountName!) }
        if self.subscriptionId != nil { pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId!) }
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
        self.body = parameters
    }

    override func encodeBody() throws -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(parameters as! ServiceSasParametersType?)
        return jsonData
    }

    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(ListServiceSasResponseType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> ListServiceSasResponseTypeProtocol? {
        return try client.execute(command: self) as! ListServiceSasResponseTypeProtocol?
    }
    }
