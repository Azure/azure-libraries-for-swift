import Foundation
import azureSwiftRuntime
public protocol ProfilesUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var profileUpdateParameters :  ProfileUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProfileProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Profiles {
// Update updates an existing CDN profile with the specified profile name under the specified subscription and resource
// group. This method may poll for completion. Polling can be canceled by passing the cancel channel argument. The
// channel will be used to cancel polling and any outstanding HTTP requests.
    internal class UpdateCommand : BaseCommand, ProfilesUpdate {
        public var resourceGroupName : String
        public var profileName : String
        public var subscriptionId : String
        public var apiVersion = "2017-04-02"
    public var profileUpdateParameters :  ProfileUpdateParametersProtocol?

        public init(resourceGroupName: String, profileName: String, subscriptionId: String, profileUpdateParameters: ProfileUpdateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.profileName = profileName
            self.subscriptionId = subscriptionId
            self.profileUpdateParameters = profileUpdateParameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Cdn/profiles/{profileName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{profileName}"] = String(describing: self.profileName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = profileUpdateParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(profileUpdateParameters as? ProfileUpdateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ProfileData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ProfileProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: ProfileData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
