import Foundation
import azureSwiftRuntime
public protocol DisksDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var userName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Disks {
// Delete delete disk. This operation can take a while to complete. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class DeleteCommand : BaseCommand, DisksDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var userName : String
        public var name : String
        public var apiVersion = "2016-05-15"

        public init(subscriptionId: String, resourceGroupName: String, labName: String, userName: String, name: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.userName = userName
            self.name = name
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/users/{userName}/disks/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{userName}"] = String(describing: self.userName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
