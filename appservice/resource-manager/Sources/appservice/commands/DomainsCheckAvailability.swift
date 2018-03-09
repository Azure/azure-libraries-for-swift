import Foundation
import azureSwiftRuntime
public protocol DomainsCheckAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var identifier :  NameIdentifierProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (DomainAvailablilityCheckResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Domains {
// CheckAvailability check if a domain is available for registration.
    internal class CheckAvailabilityCommand : BaseCommand, DomainsCheckAvailability {
        public var subscriptionId : String
        public var apiVersion = "2015-04-01"
    public var identifier :  NameIdentifierProtocol?

        public init(subscriptionId: String, identifier: NameIdentifierProtocol) {
            self.subscriptionId = subscriptionId
            self.identifier = identifier
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DomainRegistration/checkDomainAvailability"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = identifier

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(identifier as? NameIdentifierData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(DomainAvailablilityCheckResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (DomainAvailablilityCheckResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DomainAvailablilityCheckResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
