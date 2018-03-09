import Foundation
import azureSwiftRuntime
public protocol DiagnosticSettingsGet  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticSettingsResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DiagnosticSettings {
// Get gets the active diagnostic settings for the specified resource.
    internal class GetCommand : BaseCommand, DiagnosticSettingsGet {
        public var resourceUri : String
        public var name : String
        public var apiVersion = "2017-05-01-preview"

        public init(resourceUri: String, name: String) {
            self.resourceUri = resourceUri
            self.name = name
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/diagnosticSettings/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
