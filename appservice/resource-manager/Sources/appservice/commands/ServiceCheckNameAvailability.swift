import Foundation
import azureSwiftRuntime
public protocol ServiceCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var request :  ResourceNameAvailabilityRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ResourceNameAvailabilityProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// CheckNameAvailability check if a resource name is available.
internal class CheckNameAvailabilityCommand : BaseCommand, ServiceCheckNameAvailability {
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"
    public var request :  ResourceNameAvailabilityRequestProtocol?

    public init(subscriptionId: String, request: ResourceNameAvailabilityRequestProtocol) {
        self.subscriptionId = subscriptionId
        self.request = request
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Web/checknameavailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = request
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(request)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ResourceNameAvailabilityData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ResourceNameAvailabilityProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ResourceNameAvailabilityData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
