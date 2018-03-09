import Foundation
import azureSwiftRuntime
public protocol DiagnosticsGetSiteAnalysisSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var siteName : String { get set }
    var diagnosticCategory : String { get set }
    var analysisName : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticAnalysisProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Diagnostics {
// GetSiteAnalysisSlot get Site Analysis
    internal class GetSiteAnalysisSlotCommand : BaseCommand, DiagnosticsGetSiteAnalysisSlot {
        public var resourceGroupName : String
        public var siteName : String
        public var diagnosticCategory : String
        public var analysisName : String
        public var slot : String
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"

        public init(resourceGroupName: String, siteName: String, diagnosticCategory: String, analysisName: String, slot: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.siteName = siteName
            self.diagnosticCategory = diagnosticCategory
            self.analysisName = analysisName
            self.slot = slot
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/slots/{slot}/diagnostics/{diagnosticCategory}/analyses/{analysisName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{siteName}"] = String(describing: self.siteName)
            self.pathParameters["{diagnosticCategory}"] = String(describing: self.diagnosticCategory)
            self.pathParameters["{analysisName}"] = String(describing: self.analysisName)
            self.pathParameters["{slot}"] = String(describing: self.slot)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DiagnosticAnalysisData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DiagnosticAnalysisProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DiagnosticAnalysisData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
