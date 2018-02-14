import Foundation
import azureSwiftRuntime
public protocol VirtualNetworksUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var virtualNetwork :  VirtualNetworkFragmentProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualNetworkProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworks {
// Update modify properties of virtual networks.
internal class UpdateCommand : BaseCommand, VirtualNetworksUpdate {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var labName : String
    public var name : String
    public var apiVersion = "2016-05-15"
    public var virtualNetwork :  VirtualNetworkFragmentProtocol?

    public init(subscriptionId: String, resourceGroupName: String, labName: String, name: String, virtualNetwork: VirtualNetworkFragmentProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.labName = labName
        self.name = name
        self.virtualNetwork = virtualNetwork
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualnetworks/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{labName}"] = String(describing: self.labName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = virtualNetwork
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(virtualNetwork)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VirtualNetworkData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualNetworkProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VirtualNetworkData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
