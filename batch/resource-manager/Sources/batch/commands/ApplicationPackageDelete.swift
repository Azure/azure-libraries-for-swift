import Foundation
import azureSwiftRuntime
public protocol ApplicationPackageDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var applicationId : String { get set }
    var version : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.ApplicationPackage {
// Delete deletes an application package record and its associated binary file.
internal class DeleteCommand : BaseCommand, ApplicationPackageDelete {
    public var resourceGroupName : String
    public var accountName : String
    public var applicationId : String
    public var version : String
    public var subscriptionId : String
    public var apiVersion = "2017-09-01"

    public init(resourceGroupName: String, accountName: String, applicationId: String, version: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        self.applicationId = applicationId
        self.version = version
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/applications/{applicationId}/versions/{version}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{applicationId}"] = String(describing: self.applicationId)
        self.pathParameters["{version}"] = String(describing: self.version)
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
