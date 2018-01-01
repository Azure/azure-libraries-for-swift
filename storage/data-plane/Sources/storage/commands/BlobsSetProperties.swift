import Foundation
import azureSwiftRuntime
public protocol BlobsSetProperties  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var timeout : Int32? { get set }
    var comp : String { get set }
    var xMsBlobCacheControl : String?  { get set }
    var xMsBlobContentType : String?  { get set }
    var xMsBlobContentMd5 : String?  { get set }
    var xMsBlobContentEncoding : String?  { get set }
    var xMsBlobContentLanguage : String?  { get set }
    var leaseId : String?  { get set }
    var xMsBlobContentDisposition : String?  { get set }
    var xMsBlobContentLength : String?  { get set }
    var sequenceNumberAction : String?  { get set }
    var blobSequenceNumber : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Blobs {
// SetProperties the Set Blob Properties operation sets system properties on the blob
internal class SetPropertiesCommand : BaseCommand, BlobsSetProperties {
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

    public var sequenceNumberAction : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-sequence-number-action"] = newValue!
            }else {
                headerParameters["x-ms-sequence-number-action"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-sequence-number-action" }) {
                return headerParameters["x-ms-sequence-number-action"]
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

    public init(accountName: String, container: String, blob: String, comp: String) {
        self.accountName = accountName
        self.container = container
        self.blob = blob
        self.comp = comp
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
