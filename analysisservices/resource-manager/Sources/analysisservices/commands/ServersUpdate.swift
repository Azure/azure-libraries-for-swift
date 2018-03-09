import Foundation
import azureSwiftRuntime
public protocol ServersUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var serverUpdateParameters :  AnalysisServicesServerUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (AnalysisServicesServerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// Update updates the current state of the specified Analysis Services server. This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
    internal class UpdateCommand : BaseCommand, ServersUpdate {
        public var resourceGroupName : String
        public var serverName : String
        public var subscriptionId : String
        public var apiVersion = "2017-08-01"
    public var serverUpdateParameters :  AnalysisServicesServerUpdateParametersProtocol?

        public init(resourceGroupName: String, serverName: String, subscriptionId: String, serverUpdateParameters: AnalysisServicesServerUpdateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.serverName = serverName
            self.subscriptionId = subscriptionId
            self.serverUpdateParameters = serverUpdateParameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{serverName}"] = String(describing: self.serverName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = serverUpdateParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(serverUpdateParameters as? AnalysisServicesServerUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(AnalysisServicesServerData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (AnalysisServicesServerProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: AnalysisServicesServerData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
