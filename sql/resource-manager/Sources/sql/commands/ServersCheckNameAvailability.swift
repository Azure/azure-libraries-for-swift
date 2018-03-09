import Foundation
import azureSwiftRuntime
public protocol ServersCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckNameAvailabilityRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CheckNameAvailabilityResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// CheckNameAvailability determines whether a resource can be created with the specified name.
    internal class CheckNameAvailabilityCommand : BaseCommand, ServersCheckNameAvailability {
        public var subscriptionId : String
        public var apiVersion = "2014-04-01"
    public var parameters :  CheckNameAvailabilityRequestProtocol?

        public init(subscriptionId: String, parameters: CheckNameAvailabilityRequestProtocol) {
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Sql/checkNameAvailability"
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
                let encodedValue = try encoder.encode(parameters as? CheckNameAvailabilityRequestData)
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
