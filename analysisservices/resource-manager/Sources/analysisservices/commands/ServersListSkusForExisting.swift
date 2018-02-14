import Foundation
import azureSwiftRuntime
public protocol ServersListSkusForExisting  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SkuEnumerationForExistingResourceResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// ListSkusForExisting lists eligible SKUs for an Analysis Services resource.
internal class ListSkusForExistingCommand : BaseCommand, ServersListSkusForExisting {
    public var resourceGroupName : String
    public var serverName : String
    public var subscriptionId : String
    public var apiVersion = "2017-08-01"

    public init(resourceGroupName: String, serverName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}/skus"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SkuEnumerationForExistingResourceResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SkuEnumerationForExistingResourceResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SkuEnumerationForExistingResourceResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
