import Foundation
import azureSwiftRuntime
public protocol ServiceValidateProbe  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var validateProbeInput :  ValidateProbeInputProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ValidateProbeOutputProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// ValidateProbe check if the probe path is a valid path and the file can be accessed. Probe path is the path to a file
// hosted on the origin server to help accelerate the delivery of dynamic content via the CDN endpoint. This path is
// relative to the origin path specified in the endpoint configuration.
internal class ValidateProbeCommand : BaseCommand, ServiceValidateProbe {
    public var subscriptionId : String
    public var apiVersion = "2017-04-02"
    public var validateProbeInput :  ValidateProbeInputProtocol?

    public init(subscriptionId: String, validateProbeInput: ValidateProbeInputProtocol) {
        self.subscriptionId = subscriptionId
        self.validateProbeInput = validateProbeInput
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Cdn/validateProbe"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = validateProbeInput
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(validateProbeInput)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ValidateProbeOutputData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ValidateProbeOutputProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ValidateProbeOutputData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
