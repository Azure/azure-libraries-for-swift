import Foundation
import azureSwiftRuntime
public protocol ExpressRouteCircuitAuthorizationsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var circuitName : String { get set }
    var authorizationName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var authorizationParameters :  ExpressRouteCircuitAuthorizationProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ExpressRouteCircuitAuthorizationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ExpressRouteCircuitAuthorizations {
// CreateOrUpdate creates or updates an authorization in the specified express route circuit. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, ExpressRouteCircuitAuthorizationsCreateOrUpdate {
        public var resourceGroupName : String
        public var circuitName : String
        public var authorizationName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var authorizationParameters :  ExpressRouteCircuitAuthorizationProtocol?

        public init(resourceGroupName: String, circuitName: String, authorizationName: String, subscriptionId: String, authorizationParameters: ExpressRouteCircuitAuthorizationProtocol) {
            self.resourceGroupName = resourceGroupName
            self.circuitName = circuitName
            self.authorizationName = authorizationName
            self.subscriptionId = subscriptionId
            self.authorizationParameters = authorizationParameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/authorizations/{authorizationName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{circuitName}"] = String(describing: self.circuitName)
            self.pathParameters["{authorizationName}"] = String(describing: self.authorizationName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = authorizationParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(authorizationParameters as? ExpressRouteCircuitAuthorizationData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ExpressRouteCircuitAuthorizationData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ExpressRouteCircuitAuthorizationProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ExpressRouteCircuitAuthorizationData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
