import Foundation
import azureSwiftRuntime
public protocol ObjectsGetCurrentUser  {
    var headerParameters: [String: String] { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (AADObjectProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Objects {
// GetCurrentUser gets the details for the currently logged-in user.
internal class GetCurrentUserCommand : BaseCommand, ObjectsGetCurrentUser {
    public var tenantID : String
    public var apiVersion = "1.6"

    public init(tenantID: String) {
        self.tenantID = tenantID
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/{tenantID}/me"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(AADObjectData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (AADObjectProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: AADObjectData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
