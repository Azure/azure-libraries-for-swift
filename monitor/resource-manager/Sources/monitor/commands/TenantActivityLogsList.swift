import Foundation
import azureSwiftRuntime
public protocol TenantActivityLogsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    var filter : String? { get set }
    var select : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (EventDataCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.TenantActivityLogs {
// List gets the Activity Logs for the Tenant.<br>Everything that is applicable to the API to get the Activity Logs for
// the subscription is applicable to this API (the parameters, $filter, etc.).<br>One thing to point out here is that
// this API does *not* retrieve the logs at the individual subscription of the tenant but only surfaces the logs that
// were generated at the tenant level.
internal class ListCommand : BaseCommand, TenantActivityLogsList {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var apiVersion = "2015-04-01"
    public var filter : String?
    public var select : String?

    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/microsoft.insights/eventtypes/management/values"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
        if self.select != nil { queryParameters["$select"] = String(describing: self.select!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(EventDataCollectionData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (EventDataCollectionProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: EventDataCollectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
