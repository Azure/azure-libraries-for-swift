import Foundation
import azureSwiftRuntime
public protocol AccountsCreate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var apiVersion : String { get set }
    var parameters :  CreateDataLakeAnalyticsAccountParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeAnalyticsAccountProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Accounts {
// Create creates the specified Data Lake Analytics account. This supplies the user with computation services for Data
// Lake Analytics workloads. This method may poll for completion. Polling can be canceled by passing the cancel channel
// argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class CreateCommand : BaseCommand, AccountsCreate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var apiVersion = "2016-11-01"
    public var parameters :  CreateDataLakeAnalyticsAccountParametersProtocol?

    public init(subscriptionId: String, resourceGroupName: String, accountName: String, parameters: CreateDataLakeAnalyticsAccountParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeAnalytics/accounts/{accountName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(DataLakeAnalyticsAccountData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeAnalyticsAccountProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: DataLakeAnalyticsAccountData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
