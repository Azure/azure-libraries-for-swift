import Foundation
import azureSwiftRuntime
public protocol ServersCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var serverParameters :  AnalysisServicesServerProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AnalysisServicesServerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// Create provisions the specified Analysis Services server based on the configuration specified in the request. This
// method may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be
// used to cancel polling and any outstanding HTTP requests.
internal class CreateCommand : BaseCommand, ServersCreate {
    public var resourceGroupName : String
    public var serverName : String
    public var subscriptionId : String
    public var apiVersion = "2017-08-01"
    public var serverParameters :  AnalysisServicesServerProtocol?

    public init(resourceGroupName: String, serverName: String, subscriptionId: String, serverParameters: AnalysisServicesServerProtocol) {
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.subscriptionId = subscriptionId
        self.serverParameters = serverParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.AnalysisServices/servers/{serverName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = serverParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(serverParameters)
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
