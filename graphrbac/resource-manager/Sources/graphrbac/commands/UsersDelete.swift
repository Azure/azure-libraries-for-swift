import Foundation
import azureSwiftRuntime
public protocol UsersDelete  {
    var headerParameters: [String: String] { get set }
    var upnOrObjectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Users {
// Delete delete a user.
    internal class DeleteCommand : BaseCommand, UsersDelete {
        public var upnOrObjectId : String
        public var tenantID : String
        public var apiVersion = "1.6"

        public init(upnOrObjectId: String, tenantID: String) {
            self.upnOrObjectId = upnOrObjectId
            self.tenantID = tenantID
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/users/{upnOrObjectId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{upnOrObjectId}"] = String(describing: self.upnOrObjectId)
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
