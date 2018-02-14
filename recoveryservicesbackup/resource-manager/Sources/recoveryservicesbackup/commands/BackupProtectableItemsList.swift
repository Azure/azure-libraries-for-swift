import Foundation
import azureSwiftRuntime
public protocol BackupProtectableItemsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var vaultName : String { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var skipToken : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (WorkloadProtectableItemResourceListProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.BackupProtectableItems {
// List provides a pageable list of protectable objects within your subscription according to the query filter and the
// pagination parameters.
internal class ListCommand : BaseCommand, BackupProtectableItemsList {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var vaultName : String
    public var resourceGroupName : String
    public var subscriptionId : String
    public var apiVersion = "2016-12-01"
    public var filter : String?
    public var skipToken : String?

    public init(vaultName: String, resourceGroupName: String, subscriptionId: String) {
        self.vaultName = vaultName
        self.resourceGroupName = resourceGroupName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/Subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupProtectableItems"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{vaultName}"] = String(describing: self.vaultName)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
            let result = try decoder.decode(WorkloadProtectableItemResourceListData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (WorkloadProtectableItemResourceListProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: WorkloadProtectableItemResourceListData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
