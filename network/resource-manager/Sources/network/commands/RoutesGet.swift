import Foundation
import azureSwiftRuntime
public protocol RoutesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var routeTableName : String { get set }
    var routeName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RouteProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Routes {
// Get gets the specified route from a route table.
    internal class GetCommand : BaseCommand, RoutesGet {
        public var resourceGroupName : String
        public var routeTableName : String
        public var routeName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, routeTableName: String, routeName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.routeTableName = routeTableName
            self.routeName = routeName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}/routes/{routeName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{routeTableName}"] = String(describing: self.routeTableName)
            self.pathParameters["{routeName}"] = String(describing: self.routeName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RouteData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RouteProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RouteData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
