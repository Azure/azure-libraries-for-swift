import Foundation
import azureSwiftRuntime
public protocol SubnetsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var subnetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var subnetParameters :  SubnetProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SubnetProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Subnets {
// CreateOrUpdate creates or updates a subnet in the specified virtual network. This method may poll for completion.
// Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any
// outstanding HTTP requests.
internal class CreateOrUpdateCommand : BaseCommand, SubnetsCreateOrUpdate {
    public var resourceGroupName : String
    public var virtualNetworkName : String
    public var subnetName : String
    public var subscriptionId : String
    public var apiVersion = "2018-01-01"
    public var subnetParameters :  SubnetProtocol?

    public init(resourceGroupName: String, virtualNetworkName: String, subnetName: String, subscriptionId: String, subnetParameters: SubnetProtocol) {
        self.resourceGroupName = resourceGroupName
        self.virtualNetworkName = virtualNetworkName
        self.subnetName = subnetName
        self.subscriptionId = subscriptionId
        self.subnetParameters = subnetParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{virtualNetworkName}"] = String(describing: self.virtualNetworkName)
        self.pathParameters["{subnetName}"] = String(describing: self.subnetName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = subnetParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(subnetParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
        client.executeAsyncLRO(command: self) {
            (result: SubnetData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
