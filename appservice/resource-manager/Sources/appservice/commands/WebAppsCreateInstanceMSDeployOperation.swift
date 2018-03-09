import Foundation
import azureSwiftRuntime
public protocol WebAppsCreateInstanceMSDeployOperation  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var instanceId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var mSDeploy :  MSDeployProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (MSDeployStatusProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// CreateInstanceMSDeployOperation invoke the MSDeploy web app extension. This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
    internal class CreateInstanceMSDeployOperationCommand : BaseCommand, WebAppsCreateInstanceMSDeployOperation {
        public var resourceGroupName : String
        public var name : String
        public var instanceId : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var mSDeploy :  MSDeployProtocol?

        public init(resourceGroupName: String, name: String, instanceId: String, subscriptionId: String, mSDeploy: MSDeployProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.instanceId = instanceId
            self.subscriptionId = subscriptionId
            self.mSDeploy = mSDeploy
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/extensions/MSDeploy"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{instanceId}"] = String(describing: self.instanceId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = mSDeploy

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(mSDeploy as? MSDeployData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(MSDeployStatusData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (MSDeployStatusProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: MSDeployStatusData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
