import Foundation
import azureSwiftRuntime
public protocol ProfilesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  ProfileProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ProfileProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Profiles {
// CreateOrUpdate create or update a Traffic Manager profile.
    internal class CreateOrUpdateCommand : BaseCommand, ProfilesCreateOrUpdate {
        public var resourceGroupName : String
        public var profileName : String
        public var subscriptionId : String
        public var apiVersion = "2017-05-01"
    public var parameters :  ProfileProtocol?

        public init(resourceGroupName: String, profileName: String, subscriptionId: String, parameters: ProfileProtocol) {
            self.resourceGroupName = resourceGroupName
            self.profileName = profileName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficmanagerprofiles/{profileName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{profileName}"] = String(describing: self.profileName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? ProfileData)
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
            client.executeAsync(command: self) {
                (result: ProfileData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
