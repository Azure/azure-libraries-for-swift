import Foundation
import azureSwiftRuntime
public protocol NodeReportsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var nodeId : String { get set }
    var reportId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DscNodeReportProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NodeReports {
// Get retrieve the Dsc node report data by node id and report id.
    internal class GetCommand : BaseCommand, NodeReportsGet {
        public var resourceGroupName : String
        public var automationAccountName : String
        public var nodeId : String
        public var reportId : String
        public var subscriptionId : String
        public var apiVersion = "2015-10-31"

        public init(resourceGroupName: String, automationAccountName: String, nodeId: String, reportId: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.nodeId = nodeId
            self.reportId = reportId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports/{reportId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{nodeId}"] = String(describing: self.nodeId)
            self.pathParameters["{reportId}"] = String(describing: self.reportId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DscNodeReportData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DscNodeReportProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DscNodeReportData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
