import Foundation
import azureSwiftRuntime
public protocol GroupsIsMemberOf  {
    var headerParameters: [String: String] { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  CheckGroupMembershipParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckGroupMembershipResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Groups {
// IsMemberOf checks whether the specified user, group, contact, or service principal is a direct or transitive member
// of the specified group.
internal class IsMemberOfCommand : BaseCommand, GroupsIsMemberOf {
    public var tenantID : String
    public var apiVersion = "1.6"
    public var parameters :  CheckGroupMembershipParametersProtocol?

    public init(tenantID: String, parameters: CheckGroupMembershipParametersProtocol) {
        self.tenantID = tenantID
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/{tenantID}/isMemberOf"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
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

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(CheckGroupMembershipResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (CheckGroupMembershipResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: CheckGroupMembershipResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
