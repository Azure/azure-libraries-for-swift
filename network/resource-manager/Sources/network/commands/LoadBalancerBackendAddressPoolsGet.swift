import Foundation
import azureSwiftRuntime
public protocol LoadBalancerBackendAddressPoolsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var loadBalancerName : String { get set }
    var backendAddressPoolName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BackendAddressPoolProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LoadBalancerBackendAddressPools {
// Get gets load balancer backend address pool.
internal class GetCommand : BaseCommand, LoadBalancerBackendAddressPoolsGet {
    public var resourceGroupName : String
    public var loadBalancerName : String
    public var backendAddressPoolName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, loadBalancerName: String, backendAddressPoolName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.loadBalancerName = loadBalancerName
        self.backendAddressPoolName = backendAddressPoolName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{loadBalancerName}"] = String(describing: self.loadBalancerName)
        self.pathParameters["{backendAddressPoolName}"] = String(describing: self.backendAddressPoolName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(BackendAddressPoolData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BackendAddressPoolProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BackendAddressPoolData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
