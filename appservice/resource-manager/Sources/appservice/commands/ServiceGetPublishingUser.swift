import Foundation
import azureSwiftRuntime
public protocol ServiceGetPublishingUser  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (UserProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// GetPublishingUser gets publishing user
    internal class GetPublishingUserCommand : BaseCommand, ServiceGetPublishingUser {
        public var apiVersion = "2016-03-01"

    public override init() {
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/providers/Microsoft.Web/publishingUsers/web"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
