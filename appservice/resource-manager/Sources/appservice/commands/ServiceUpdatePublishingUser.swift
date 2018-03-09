import Foundation
import azureSwiftRuntime
public protocol ServiceUpdatePublishingUser  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    var userDetails :  UserProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (UserProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// UpdatePublishingUser updates publishing user
    internal class UpdatePublishingUserCommand : BaseCommand, ServiceUpdatePublishingUser {
        public var apiVersion = "2016-03-01"
    public var userDetails :  UserProtocol?

        public init(userDetails: UserProtocol) {
            self.userDetails = userDetails
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Web/publishingUsers/web"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = userDetails

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(userDetails as? UserData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(UserData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (UserProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: UserData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
