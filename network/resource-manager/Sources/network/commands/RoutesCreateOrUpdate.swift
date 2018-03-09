import Foundation
import azureSwiftRuntime
public protocol RoutesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var routeTableName : String { get set }
    var routeName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var routeParameters :  RouteProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RouteProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Routes {
// CreateOrUpdate creates or updates a route in the specified route table. This method may poll for completion. Polling
// can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, RoutesCreateOrUpdate {
        public var resourceGroupName : String
        public var routeTableName : String
        public var routeName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var routeParameters :  RouteProtocol?

        public init(resourceGroupName: String, routeTableName: String, routeName: String, subscriptionId: String, routeParameters: RouteProtocol) {
            self.resourceGroupName = resourceGroupName
            self.routeTableName = routeTableName
            self.routeName = routeName
            self.subscriptionId = subscriptionId
            self.routeParameters = routeParameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeTables/{routeTableName}/routes/{routeName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{routeTableName}"] = String(describing: self.routeTableName)
            self.pathParameters["{routeName}"] = String(describing: self.routeName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = routeParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(routeParameters as? RouteData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
            client.executeAsyncLRO(command: self) {
                (result: RouteData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
