import Foundation
import azureSwiftRuntime
public protocol DiagnosticsExecuteSiteAnalysis  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var siteName : String { get set }
    var diagnosticCategory : String { get set }
    var analysisName : String { get set }
    var subscriptionId : String { get set }
    var startTime : Date? { get set }
    var endTime : Date? { get set }
    var timeGrain : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DiagnosticAnalysisProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Diagnostics {
// ExecuteSiteAnalysis execute Analysis
    internal class ExecuteSiteAnalysisCommand : BaseCommand, DiagnosticsExecuteSiteAnalysis {
        public var resourceGroupName : String
        public var siteName : String
        public var diagnosticCategory : String
        public var analysisName : String
        public var subscriptionId : String
        public var startTime : Date?
        public var endTime : Date?
        public var timeGrain : String?
        public var apiVersion = "2016-03-01"

        public init(resourceGroupName: String, siteName: String, diagnosticCategory: String, analysisName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.siteName = siteName
            self.diagnosticCategory = diagnosticCategory
            self.analysisName = analysisName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{siteName}/diagnostics/{diagnosticCategory}/analyses/{analysisName}/execute"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{siteName}"] = String(describing: self.siteName)
            self.pathParameters["{diagnosticCategory}"] = String(describing: self.diagnosticCategory)
            self.pathParameters["{analysisName}"] = String(describing: self.analysisName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.startTime != nil { queryParameters["startTime"] = String(describing: self.startTime!) }
            if self.endTime != nil { queryParameters["endTime"] = String(describing: self.endTime!) }
            if self.timeGrain != nil { queryParameters["timeGrain"] = String(describing: self.timeGrain!) }
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
