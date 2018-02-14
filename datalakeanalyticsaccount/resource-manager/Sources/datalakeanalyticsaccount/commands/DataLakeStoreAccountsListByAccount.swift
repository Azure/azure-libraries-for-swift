import Foundation
import azureSwiftRuntime
public protocol DataLakeStoreAccountsListByAccount  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var accountName : String { get set }
    var filter : String? { get set }
    var top : Int32? { get set }
    var skip : Int32? { get set }
    var select : String? { get set }
    var orderby : String? { get set }
    var count : Bool? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeStoreAccountInformationListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.DataLakeStoreAccounts {
// ListByAccount gets the first page of Data Lake Store accounts linked to the specified Data Lake Analytics account.
// The response includes a link to the next page, if any.
internal class ListByAccountCommand : BaseCommand, DataLakeStoreAccountsListByAccount {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var subscriptionId : String
    public var resourceGroupName : String
    public var accountName : String
    public var filter : String?
    public var top : Int32?
    public var skip : Int32?
    public var select : String?
    public var orderby : String?
    public var count : Bool?
    public var apiVersion = "2016-11-01"

    public init(subscriptionId: String, resourceGroupName: String, accountName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.accountName = accountName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeAnalytics/accounts/{accountName}/dataLakeStoreAccounts"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
        if self.top != nil { queryParameters["$top"] = String(describing: self.top!) }
        if self.skip != nil { queryParameters["$skip"] = String(describing: self.skip!) }
        if self.select != nil { queryParameters["$select"] = String(describing: self.select!) }
        if self.orderby != nil { queryParameters["$orderby"] = String(describing: self.orderby!) }
        if self.count != nil { queryParameters["$count"] = String(describing: self.count!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(DataLakeStoreAccountInformationListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeStoreAccountInformationListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: DataLakeStoreAccountInformationListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
