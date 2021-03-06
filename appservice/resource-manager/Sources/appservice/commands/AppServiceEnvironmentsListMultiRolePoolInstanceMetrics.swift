import Foundation
import azureSwiftRuntime
public protocol AppServiceEnvironmentsListMultiRolePoolInstanceMetrics  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var instance : String { get set }
    var subscriptionId : String { get set }
    var details : Bool? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ResourceMetricCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServiceEnvironments {
// ListMultiRolePoolInstanceMetrics get metrics for a specific instance of a multi-role pool of an App Service
// Environment.
    internal class ListMultiRolePoolInstanceMetricsCommand : BaseCommand, AppServiceEnvironmentsListMultiRolePoolInstanceMetrics {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var resourceGroupName : String
        public var name : String
        public var instance : String
        public var subscriptionId : String
        public var details : Bool?
        public var apiVersion = "2016-09-01"

        public init(resourceGroupName: String, name: String, instance: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.instance = instance
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/hostingEnvironments/{name}/multiRolePools/default/instances/{instance}metrics"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{instance}"] = String(describing: self.instance)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.details != nil { queryParameters["details"] = String(describing: self.details!) }
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
                let result = try decoder.decode(ResourceMetricCollectionData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ResourceMetricCollectionProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: ResourceMetricCollectionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
