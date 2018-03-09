import Foundation
import azureSwiftRuntime
public protocol AppServicePlansRebootWorker  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var workerName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.AppServicePlans {
// RebootWorker reboot a worker machine in an App Service plan.
    internal class RebootWorkerCommand : BaseCommand, AppServicePlansRebootWorker {
        public var resourceGroupName : String
        public var name : String
        public var workerName : String
        public var subscriptionId : String
        public var apiVersion = "2016-09-01"

        public init(resourceGroupName: String, name: String, workerName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.workerName = workerName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/workers/{workerName}/reboot"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{workerName}"] = String(describing: self.workerName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
