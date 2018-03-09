import Foundation
import azureSwiftRuntime
public protocol NodeReportsListByNode  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var nodeId : String { get set }
    var subscriptionId : String { get set }
    var filter : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DscNodeReportListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NodeReports {
// ListByNode retrieve the Dsc node report list by node id.
    internal class ListByNodeCommand : BaseCommand, NodeReportsListByNode {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var resourceGroupName : String
        public var automationAccountName : String
        public var nodeId : String
        public var subscriptionId : String
        public var filter : String?
        public var apiVersion = "2015-10-31"

        public init(resourceGroupName: String, automationAccountName: String, nodeId: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.nodeId = nodeId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodes/{nodeId}/reports"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{nodeId}"] = String(describing: self.nodeId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(DscNodeReportListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DscNodeReportListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: DscNodeReportListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
