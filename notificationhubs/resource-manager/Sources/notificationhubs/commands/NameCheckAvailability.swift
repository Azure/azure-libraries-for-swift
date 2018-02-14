import Foundation
import azureSwiftRuntime
public protocol NameCheckAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckNameAvailabilityRequestParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckNameAvailabilityResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Name {
// CheckAvailability checks the availability of the given service namespace across all Azure subscriptions. This is
// useful because the domain name is created based on the service namespace name.
internal class CheckAvailabilityCommand : BaseCommand, NameCheckAvailability {
    public var subscriptionId : String
    public var apiVersion = "2017-04-01"
    public var parameters :  CheckNameAvailabilityRequestParametersProtocol?

    public init(subscriptionId: String, parameters: CheckNameAvailabilityRequestParametersProtocol) {
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.NotificationHubs/checkNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
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
            let result = try decoder.decode(CheckNameAvailabilityResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckNameAvailabilityResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CheckNameAvailabilityResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
