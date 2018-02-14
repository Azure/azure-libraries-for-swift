import Foundation
import azureSwiftRuntime
public protocol ActionGroupsEnableReceiver  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var actionGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var enableRequest :  EnableRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ActionGroups {
// EnableReceiver enable a receiver in an action group. This changes the receiver's status from Disabled to Enabled.
internal class EnableReceiverCommand : BaseCommand, ActionGroupsEnableReceiver {
    public var resourceGroupName : String
    public var actionGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2018-03-01"
    public var enableRequest :  EnableRequestProtocol?

    public init(resourceGroupName: String, actionGroupName: String, subscriptionId: String, enableRequest: EnableRequestProtocol) {
        self.resourceGroupName = resourceGroupName
        self.actionGroupName = actionGroupName
        self.subscriptionId = subscriptionId
        self.enableRequest = enableRequest
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/actionGroups/{actionGroupName}/subscribe"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{actionGroupName}"] = String(describing: self.actionGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = enableRequest
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(enableRequest)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
