import Foundation
import azureSwiftRuntime
public protocol AccountsListSkus  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CognitiveServicesAccountEnumerateSkusResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Accounts {
// ListSkus list available SKUs for the requested Cognitive Services account
internal class ListSkusCommand : BaseCommand, AccountsListSkus {
    public var resourceGroupName : String
    public var accountName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-18"

    public init(resourceGroupName: String, accountName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/skus"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CognitiveServicesAccountEnumerateSkusResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CognitiveServicesAccountEnumerateSkusResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CognitiveServicesAccountEnumerateSkusResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
