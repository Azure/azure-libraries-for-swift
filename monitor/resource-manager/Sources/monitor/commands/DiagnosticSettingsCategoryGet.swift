import Foundation
import azureSwiftRuntime
public protocol DiagnosticSettingsCategoryGet  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticSettingsCategoryResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DiagnosticSettingsCategory {
// Get gets the diagnostic settings category for the specified resource.
    internal class GetCommand : BaseCommand, DiagnosticSettingsCategoryGet {
        public var resourceUri : String
        public var name : String
        public var apiVersion = "2017-05-01-preview"

        public init(resourceUri: String, name: String) {
            self.resourceUri = resourceUri
            self.name = name
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/diagnosticSettingsCategories/{name}"
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
                let result = try decoder.decode(DiagnosticSettingsCategoryResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DiagnosticSettingsCategoryResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DiagnosticSettingsCategoryResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
