import Foundation
import azureSwiftRuntime
public protocol LoadBalancersGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var loadBalancerName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (LoadBalancerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LoadBalancers {
// Get gets the specified load balancer.
internal class GetCommand : BaseCommand, LoadBalancersGet {
    public var resourceGroupName : String
    public var loadBalancerName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var expand : String?

    public init(resourceGroupName: String, loadBalancerName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.loadBalancerName = loadBalancerName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{loadBalancerName}"] = String(describing: self.loadBalancerName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(LoadBalancerData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (LoadBalancerProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: LoadBalancerData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
