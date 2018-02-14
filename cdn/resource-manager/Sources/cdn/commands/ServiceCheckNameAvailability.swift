import Foundation
import azureSwiftRuntime
public protocol ServiceCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    var checkNameAvailabilityInput :  CheckNameAvailabilityInputProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckNameAvailabilityOutputProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// CheckNameAvailability check the availability of a resource name. This is needed for resources where name is globally
// unique, such as a CDN endpoint.
internal class CheckNameAvailabilityCommand : BaseCommand, ServiceCheckNameAvailability {
    public var apiVersion = "2017-04-02"
    public var checkNameAvailabilityInput :  CheckNameAvailabilityInputProtocol?

    public init(checkNameAvailabilityInput: CheckNameAvailabilityInputProtocol) {
        self.checkNameAvailabilityInput = checkNameAvailabilityInput
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Cdn/checkNameAvailability"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = checkNameAvailabilityInput
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(checkNameAvailabilityInput)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CheckNameAvailabilityOutputData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckNameAvailabilityOutputProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CheckNameAvailabilityOutputData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
