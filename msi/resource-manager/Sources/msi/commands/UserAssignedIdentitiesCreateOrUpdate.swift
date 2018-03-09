import Foundation
import azureSwiftRuntime
public protocol UserAssignedIdentitiesCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var apiVersion : String { get set }
    var parameters :  IdentityProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (IdentityProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.UserAssignedIdentities {
// CreateOrUpdate create or update an identity in the specified subscription and resource group.
    internal class CreateOrUpdateCommand : BaseCommand, UserAssignedIdentitiesCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var apiVersion = "2015-08-31-preview"
    public var parameters :  IdentityProtocol?

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String, parameters: IdentityProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? IdentityData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(IdentityData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (IdentityProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: IdentityData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
