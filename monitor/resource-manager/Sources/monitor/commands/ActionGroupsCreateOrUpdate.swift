import Foundation
import azureSwiftRuntime
public protocol ActionGroupsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var actionGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var actionGroup :  ActionGroupResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ActionGroupResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ActionGroups {
// CreateOrUpdate create a new action group or update an existing one.
internal class CreateOrUpdateCommand : BaseCommand, ActionGroupsCreateOrUpdate {
    public var resourceGroupName : String
    public var actionGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2018-03-01"
    public var actionGroup :  ActionGroupResourceProtocol?

    public init(resourceGroupName: String, actionGroupName: String, subscriptionId: String, actionGroup: ActionGroupResourceProtocol) {
        self.resourceGroupName = resourceGroupName
        self.actionGroupName = actionGroupName
        self.subscriptionId = subscriptionId
        self.actionGroup = actionGroup
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/actionGroups/{actionGroupName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{actionGroupName}"] = String(describing: self.actionGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = actionGroup
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(actionGroup)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
