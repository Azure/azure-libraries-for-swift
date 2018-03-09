import Foundation
import azureSwiftRuntime
public protocol DiagnosticSettingsCategoryList  {
    var headerParameters: [String: String] { get set }
    var resourceUri : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticSettingsCategoryResourceCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DiagnosticSettingsCategory {
// List lists the diagnostic settings categories for the specified resource.
    internal class ListCommand : BaseCommand, DiagnosticSettingsCategoryList {
        public var resourceUri : String
        public var apiVersion = "2017-05-01-preview"

        public init(resourceUri: String) {
            self.resourceUri = resourceUri
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/{resourceUri}/providers/microsoft.insights/diagnosticSettingsCategories"
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
                let result = try decoder.decode(DiagnosticSettingsCategoryResourceCollectionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DiagnosticSettingsCategoryResourceCollectionProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DiagnosticSettingsCategoryResourceCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
