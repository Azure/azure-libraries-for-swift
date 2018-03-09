import Foundation
import azureSwiftRuntime
public protocol AppServiceEnvironmentsUpdateMultiRolePool  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var multiRolePoolEnvelope :  WorkerPoolResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WorkerPoolResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceEnvironments {
// UpdateMultiRolePool create or update a multi-role pool.
    internal class UpdateMultiRolePoolCommand : BaseCommand, AppServiceEnvironmentsUpdateMultiRolePool {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-09-01"
    public var multiRolePoolEnvelope :  WorkerPoolResourceProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, multiRolePoolEnvelope: WorkerPoolResourceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.multiRolePoolEnvelope = multiRolePoolEnvelope
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = multiRolePoolEnvelope

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(multiRolePoolEnvelope as? WorkerPoolResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(WorkerPoolResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WorkerPoolResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: WorkerPoolResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
