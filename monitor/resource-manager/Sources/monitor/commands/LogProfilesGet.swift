import Foundation
import azureSwiftRuntime
public protocol LogProfilesGet  {
    var headerParameters: [String: String] { get set }
    var logProfileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (LogProfileResourceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.LogProfiles {
// Get gets the log profile.
    internal class GetCommand : BaseCommand, LogProfilesGet {
        public var logProfileName : String
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"

        public init(logProfileName: String, subscriptionId: String) {
            self.logProfileName = logProfileName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/microsoft.insights/logprofiles/{logProfileName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{logProfileName}"] = String(describing: self.logProfileName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(LogProfileResourceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (LogProfileResourceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: LogProfileResourceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
