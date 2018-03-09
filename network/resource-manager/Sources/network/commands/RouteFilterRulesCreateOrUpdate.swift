import Foundation
import azureSwiftRuntime
public protocol RouteFilterRulesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var routeFilterName : String { get set }
    var ruleName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var routeFilterRuleParameters :  RouteFilterRuleProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RouteFilterRuleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.RouteFilterRules {
// CreateOrUpdate creates or updates a route in the specified route filter. This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, RouteFilterRulesCreateOrUpdate {
        public var resourceGroupName : String
        public var routeFilterName : String
        public var ruleName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var routeFilterRuleParameters :  RouteFilterRuleProtocol?

        public init(resourceGroupName: String, routeFilterName: String, ruleName: String, subscriptionId: String, routeFilterRuleParameters: RouteFilterRuleProtocol) {
            self.resourceGroupName = resourceGroupName
            self.routeFilterName = routeFilterName
            self.ruleName = ruleName
            self.subscriptionId = subscriptionId
            self.routeFilterRuleParameters = routeFilterRuleParameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/routeFilters/{routeFilterName}/routeFilterRules/{ruleName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{routeFilterName}"] = String(describing: self.routeFilterName)
            self.pathParameters["{ruleName}"] = String(describing: self.ruleName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = routeFilterRuleParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(routeFilterRuleParameters as? RouteFilterRuleData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RouteFilterRuleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RouteFilterRuleProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: RouteFilterRuleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
