import Foundation
import azureSwiftRuntime
public protocol ActionGroupsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var actionGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ActionGroupResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ActionGroups {
// Get get an action group.
internal class GetCommand : BaseCommand, ActionGroupsGet {
    public var resourceGroupName : String
    public var actionGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2018-03-01"

    public init(resourceGroupName: String, actionGroupName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.actionGroupName = actionGroupName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/actionGroups/{actionGroupName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{actionGroupName}"] = String(describing: self.actionGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ActionGroupResourceData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ActionGroupResourceProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ActionGroupResourceData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
