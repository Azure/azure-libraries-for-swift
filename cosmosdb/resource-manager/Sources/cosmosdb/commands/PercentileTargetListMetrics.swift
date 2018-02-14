import Foundation
import azureSwiftRuntime
public protocol PercentileTargetListMetrics  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var targetRegion : String { get set }
    var apiVersion : String { get set }
    var filter : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PercentileMetricListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PercentileTarget {
// ListMetrics retrieves the metrics determined by the given filter for the given account target region. This url is
// only for PBS and Replication Latency data
internal class ListMetricsCommand : BaseCommand, PercentileTargetListMetrics {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var targetRegion : String
    public var apiVersion = "2015-04-08"
    public var filter : String

    public init(subscriptionId: String, resourceGroupName: String, accountName: String, targetRegion: String, filter: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.targetRegion = targetRegion
        self.filter = filter
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DocumentDB/databaseAccounts/{accountName}/targetRegion/{targetRegion}/percentile/metrics"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{targetRegion}"] = String(describing: self.targetRegion)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        self.queryParameters["$filter"] = String(describing: self.filter)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "nil"
            }
            let result = try decoder.decode(PercentileMetricListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (PercentileMetricListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: PercentileMetricListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
