import Foundation
import azureSwiftRuntime
public protocol ServerAzureADAdministratorsDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var administratorName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServerAzureADAdministratorProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerAzureADAdministrators {
// Delete deletes an existing server Active Directory Administrator. This method may poll for completion. Polling can
// be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding
// HTTP requests.
    internal class DeleteCommand : BaseCommand, ServerAzureADAdministratorsDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var serverName : String
        public var administratorName : String
        public var apiVersion = "2014-04-01"

        public init(subscriptionId: String, resourceGroupName: String, serverName: String, administratorName: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.administratorName = administratorName
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/administrators/{administratorName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{administratorName}"] = String(describing: self.administratorName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServerAzureADAdministratorData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServerAzureADAdministratorProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ServerAzureADAdministratorData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
