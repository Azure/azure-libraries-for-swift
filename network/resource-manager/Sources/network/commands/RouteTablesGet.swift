import Foundation
import azureSwiftRuntime
public protocol RouteTablesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var routeTableName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RouteTableProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RouteTables {
// Get gets the specified route table.
    internal class GetCommand : BaseCommand, RouteTablesGet {
        public var resourceGroupName : String
        public var routeTableName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
        public var expand : String?

        public init(resourceGroupName: String, routeTableName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.routeTableName = routeTableName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{routeTableName}"] = String(describing: self.routeTableName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RouteTableData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RouteTableProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RouteTableData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
