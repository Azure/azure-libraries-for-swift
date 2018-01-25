import Foundation
import azureSwiftRuntime
public protocol BlobsGet  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var snapshot : Date? { get set }
    var timeout : Int32? { get set }
    var range : String?  { get set }
    var leaseId : String?  { get set }
    var xMsRangeGetContentMd5 : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void ;
}

extension Commands.Blobs {
// Get the Get Blob operation reads or downloads a blob from the system, including its metadata and properties. You can
// also call Get Blob to read a snapshot.
internal class GetCommand : BaseCommand, BlobsGet {
    public var accountName : String
    public var container : String
    public var blob : String
    public var snapshot : Date?
    public var timeout : Int32?

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

    public var xMsRangeGetContentMd5 : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-range-get-content-md5"] = newValue!
            }else {
                headerParameters["x-ms-range-get-content-md5"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-range-get-content-md5" }) {
                return headerParameters["x-ms-range-get-content-md5"]
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
    
    let azureStorageKey: String

    public init(azureStorageKey: String, accountName: String, container: String, blob: String) {
        self.azureStorageKey = azureStorageKey
        self.accountName = accountName
        self.container = container
        self.blob = blob
        super.init()
        self.baseUrl = "https://{accountName}.blob.core.windows.net"
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/{container}/{blob}"
        self.headerParameters = ["Content-Type":"application/xml; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{container}"] = String(describing: self.container)
        self.pathParameters["{blob}"] = String(describing: self.blob)
        if self.snapshot != nil { queryParameters["snapshot"] = String(describing: self.snapshot!) }
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.signRequest(azureStorageKey: self.azureStorageKey, storageAccountName: self.accountName)
    }


    public override func returnFunc(data: Data) throws -> Decodable? {
        return DataWrapper(data: data);
    }
    
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Data?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: DataWrapper?, error: Error?) in
            let data = result?.data as Data?
            completionHandler(data, error)
        }
    }
}}
