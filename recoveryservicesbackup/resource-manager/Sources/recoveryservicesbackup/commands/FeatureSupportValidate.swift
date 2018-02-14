import Foundation
import azureSwiftRuntime
public protocol FeatureSupportValidate  {
    var headerParameters: [String: String] { get set }
    var azureRegion : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  FeatureSupportRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AzureVMResourceFeatureSupportResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.FeatureSupport {
// Validate sends the validate request.
internal class ValidateCommand : BaseCommand, FeatureSupportValidate {
    public var azureRegion : String
    public var subscriptionId : String
    public var apiVersion = "2017-07-01"
    public var parameters :  FeatureSupportRequestProtocol?

    public init(azureRegion: String, subscriptionId: String, parameters: FeatureSupportRequestProtocol) {
        self.azureRegion = azureRegion
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/providers/Microsoft.RecoveryServices/locations/{azureRegion}/backupValidateFeatures"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{azureRegion}"] = String(describing: self.azureRegion)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(AzureVMResourceFeatureSupportResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (AzureVMResourceFeatureSupportResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: AzureVMResourceFeatureSupportResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
