import Foundation
import azureSwiftRuntime
public protocol ProfilesGenerateSsoUri  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SsoUriProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Profiles {
// GenerateSsoUri generates a dynamic SSO URI used to sign in to the CDN supplemental portal. Supplemnetal portal is
// used to configure advanced feature capabilities that are not yet available in the Azure portal, such as core reports
// in a standard profile; rules engine, advanced HTTP reports, and real-time stats and alerts in a premium profile. The
// SSO URI changes approximately every 10 minutes.
    internal class GenerateSsoUriCommand : BaseCommand, ProfilesGenerateSsoUri {
        public var resourceGroupName : String
        public var profileName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-02"

        public init(resourceGroupName: String, profileName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.profileName = profileName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}/generateSsoUri"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{profileName}"] = String(describing: self.profileName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SsoUriData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SsoUriProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SsoUriData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
