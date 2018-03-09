import Foundation
import azureSwiftRuntime
public protocol AccountsCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var location : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckNameAvailabilityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NameAvailabilityInformationProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Accounts {
// CheckNameAvailability checks whether the specified account name is available or taken.
    internal class CheckNameAvailabilityCommand : BaseCommand, AccountsCheckNameAvailability {
        public var subscriptionId : String
        public var location : String
        public var apiVersion = "2016-11-01"
    public var parameters :  CheckNameAvailabilityParametersProtocol?

        public init(subscriptionId: String, location: String, parameters: CheckNameAvailabilityParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.location = location
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DataLakeAnalytics/locations/{location}/checkNameAvailability"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{location}"] = String(describing: self.location)
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

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NameAvailabilityInformationData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NameAvailabilityInformationProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: NameAvailabilityInformationData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
