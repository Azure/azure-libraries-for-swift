import Foundation
import azureSwiftRuntime
public protocol RedisCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckNameAvailabilityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Redis {
// CheckNameAvailability checks that the redis cache name is valid and is not already in use.
    internal class CheckNameAvailabilityCommand : BaseCommand, RedisCheckNameAvailability {
        public var subscriptionId : String
        public var apiVersion = "2017-10-01"
    public var parameters :  CheckNameAvailabilityParametersProtocol?

        public init(subscriptionId: String, parameters: CheckNameAvailabilityParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Cache/CheckNameAvailability"
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
                let encodedValue = try encoder.encode(parameters as? CheckNameAvailabilityParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
