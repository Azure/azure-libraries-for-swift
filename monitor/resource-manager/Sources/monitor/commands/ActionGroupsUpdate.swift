import Foundation
import azureSwiftRuntime
public protocol ActionGroupsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var actionGroupName : String { get set }
    var apiVersion : String { get set }
    var actionGroupPatch :  ActionGroupPatchBodyProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ActionGroupResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ActionGroups {
// Update updates an existing action group's tags. To update other fields use the CreateOrUpdate method.
    internal class UpdateCommand : BaseCommand, ActionGroupsUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var actionGroupName : String
        public var apiVersion = "2017-04-01"
    public var actionGroupPatch :  ActionGroupPatchBodyProtocol?

        public init(subscriptionId: String, resourceGroupName: String, actionGroupName: String, actionGroupPatch: ActionGroupPatchBodyProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.actionGroupName = actionGroupName
            self.actionGroupPatch = actionGroupPatch
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/actionGroups/{actionGroupName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{actionGroupName}"] = String(describing: self.actionGroupName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = actionGroupPatch

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(actionGroupPatch as? ActionGroupPatchBodyData)
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
