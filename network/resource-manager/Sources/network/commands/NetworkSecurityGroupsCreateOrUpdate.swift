import Foundation
import azureSwiftRuntime
public protocol NetworkSecurityGroupsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkSecurityGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  NetworkSecurityGroupProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NetworkSecurityGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkSecurityGroups {
// CreateOrUpdate creates or updates a network security group in the specified resource group. This method may poll for
// completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to cancel
// polling and any outstanding HTTP requests.
    internal class CreateOrUpdateCommand : BaseCommand, NetworkSecurityGroupsCreateOrUpdate {
        public var resourceGroupName : String
        public var networkSecurityGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"
    public var parameters :  NetworkSecurityGroupProtocol?

        public init(resourceGroupName: String, networkSecurityGroupName: String, subscriptionId: String, parameters: NetworkSecurityGroupProtocol) {
            self.resourceGroupName = resourceGroupName
            self.networkSecurityGroupName = networkSecurityGroupName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkSecurityGroups/{networkSecurityGroupName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{networkSecurityGroupName}"] = String(describing: self.networkSecurityGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? NetworkSecurityGroupData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NetworkSecurityGroupData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NetworkSecurityGroupProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: NetworkSecurityGroupData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
