import Foundation
import azureSwiftRuntime
public protocol BlockBlobsPutBlockList  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var timeout : Int32? { get set }
    var comp : String { get set }
    var xMsBlobCacheControl : String?  { get set }
    var xMsBlobContentType : String?  { get set }
    var xMsBlobContentEncoding : String?  { get set }
    var xMsBlobContentLanguage : String?  { get set }
    var xMsBlobContentMd5 : String?  { get set }
    var xMsMeta : String?  { get set }
    var leaseId : String?  { get set }
    var xMsBlobContentDisposition : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    var blocks :  [String]?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.BlockBlobs {
// PutBlockList the Put Block List operation writes a blob by specifying the list of block IDs that make up the blob.
// In order to be written as part of a blob, a block must have been successfully written to the server in a prior Put
// Block operation. You can call Put Block List to update a blob by uploading only those blocks that have changed, then
// committing the new and existing blocks together. You can do this by specifying whether to commit a block from the
// committed block list or from the uncommitted block list, or to commit the most recently uploaded version of the
// block, whichever list it may belong to.
internal class PutBlockListCommand : BaseCommand, BlockBlobsPutBlockList {
    public var accountName : String
    public var container : String
    public var blob : String
    public var timeout : Int32?
    public var comp : String

    public var xMsBlobCacheControl : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-cache-control"] = newValue!
            }else {
                headerParameters["x-ms-blob-cache-control"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-cache-control" }) {
                return headerParameters["x-ms-blob-cache-control"]
            }else {
                return nil
            }
        }
    }

    public var xMsBlobContentType : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-content-type"] = newValue!
            }else {
                headerParameters["x-ms-blob-content-type"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-content-type" }) {
                return headerParameters["x-ms-blob-content-type"]
            }else {
                return nil
            }
        }
    }

    public var xMsBlobContentEncoding : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-content-encoding"] = newValue!
            }else {
                headerParameters["x-ms-blob-content-encoding"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-content-encoding" }) {
                return headerParameters["x-ms-blob-content-encoding"]
            }else {
                return nil
            }
        }
    }

    public var xMsBlobContentLanguage : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-content-language"] = newValue!
            }else {
                headerParameters["x-ms-blob-content-language"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-content-language" }) {
                return headerParameters["x-ms-blob-content-language"]
            }else {
                return nil
            }
        }
    }

    public var xMsBlobContentMd5 : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-content-md5"] = newValue!
            }else {
                headerParameters["x-ms-blob-content-md5"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-content-md5" }) {
                return headerParameters["x-ms-blob-content-md5"]
            }else {
                return nil
            }
        }
    }

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

    public var xMsBlobContentDisposition : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-content-disposition"] = newValue!
            }else {
                headerParameters["x-ms-blob-content-disposition"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-content-disposition" }) {
                return headerParameters["x-ms-blob-content-disposition"]
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
    public var blocks :  [String]?

    public init(accountName: String, container: String, blob: String, comp: String, blocks: [String]) {
        self.accountName = accountName
        self.container = container
        self.blob = blob
        self.comp = comp
        self.blocks = blocks
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
    self.body = blocks
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/xml"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(blocks)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
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
