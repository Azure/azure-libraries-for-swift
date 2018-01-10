import Foundation
import azureSwiftRuntime
public protocol BlobsPut  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var timeout : Int32? { get set }
    var cacheControl : String?  { get set }
    var xMsBlobContentType : String?  { get set }
    var xMsBlobContentEncoding : String?  { get set }
    var xMsBlobContentLanguage : String?  { get set }
    var xMsBlobContentMd5 : String?  { get set }
    var xMsBlobCacheControl : String?  { get set }
    var blobType : String?  { get set }
    var xMsMeta : String?  { get set }
    var leaseId : String?  { get set }
    var xMsBlobContentDisposition : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var xMsBlobContentLength : String?  { get set }
    var blobSequenceNumber : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    var optionalbody :  Data?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Blobs {
// Put the Put Blob operation creates a new block, page, or append blob, or updates the content of an existing block
// blob. Updating an existing block blob overwrites any existing metadata on the blob. Partial updates are not
// supported with Put Blob; the content of the existing blob is overwritten with the content of the new blob. To
// perform a partial update of the content of a block blob, use the Put Block List operation.
internal class PutCommand : BaseCommand, BlobsPut {
    public var accountName : String
    public var container : String
    public var blob : String
    public var timeout : Int32?

    public var cacheControl : String? {
        set {
            if newValue != nil {
                headerParameters["Cache-Control"] = newValue!
            }else {
                headerParameters["Cache-Control"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "Cache-Control" }) {
                return headerParameters["Cache-Control"]
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

    public var blobType : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-type"] = newValue!
            }else {
                headerParameters["x-ms-blob-type"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-type" }) {
                return headerParameters["x-ms-blob-type"]
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

    public var xMsBlobContentLength : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-content-length"] = newValue!
            }else {
                headerParameters["x-ms-blob-content-length"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-content-length" }) {
                return headerParameters["x-ms-blob-content-length"]
            }else {
                return nil
            }
        }
    }

    public var blobSequenceNumber : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-sequence-number"] = newValue!
            }else {
                headerParameters["x-ms-sequence-number"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-sequence-number" }) {
                return headerParameters["x-ms-sequence-number"]
            }else {
                return nil
            }
        }
    }

    public var version : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-version"] = newValue!
            } else {
                headerParameters["x-ms-version"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-version" }) {
                return headerParameters["x-ms-version"]
            } else {
                return nil
            }
        }
    }

    public var requestId : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-client-request-id"] = newValue!
            } else {
                headerParameters["x-ms-client-request-id"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-client-request-id" }) {
                return headerParameters["x-ms-client-request-id"]
            } else {
                return nil
            }
        }
    }
    
    public var optionalbody :  Data?

    let azureStorageKey: String
    
    public init(azureStorageKey: String, accountName: String, container: String, blob: String) {
        self.azureStorageKey = azureStorageKey
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
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.body = optionalbody
        
        var uriPath: String? = nil
        if !self.path.isEmpty {
            uriPath = self.path
            for (key, value) in self.pathParameters {
                uriPath = uriPath!.replacingOccurrences(of: key, with: value)
            }
        }
        
        do {
            try StorageAuth.signRequest(storageKey: self.azureStorageKey,
                storageAccountName: self.accountName,
                method: self.method,
                headers: &self.headerParameters,
                uriPath: uriPath,
                contentLength: self.optionalbody?.bytes.count,
                queryParamsMap: self.queryParameters)
        } catch {
            print("=== Error:", error)
        }        
    }

    public override func encodeBody() throws -> Data? {
        return self.optionalbody
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
