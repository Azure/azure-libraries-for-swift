import Foundation
import azureSwiftRuntime
public protocol GroupsAddMember  {
    var headerParameters: [String: String] { get set }
    var groupObjectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    var parameters :  GroupAddMemberParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Groups {
// AddMember add a member to a group.
    internal class AddMemberCommand : BaseCommand, GroupsAddMember {
        public var groupObjectId : String
        public var tenantID : String
        public var apiVersion = "1.6"
    public var parameters :  GroupAddMemberParametersProtocol?

        public init(groupObjectId: String, tenantID: String, parameters: GroupAddMemberParametersProtocol) {
            self.groupObjectId = groupObjectId
            self.tenantID = tenantID
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/groups/{groupObjectId}/$links/members"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{groupObjectId}"] = String(describing: self.groupObjectId)
            self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? GroupAddMemberParametersData)
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
