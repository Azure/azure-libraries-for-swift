import Foundation
import azureSwiftRuntime
public protocol ContainerLogsList  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var containerGroupName : String { get set }
    var containerName : String { get set }
    var apiVersion : String { get set }
    var tail : Int32? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LogsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerLogs {
// List get the logs for a specified container instance in a specified resource group and container group.
internal class ListCommand : BaseCommand, ContainerLogsList {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var containerGroupName : String
    public var containerName : String
    public var apiVersion = "2018-02-01-preview"
    public var tail : Int32?

    public init(subscriptionId: String, resourceGroupName: String, containerGroupName: String, containerName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.containerGroupName = containerGroupName
        self.containerName = containerName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}/containers/{containerName}/logs"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{containerGroupName}"] = String(describing: self.containerGroupName)
        self.pathParameters["{containerName}"] = String(describing: self.containerName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.tail != nil { queryParameters["tail"] = String(describing: self.tail!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(LogsData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (LogsProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: LogsData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
