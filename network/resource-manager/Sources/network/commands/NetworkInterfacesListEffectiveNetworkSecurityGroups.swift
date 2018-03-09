import Foundation
import azureSwiftRuntime
public protocol NetworkInterfacesListEffectiveNetworkSecurityGroups  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var networkInterfaceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (EffectiveNetworkSecurityGroupListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkInterfaces {
// ListEffectiveNetworkSecurityGroups gets all network security groups applied to a network interface. This method may
// poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
    internal class ListEffectiveNetworkSecurityGroupsCommand : BaseCommand, NetworkInterfacesListEffectiveNetworkSecurityGroups {
        public var resourceGroupName : String
        public var networkInterfaceName : String
        public var subscriptionId : String
        public var apiVersion = "2018-01-01"

        public init(resourceGroupName: String, networkInterfaceName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.networkInterfaceName = networkInterfaceName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/networkInterfaces/{networkInterfaceName}/effectiveNetworkSecurityGroups"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{networkInterfaceName}"] = String(describing: self.networkInterfaceName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(EffectiveNetworkSecurityGroupListResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (EffectiveNetworkSecurityGroupListResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: EffectiveNetworkSecurityGroupListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
