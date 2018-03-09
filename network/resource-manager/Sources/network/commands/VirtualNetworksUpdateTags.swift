import Foundation
import azureSwiftRuntime
public protocol VirtualNetworksUpdateTags  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualNetworkName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  TagsObjectProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualNetworkProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualNetworks {
// UpdateTags updates a virtual network tags. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class UpdateTagsCommand : BaseCommand, VirtualNetworksUpdateTags {
        public var resourceGroupName : String
        public var virtualNetworkName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var parameters :  TagsObjectProtocol?

        public init(resourceGroupName: String, virtualNetworkName: String, subscriptionId: String, parameters: TagsObjectProtocol) {
            self.resourceGroupName = resourceGroupName
            self.virtualNetworkName = virtualNetworkName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{virtualNetworkName}"] = String(describing: self.virtualNetworkName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? TagsObjectData)
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
            client.executeAsyncLRO(command: self) {
                (result: VirtualNetworkData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
