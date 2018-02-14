import Foundation
import azureSwiftRuntime
public protocol UserAssignedIdentitiesGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IdentityProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.UserAssignedIdentities {
// Get gets the identity.
internal class GetCommand : BaseCommand, UserAssignedIdentitiesGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var resourceName : String
    public var apiVersion = "2015-08-31-preview"

    public init(subscriptionId: String, resourceGroupName: String, resourceName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.resourceName = resourceName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
