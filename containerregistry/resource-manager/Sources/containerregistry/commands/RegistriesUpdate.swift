import Foundation
import azureSwiftRuntime
public protocol RegistriesUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var apiVersion : String { get set }
    var registryUpdateParameters :  RegistryUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RegistryProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Registries {
// Update updates a container registry with the specified parameters. This method may poll for completion. Polling can
// be canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding
// HTTP requests.
    internal class UpdateCommand : BaseCommand, RegistriesUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var registryName : String
        public var apiVersion = "2017-10-01"
    public var registryUpdateParameters :  RegistryUpdateParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, registryName: String, registryUpdateParameters: RegistryUpdateParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.registryName = registryName
            self.registryUpdateParameters = registryUpdateParameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{registryName}"] = String(describing: self.registryName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = registryUpdateParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(registryUpdateParameters as? RegistryUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RegistryData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RegistryProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: RegistryData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
