import Foundation
import azureSwiftRuntime
public protocol AccountsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var filter : String? { get set }
    var top : Int32? { get set }
    var skip : Int32? { get set }
    var select : String? { get set }
    var orderby : String? { get set }
    var count : Bool? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeStoreAccountListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Accounts {
// List lists the Data Lake Store accounts within the subscription. The response includes a link to the next page of
// results, if any.
internal class ListCommand : BaseCommand, AccountsList {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var subscriptionId : String
    public var filter : String?
    public var top : Int32?
    public var skip : Int32?
    public var select : String?
    public var orderby : String?
    public var count : Bool?
    public var apiVersion = "2016-11-01"

    public init(subscriptionId: String) {
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.DataLakeStore/accounts"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
            let result = try decoder.decode(DataLakeStoreAccountListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (DataLakeStoreAccountListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: DataLakeStoreAccountListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
