import Foundation
import azureSwiftRuntime
public protocol GroupsRemoveMember  {
    var headerParameters: [String: String] { get set }
    var groupObjectId : String { get set }
    var memberObjectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Groups {
// RemoveMember remove a member from a group.
internal class RemoveMemberCommand : BaseCommand, GroupsRemoveMember {
    public var groupObjectId : String
    public var memberObjectId : String
    public var tenantID : String
    public var apiVersion = "1.6"

    public init(groupObjectId: String, memberObjectId: String, tenantID: String) {
        self.groupObjectId = groupObjectId
        self.memberObjectId = memberObjectId
        self.tenantID = tenantID
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/{tenantID}/groups/{groupObjectId}/$links/members/{memberObjectId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{groupObjectId}"] = String(describing: self.groupObjectId)
        self.pathParameters["{memberObjectId}"] = String(describing: self.memberObjectId)
        self.pathParameters["{tenantID}"] = String(describing: self.tenantID)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
