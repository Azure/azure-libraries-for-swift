import Foundation
import azureSwiftRuntime
public protocol RouteFiltersGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var routeFilterName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RouteFilterProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RouteFilters {
// Get gets the specified route filter.
    internal class GetCommand : BaseCommand, RouteFiltersGet {
        public var resourceGroupName : String
        public var routeFilterName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
        public var expand : String?

        public init(resourceGroupName: String, routeFilterName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.routeFilterName = routeFilterName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{routeFilterName}"] = String(describing: self.routeFilterName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RouteFilterData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RouteFilterProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RouteFilterData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
