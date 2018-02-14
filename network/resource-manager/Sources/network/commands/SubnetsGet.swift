import Foundation
import azureSwiftRuntime
public protocol SubnetsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var subnetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SubnetProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Subnets {
// Get gets the specified subnet by virtual network and resource group.
internal class GetCommand : BaseCommand, SubnetsGet {
    public var resourceGroupName : String
    public var virtualNetworkName : String
    public var subnetName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var expand : String?

    public init(resourceGroupName: String, virtualNetworkName: String, subnetName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.virtualNetworkName = virtualNetworkName
        self.subnetName = subnetName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{virtualNetworkName}"] = String(describing: self.virtualNetworkName)
        self.pathParameters["{subnetName}"] = String(describing: self.subnetName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(SubnetData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SubnetProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: SubnetData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
