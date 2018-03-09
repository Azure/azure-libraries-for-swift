import Foundation
import azureSwiftRuntime
public protocol ExpressRouteCircuitsListRoutesTableSummary  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var circuitName : String { get set }
    var peeringName : String { get set }
    var devicePath : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ExpressRouteCircuitsRoutesTableSummaryListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ExpressRouteCircuits {
// ListRoutesTableSummary gets the currently advertised routes table summary associated with the express route circuit
// in a resource group. This method may poll for completion. Polling can be canceled by passing the cancel channel
// argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class ListRoutesTableSummaryCommand : BaseCommand, ExpressRouteCircuitsListRoutesTableSummary {
        public var resourceGroupName : String
        public var circuitName : String
        public var peeringName : String
        public var devicePath : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, circuitName: String, peeringName: String, devicePath: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.circuitName = circuitName
            self.peeringName = peeringName
            self.devicePath = devicePath
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/expressRouteCircuits/{circuitName}/peerings/{peeringName}/routeTablesSummary/{devicePath}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{circuitName}"] = String(describing: self.circuitName)
            self.pathParameters["{peeringName}"] = String(describing: self.peeringName)
            self.pathParameters["{devicePath}"] = String(describing: self.devicePath)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ExpressRouteCircuitsRoutesTableSummaryListResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ExpressRouteCircuitsRoutesTableSummaryListResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ExpressRouteCircuitsRoutesTableSummaryListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
