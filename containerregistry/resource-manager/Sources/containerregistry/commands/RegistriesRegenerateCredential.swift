import Foundation
import azureSwiftRuntime
public protocol RegistriesRegenerateCredential  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var registryName : String { get set }
    var apiVersion : String { get set }
    var regenerateCredentialParameters :  RegenerateCredentialParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RegistryListCredentialsResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Registries {
// RegenerateCredential regenerates one of the login credentials for the specified container registry.
    internal class RegenerateCredentialCommand : BaseCommand, RegistriesRegenerateCredential {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var registryName : String
        public var apiVersion = "2017-10-01"
    public var regenerateCredentialParameters :  RegenerateCredentialParametersProtocol?

        public init(subscriptionId: String, resourceGroupName: String, registryName: String, regenerateCredentialParameters: RegenerateCredentialParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.registryName = registryName
            self.regenerateCredentialParameters = regenerateCredentialParameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ContainerRegistry/registries/{registryName}/regenerateCredential"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{registryName}"] = String(describing: self.registryName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = regenerateCredentialParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(regenerateCredentialParameters as? RegenerateCredentialParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RegistryListCredentialsResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RegistryListCredentialsResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RegistryListCredentialsResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
