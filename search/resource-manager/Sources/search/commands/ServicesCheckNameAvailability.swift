import Foundation
import azureSwiftRuntime
public protocol ServicesCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var checkNameAvailabilityInput :  CheckNameAvailabilityInputProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CheckNameAvailabilityOutputProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Services {
// CheckNameAvailability checks whether or not the given Search service name is available for use. Search service names
// must be globally unique since they are part of the service URI (https://<name>.search.windows.net).
    internal class CheckNameAvailabilityCommand : BaseCommand, ServicesCheckNameAvailability {
        public var subscriptionId : String
        public var apiVersion = "2015-08-19"
        public var clientRequestId : String?
    public var checkNameAvailabilityInput :  CheckNameAvailabilityInputProtocol?

        public init(subscriptionId: String, checkNameAvailabilityInput: CheckNameAvailabilityInputProtocol) {
            self.subscriptionId = subscriptionId
            self.checkNameAvailabilityInput = checkNameAvailabilityInput
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Search/checkNameAvailability"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["x-ms-client-request-id"] = String(describing: self.clientRequestId!) }
            self.body = checkNameAvailabilityInput

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(checkNameAvailabilityInput as? CheckNameAvailabilityInputData)
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
