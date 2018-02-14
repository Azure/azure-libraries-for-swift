import Foundation
import azureSwiftRuntime
public protocol UsersUpdate  {
    var headerParameters: [String: String] { get set }
    var upnOrObjectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  UserUpdateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Users {
// Update updates a user.
internal class UpdateCommand : BaseCommand, UsersUpdate {
    public var upnOrObjectId : String
    public var tenantID : String
    public var apiVersion = "1.6"
    public var parameters :  UserUpdateParametersProtocol?

    public init(upnOrObjectId: String, tenantID: String, parameters: UserUpdateParametersProtocol) {
        self.upnOrObjectId = upnOrObjectId
        self.tenantID = tenantID
        self.parameters = parameters
        super.init()
        self.method = "Patch"
        self.isLongRunningOperation = false
        self.path = "/{tenantID}/users/{upnOrObjectId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{upnOrObjectId}"] = String(describing: self.upnOrObjectId)
        self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
