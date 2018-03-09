import Foundation
import azureSwiftRuntime
public protocol WorkspaceCollectionsMigrate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var apiVersion : String { get set }
    var _body :  MigrateWorkspaceCollectionRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WorkspaceCollections {
// Migrate migrates an existing Power BI Workspace Collection to a different resource group and/or subscription.
    internal class MigrateCommand : BaseCommand, WorkspaceCollectionsMigrate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var apiVersion = "2016-01-29"
    public var _body :  MigrateWorkspaceCollectionRequestProtocol?

        public init(subscriptionId: String, resourceGroupName: String, _body: MigrateWorkspaceCollectionRequestProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self._body = _body
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/moveResources"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = _body

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(_body as? MigrateWorkspaceCollectionRequestData)
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
