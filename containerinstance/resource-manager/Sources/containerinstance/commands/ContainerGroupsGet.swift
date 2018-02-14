import Foundation
import azureSwiftRuntime
public protocol ContainerGroupsGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var containerGroupName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ContainerGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerGroups {
// Get gets the properties of the specified container group in the specified subscription and resource group. The
// operation returns the properties of each container group including containers, image registry credentials, restart
// policy, IP address type, OS type, state, and volumes.
internal class GetCommand : BaseCommand, ContainerGroupsGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var containerGroupName : String
    public var apiVersion = "2018-02-01-preview"

    public init(subscriptionId: String, resourceGroupName: String, containerGroupName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.containerGroupName = containerGroupName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{containerGroupName}"] = String(describing: self.containerGroupName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ContainerGroupData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ContainerGroupProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ContainerGroupData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
