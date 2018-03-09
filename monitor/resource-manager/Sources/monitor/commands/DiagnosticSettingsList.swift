import Foundation
import azureSwiftRuntime
public protocol DiagnosticSettingsList  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticSettingsResourceCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DiagnosticSettings {
// List gets the active diagnostic settings list for the specified resource.
    internal class ListCommand : BaseCommand, DiagnosticSettingsList {
        public var resourceUri : String
        public var apiVersion = "2017-05-01-preview"

        public init(resourceUri: String) {
            self.resourceUri = resourceUri
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/diagnosticSettings"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceUri}"] = String(describing: self.resourceUri)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DiagnosticSettingsResourceCollectionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DiagnosticSettingsResourceCollectionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DiagnosticSettingsResourceCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
