import Foundation
import azureSwiftRuntime
public protocol ContainerGroupsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var containerGroupName : String { get set }
    var apiVersion : String { get set }
    var containerGroup :  ContainerGroupProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ContainerGroupProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ContainerGroups {
// CreateOrUpdate create or update container groups with specified configurations.
    internal class CreateOrUpdateCommand : BaseCommand, ContainerGroupsCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var containerGroupName : String
        public var apiVersion = "2018-02-01-preview"
    public var containerGroup :  ContainerGroupProtocol?

        public init(subscriptionId: String, resourceGroupName: String, containerGroupName: String, containerGroup: ContainerGroupProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.containerGroupName = containerGroupName
            self.containerGroup = containerGroup
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerInstance/containerGroups/{containerGroupName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{containerGroupName}"] = String(describing: self.containerGroupName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = containerGroup

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(containerGroup as? ContainerGroupData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ContainerGroupData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ContainerGroupProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ContainerGroupData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
