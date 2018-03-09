import Foundation
import azureSwiftRuntime
public protocol ServerAutomaticTuningUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ServerAutomaticTuningProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServerAutomaticTuningProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServerAutomaticTuning {
// Update update automatic tuning options on server.
    internal class UpdateCommand : BaseCommand, ServerAutomaticTuningUpdate {
        public var resourceGroupName : String
        public var serverName : String
        public var subscriptionId : String
        public var apiVersion = "2017-03-01-preview"
    public var parameters :  ServerAutomaticTuningProtocol?

        public init(resourceGroupName: String, serverName: String, subscriptionId: String, parameters: ServerAutomaticTuningProtocol) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/automaticTuning/current"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ServerAutomaticTuningData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServerAutomaticTuningData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServerAutomaticTuningProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ServerAutomaticTuningData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
