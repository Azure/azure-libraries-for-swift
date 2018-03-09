import Foundation
import azureSwiftRuntime
public protocol ApplicationsDelete  {
    var headerParameters: [String: String] { get set }
    var applicationObjectId : String { get set }
    var tenantID : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Applications {
// Delete delete an application.
    internal class DeleteCommand : BaseCommand, ApplicationsDelete {
        public var applicationObjectId : String
        public var tenantID : String
        public var apiVersion = "1.6"

        public init(applicationObjectId: String, tenantID: String) {
            self.applicationObjectId = applicationObjectId
            self.tenantID = tenantID
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/{tenantID}/applications/{applicationObjectId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{applicationObjectId}"] = String(describing: self.applicationObjectId)
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
