import Foundation
import azureSwiftRuntime
public protocol QueryKeysDelete  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var searchServiceName : String { get set }
    var key : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.QueryKeys {
// Delete deletes the specified query key. Unlike admin keys, query keys are not regenerated. The process for
// regenerating a query key is to delete and then recreate it.
internal class DeleteCommand : BaseCommand, QueryKeysDelete {
    public var resourceGroupName : String
    public var searchServiceName : String
    public var key : String
    public var subscriptionId : String
    public var apiVersion = "2015-08-19"
    public var clientRequestId : String?

    public init(resourceGroupName: String, searchServiceName: String, key: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.searchServiceName = searchServiceName
        self.key = key
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Delete"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/deleteQueryKey/{key}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{searchServiceName}"] = String(describing: self.searchServiceName)
        self.pathParameters["{key}"] = String(describing: self.key)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.clientRequestId != nil { headerParameters["x-ms-client-request-id"] = String(describing: self.clientRequestId!) }
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
