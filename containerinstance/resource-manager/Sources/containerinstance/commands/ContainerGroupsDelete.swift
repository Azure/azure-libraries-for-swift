import Foundation
import azureSwiftRuntime
public protocol ContainerGroupsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var containerGroupName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ContainerGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerGroups {
// Delete delete the specified container group in the specified subscription and resource group. The operation does not
// delete other resources provided by the user, such as volumes.
internal class DeleteCommand : BaseCommand, ContainerGroupsDelete {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var containerGroupName : String
    public var apiVersion = "2018-02-01-preview"

    public init(subscriptionId: String, resourceGroupName: String, containerGroupName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.containerGroupName = containerGroupName
        super.init()
        self.method = "Delete"
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
