import Foundation
import azureSwiftRuntime
public protocol ExpressRouteCircuitsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var circuitName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ExpressRouteCircuitProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ExpressRouteCircuits {
// Get gets information about the specified express route circuit.
internal class GetCommand : BaseCommand, ExpressRouteCircuitsGet {
    public var resourceGroupName : String
    public var circuitName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, circuitName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.circuitName = circuitName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{circuitName}"] = String(describing: self.circuitName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ExpressRouteCircuitData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ExpressRouteCircuitProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ExpressRouteCircuitData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
