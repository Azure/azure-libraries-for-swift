import Foundation
import azureSwiftRuntime
public protocol WebAppsGetWebSiteContainerLogsZip  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Data?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// GetWebSiteContainerLogsZip gets the ZIP archived docker log files for the given site
    internal class GetWebSiteContainerLogsZipCommand : BaseCommand, WebAppsGetWebSiteContainerLogsZip {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"

        public init(resourceGroupName: String, name: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/containerlogs/zip/download"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            return DataWrapper(data: data);
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: DataWrapper?, error: Error?) in
                let data = result?.data as Data?
                completionHandler(data!, error)
            }
        }
    }
}
