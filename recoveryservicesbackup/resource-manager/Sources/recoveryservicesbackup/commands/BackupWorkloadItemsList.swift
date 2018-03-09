import Foundation
import azureSwiftRuntime
public protocol BackupWorkloadItemsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var fabricName : String { get set }
    var containerName : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var skipToken : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (WorkloadItemResourceListProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BackupWorkloadItems {
// List provides a pageable list of workload item of a specific container according to the query filter and the
// pagination parameters.
    internal class ListCommand : BaseCommand, BackupWorkloadItemsList {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var vaultName : String
        public var resourceGroupName : String
        public var subscriptionId : String
        public var fabricName : String
        public var containerName : String
        public var apiVersion = "2016-12-01"
        public var filter : String?
        public var skipToken : String?

        public init(vaultName: String, resourceGroupName: String, subscriptionId: String, fabricName: String, containerName: String) {
            self.vaultName = vaultName
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.fabricName = fabricName
            self.containerName = containerName
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupFabrics/{fabricName}/protectionContainers/{containerName}/items"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{fabricName}"] = String(describing: self.fabricName)
            self.pathParameters["{containerName}"] = String(describing: self.containerName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
            if self.skipToken != nil { queryParameters["$skipToken"] = String(describing: self.skipToken!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(WorkloadItemResourceListData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (WorkloadItemResourceListProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: WorkloadItemResourceListData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
