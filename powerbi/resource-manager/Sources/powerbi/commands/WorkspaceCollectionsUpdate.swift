import Foundation
import azureSwiftRuntime
public protocol WorkspaceCollectionsUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var workspaceCollectionName : String { get set }
    var apiVersion : String { get set }
    var _body :  UpdateWorkspaceCollectionRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WorkspaceCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WorkspaceCollections {
// Update update an existing Power BI Workspace Collection with the specified properties.
    internal class UpdateCommand : BaseCommand, WorkspaceCollectionsUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var workspaceCollectionName : String
        public var apiVersion = "2016-01-29"
    public var _body :  UpdateWorkspaceCollectionRequestProtocol?

        public init(subscriptionId: String, resourceGroupName: String, workspaceCollectionName: String, _body: UpdateWorkspaceCollectionRequestProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.workspaceCollectionName = workspaceCollectionName
            self._body = _body
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PowerBI/workspaceCollections/{workspaceCollectionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{workspaceCollectionName}"] = String(describing: self.workspaceCollectionName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = _body

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(_body as? UpdateWorkspaceCollectionRequestData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WorkspaceCollectionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WorkspaceCollectionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WorkspaceCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
