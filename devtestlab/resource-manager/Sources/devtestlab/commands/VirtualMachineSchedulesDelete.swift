import Foundation
import azureSwiftRuntime
public protocol VirtualMachineSchedulesDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var virtualMachineName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.VirtualMachineSchedules {
// Delete delete schedule.
internal class DeleteCommand : BaseCommand, VirtualMachineSchedulesDelete {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var labName : String
    public var virtualMachineName : String
    public var name : String
    public var apiVersion = "2016-05-15"

    public init(subscriptionId: String, resourceGroupName: String, labName: String, virtualMachineName: String, name: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.labName = labName
        self.virtualMachineName = virtualMachineName
        self.name = name
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/virtualmachines/{virtualMachineName}/schedules/{name}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{labName}"] = String(describing: self.labName)
        self.pathParameters["{virtualMachineName}"] = String(describing: self.virtualMachineName)
        self.pathParameters["{name}"] = String(describing: self.name)
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
