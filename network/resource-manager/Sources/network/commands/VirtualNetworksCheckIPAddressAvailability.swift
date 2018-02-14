import Foundation
import azureSwiftRuntime
public protocol VirtualNetworksCheckIPAddressAvailability  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var subscriptionId : String { get set }
    var ipAddress : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IPAddressAvailabilityResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworks {
// CheckIPAddressAvailability checks whether a private IP address is available for use.
internal class CheckIPAddressAvailabilityCommand : BaseCommand, VirtualNetworksCheckIPAddressAvailability {
    public var resourceGroupName : String
    public var virtualNetworkName : String
    public var subscriptionId : String
    public var ipAddress : String?
    public var apiVersion = "2018-01-01"

    public init(resourceGroupName: String, virtualNetworkName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.virtualNetworkName = virtualNetworkName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/CheckIPAddressAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{virtualNetworkName}"] = String(describing: self.virtualNetworkName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        if self.ipAddress != nil { queryParameters["ipAddress"] = String(describing: self.ipAddress!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(IPAddressAvailabilityResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (IPAddressAvailabilityResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: IPAddressAvailabilityResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
