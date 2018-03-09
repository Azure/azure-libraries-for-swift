import Foundation
import azureSwiftRuntime
public protocol FileServersCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var fileServerName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  FileServerCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (FileServerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.FileServers {
// Create creates a file server. This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class CreateCommand : BaseCommand, FileServersCreate {
        public var resourceGroupName : String
        public var fileServerName : String
        public var subscriptionId : String
        public var apiVersion = "2017-09-01-preview"
    public var parameters :  FileServerCreateParametersProtocol?

        public init(resourceGroupName: String, fileServerName: String, subscriptionId: String, parameters: FileServerCreateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.fileServerName = fileServerName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BatchAI/fileServers/{fileServerName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{fileServerName}"] = String(describing: self.fileServerName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? FileServerCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(FileServerData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (FileServerProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: FileServerData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
