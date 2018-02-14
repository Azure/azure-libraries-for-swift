import Foundation
import azureSwiftRuntime
public protocol RegistriesCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var registryNameCheckRequest :  RegistryNameCheckRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RegistryNameStatusProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Registries {
// CheckNameAvailability checks whether the container registry name is available for use. The name must contain only
// alphanumeric characters, be globally unique, and between 5 and 50 characters in length.
internal class CheckNameAvailabilityCommand : BaseCommand, RegistriesCheckNameAvailability {
    public var subscriptionId : String
    public var apiVersion = "2017-10-01"
    public var registryNameCheckRequest :  RegistryNameCheckRequestProtocol?

    public init(subscriptionId: String, registryNameCheckRequest: RegistryNameCheckRequestProtocol) {
        self.subscriptionId = subscriptionId
        self.registryNameCheckRequest = registryNameCheckRequest
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.ContainerRegistry/checkNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = registryNameCheckRequest
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(registryNameCheckRequest)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RegistryNameStatusData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RegistryNameStatusProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RegistryNameStatusData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
