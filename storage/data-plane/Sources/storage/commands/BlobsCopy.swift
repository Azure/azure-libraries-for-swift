import Foundation
import azureSwiftRuntime
public protocol BlobsCopy  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var timeout : Int32? { get set }
    var xMsMeta : String?  { get set }
    var sourceIfModifiedSince : String?  { get set }
    var sourceIfUnmodifiedSince : String?  { get set }
    var sourceIfMatches : String?  { get set }
    var sourceIfNoneMatch : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var copySource : String?  { get set }
    var leaseId : String?  { get set }
    var sourceLeaseId : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Blobs {
// Copy the Copy Blob operation copies a blob or an internet resource to a new blob.
internal class CopyCommand : BaseCommand, BlobsCopy {
    public var accountName : String
    public var container : String
    public var blob : String
    public var timeout : Int32?

    public var xMsMeta : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-meta"] = newValue!
            }else {
                headerParameters["x-ms-meta"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-meta" }) {
                return headerParameters["x-ms-meta"]
            }else {
                return nil
            }
        }
    }

    public var sourceIfModifiedSince : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-source-if-modified-since"] = newValue!
            }else {
                headerParameters["x-ms-source-if-modified-since"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-source-if-modified-since" }) {
                return headerParameters["x-ms-source-if-modified-since"]
            }else {
                return nil
            }
        }
    }

    public var sourceIfUnmodifiedSince : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-source-if-unmodified-since"] = newValue!
            }else {
                headerParameters["x-ms-source-if-unmodified-since"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-source-if-unmodified-since" }) {
                return headerParameters["x-ms-source-if-unmodified-since"]
            }else {
                return nil
            }
        }
    }

    public var sourceIfMatches : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-source-if-match"] = newValue!
            }else {
                headerParameters["x-ms-source-if-match"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-source-if-match" }) {
                return headerParameters["x-ms-source-if-match"]
            }else {
                return nil
            }
        }
    }

    public var sourceIfNoneMatch : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-source-if-none-match"] = newValue!
            }else {
                headerParameters["x-ms-source-if-none-match"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-source-if-none-match" }) {
                return headerParameters["x-ms-source-if-none-match"]
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

    public var copySource : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-copy-source"] = newValue!
            }else {
                headerParameters["x-ms-copy-source"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-copy-source" }) {
                return headerParameters["x-ms-copy-source"]
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

    public var sourceLeaseId : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-source-lease-id"] = newValue!
            }else {
                headerParameters["x-ms-source-lease-id"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-source-lease-id" }) {
                return headerParameters["x-ms-source-lease-id"]
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

    public init(accountName: String, container: String, blob: String) {
        self.accountName = accountName
        self.container = container
        self.blob = blob
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
