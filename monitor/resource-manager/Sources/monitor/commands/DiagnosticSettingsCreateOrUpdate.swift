import Foundation
import azureSwiftRuntime
public protocol DiagnosticSettingsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var parameters :  DiagnosticSettingsResourceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticSettingsResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DiagnosticSettings {
// CreateOrUpdate creates or updates diagnostic settings for the specified resource.
    internal class CreateOrUpdateCommand : BaseCommand, DiagnosticSettingsCreateOrUpdate {
        public var resourceUri : String
        public var name : String
        public var apiVersion = "2017-05-01-preview"
    public var parameters :  DiagnosticSettingsResourceProtocol?

        public init(resourceUri: String, name: String, parameters: DiagnosticSettingsResourceProtocol) {
            self.resourceUri = resourceUri
            self.name = name
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/diagnosticSettings/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? DiagnosticSettingsResourceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DiagnosticSettingsResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DiagnosticSettingsResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DiagnosticSettingsResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
