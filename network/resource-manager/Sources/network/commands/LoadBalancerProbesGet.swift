import Foundation
import azureSwiftRuntime
public protocol LoadBalancerProbesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var loadBalancerName : String { get set }
    var probeName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProbeProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LoadBalancerProbes {
// Get gets load balancer probe.
    internal class GetCommand : BaseCommand, LoadBalancerProbesGet {
        public var resourceGroupName : String
        public var loadBalancerName : String
        public var probeName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, loadBalancerName: String, probeName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.loadBalancerName = loadBalancerName
            self.probeName = probeName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/probes/{probeName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{loadBalancerName}"] = String(describing: self.loadBalancerName)
            self.pathParameters["{probeName}"] = String(describing: self.probeName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ProbeData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ProbeProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ProbeData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
