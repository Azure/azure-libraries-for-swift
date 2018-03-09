import Foundation
import azureSwiftRuntime
public protocol WorkspaceCollectionsCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var location : String { get set }
    var apiVersion : String { get set }
    var _body :  CheckNameRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CheckNameResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WorkspaceCollections {
// CheckNameAvailability verify the specified Power BI Workspace Collection name is valid and not already in use.
    internal class CheckNameAvailabilityCommand : BaseCommand, WorkspaceCollectionsCheckNameAvailability {
        public var subscriptionId : String
        public var location : String
        public var apiVersion = "2016-01-29"
    public var _body :  CheckNameRequestProtocol?

        public init(subscriptionId: String, location: String, _body: CheckNameRequestProtocol) {
            self.subscriptionId = subscriptionId
            self.location = location
            self._body = _body
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.PowerBI/locations/{location}/checkNameAvailability"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{location}"] = String(describing: self.location)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = _body

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(_body as? CheckNameRequestData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CheckNameResponseData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CheckNameResponseProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: CheckNameResponseData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
