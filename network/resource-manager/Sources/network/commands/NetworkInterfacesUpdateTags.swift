import Foundation
import azureSwiftRuntime
public protocol NetworkInterfacesUpdateTags  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkInterfaceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  TagsObjectProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NetworkInterfaceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkInterfaces {
// UpdateTags updates a network interface tags. This method may poll for completion. Polling can be canceled by passing
// the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class UpdateTagsCommand : BaseCommand, NetworkInterfacesUpdateTags {
        public var resourceGroupName : String
        public var networkInterfaceName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var parameters :  TagsObjectProtocol?

        public init(resourceGroupName: String, networkInterfaceName: String, subscriptionId: String, parameters: TagsObjectProtocol) {
            self.resourceGroupName = resourceGroupName
            self.networkInterfaceName = networkInterfaceName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{networkInterfaceName}"] = String(describing: self.networkInterfaceName)
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
                let result = try decoder.decode(NetworkInterfaceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NetworkInterfaceProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: NetworkInterfaceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
