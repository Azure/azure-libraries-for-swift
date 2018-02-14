import Foundation
import azureSwiftRuntime
public protocol FileServersGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var fileServerName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (FileServerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.FileServers {
// Get gets information about the specified Cluster.
internal class GetCommand : BaseCommand, FileServersGet {
    public var resourceGroupName : String
    public var fileServerName : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01-preview"

    public init(resourceGroupName: String, fileServerName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.fileServerName = fileServerName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BatchAI/fileServers/{fileServerName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{fileServerName}"] = String(describing: self.fileServerName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(FileServerData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (FileServerProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: FileServerData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
