import Foundation
import azureSwiftRuntime
public protocol PageBlobsPutPage  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var timeout : Int32? { get set }
    var comp : String { get set }
    var range : String?  { get set }
    var pageWrite : String?  { get set }
    var leaseId : String?  { get set }
    var ifSequenceNumberLessThanOrEqualTo : String?  { get set }
    var ifSequenceNumberLessThan : String?  { get set }
    var ifSequenceNumberEqualTo : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    var _body :  Data?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.PageBlobs {
// PutPage the Put Page operation writes a range of pages to a page blob
internal class PutPageCommand : BaseCommand, PageBlobsPutPage {
    public var accountName : String
    public var container : String
    public var blob : String
    public var timeout : Int32?
    public var comp : String

    public var range : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-range"] = newValue!
            }else {
                headerParameters["x-ms-range"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-range" }) {
                return headerParameters["x-ms-range"]
            }else {
                return nil
            }
        }
    }

    public var pageWrite : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-page-write"] = newValue!
            }else {
                headerParameters["x-ms-page-write"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-page-write" }) {
                return headerParameters["x-ms-page-write"]
            }else {
                return nil
            }
        }
    }

    public var leaseId : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-lease-id"] = newValue!
            }else {
                headerParameters["x-ms-lease-id"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-lease-id" }) {
                return headerParameters["x-ms-lease-id"]
            }else {
                return nil
            }
        }
    }

    public var ifSequenceNumberLessThanOrEqualTo : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-if-sequence-number-le"] = newValue!
            }else {
                headerParameters["x-ms-if-sequence-number-le"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-if-sequence-number-le" }) {
                return headerParameters["x-ms-if-sequence-number-le"]
            }else {
                return nil
            }
        }
    }

    public var ifSequenceNumberLessThan : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-if-sequence-number-lt"] = newValue!
            }else {
                headerParameters["x-ms-if-sequence-number-lt"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-if-sequence-number-lt" }) {
                return headerParameters["x-ms-if-sequence-number-lt"]
            }else {
                return nil
            }
        }
    }

    public var ifSequenceNumberEqualTo : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-if-sequence-number-eq"] = newValue!
            }else {
                headerParameters["x-ms-if-sequence-number-eq"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-if-sequence-number-eq" }) {
                return headerParameters["x-ms-if-sequence-number-eq"]
            }else {
                return nil
            }
        }
    }

    public var ifModifiedSince : String? {
        set {
            if newValue != nil {
                headerParameters["If-Modified-Since"] = newValue!
            }else {
                headerParameters["If-Modified-Since"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "If-Modified-Since" }) {
                return headerParameters["If-Modified-Since"]
            }else {
                return nil
            }
        }
    }

    public var ifUnmodifiedSince : String? {
        set {
            if newValue != nil {
                headerParameters["If-Unmodified-Since"] = newValue!
            }else {
                headerParameters["If-Unmodified-Since"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "If-Unmodified-Since" }) {
                return headerParameters["If-Unmodified-Since"]
            }else {
                return nil
            }
        }
    }

    public var ifMatches : String? {
        set {
            if newValue != nil {
                headerParameters["If-Match"] = newValue!
            }else {
                headerParameters["If-Match"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "If-Match" }) {
                return headerParameters["If-Match"]
            }else {
                return nil
            }
        }
    }

    public var ifNoneMatch : String? {
        set {
            if newValue != nil {
                headerParameters["If-None-Match"] = newValue!
            }else {
                headerParameters["If-None-Match"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "If-None-Match" }) {
                return headerParameters["If-None-Match"]
            }else {
                return nil
            }
        }
    }

    public var version : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-version"] = newValue!
            }else {
                headerParameters["x-ms-version"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-version" }) {
                return headerParameters["x-ms-version"]
            }else {
                return nil
            }
        }
    }

    public var requestId : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-client-request-id"] = newValue!
            }else {
                headerParameters["x-ms-client-request-id"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-client-request-id" }) {
                return headerParameters["x-ms-client-request-id"]
            }else {
                return nil
            }
        }
    }
    public var _body :  Data?

    public init(accountName: String, container: String, blob: String, comp: String, _body: Data) {
        self.accountName = accountName
        self.container = container
        self.blob = blob
        self.comp = comp
        self._body = _body
        super.init()
        self.baseUrl = "https://{accountName}.blob.core.windows.net"
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/{container}/{blob}"
        self.headerParameters = ["Content-Type":"application/xml; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{container}"] = String(describing: self.container)
        self.pathParameters["{blob}"] = String(describing: self.blob)
        if self.timeout != nil { queryParameters["{timeout}"] = String(describing: self.timeout!) }
        self.queryParameters["{comp}"] = String(describing: self.comp)
    self.body = _body
}

    public override func encodeBody() throws -> Data? {
        return self._body
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
