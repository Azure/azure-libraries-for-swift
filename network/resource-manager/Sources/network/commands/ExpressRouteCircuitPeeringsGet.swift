import Foundation
import azureSwiftRuntime
public protocol ExpressRouteCircuitPeeringsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var circuitName : String { get set }
    var peeringName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ExpressRouteCircuitPeeringProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ExpressRouteCircuitPeerings {
// Get gets the specified authorization from the specified express route circuit.
    internal class GetCommand : BaseCommand, ExpressRouteCircuitPeeringsGet {
        public var resourceGroupName : String
        public var circuitName : String
        public var peeringName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, circuitName: String, peeringName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.circuitName = circuitName
            self.peeringName = peeringName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{circuitName}"] = String(describing: self.circuitName)
            self.pathParameters["{peeringName}"] = String(describing: self.peeringName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ExpressRouteCircuitPeeringData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ExpressRouteCircuitPeeringProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ExpressRouteCircuitPeeringData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
