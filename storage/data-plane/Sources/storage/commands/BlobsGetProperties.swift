import Foundation
import azureSwiftRuntime

public struct BlobProperties {
    public let contentLength : Int
    public let xMsServerEncrypted : Bool
    public let eTag : String
    public let lastModified : Date
    public let contentType : String
    public let date : Date
}

extension BlobProperties: Decodable {
    enum CodingKeys: String, CodingKey {
        case contentLength = "Content-Length"
        case xMsServerEncrypted = "x-ms-server-encrypted"
        case eTag = "Etag"
        case lastModified = "Last-Modified"
        case contentType = "Content-Type"
        case date = "Date"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        contentLength = try container.decode(Int.self, forKey: .contentLength)
        xMsServerEncrypted = try container.decode(Bool.self, forKey: .xMsServerEncrypted)
        eTag = try container.decode(String.self, forKey: .eTag)
        lastModified = try container.decode(Date.self, forKey: .lastModified)
        contentType = try container.decode(String.self, forKey: .contentType)
        date = try container.decode(Date.self, forKey: .date)
    }
}
public protocol BlobsGetProperties  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var snapshot : Date? { get set }
    var timeout : Int32? { get set }
    var leaseId : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute (client: StorageRuntimeClient, completionHandler: @escaping (BlobProperties?, Error?)->Void)
    func execute (client: StorageRuntimeClient) throws -> BlobProperties
}

extension Commands.Blobs {
// GetProperties the Get Blob Properties operation returns all user-defined metadata, standard HTTP properties, and
// system properties for the blob. It does not return the content of the blob.
    internal class GetPropertiesCommand : BaseCommand, BlobsGetProperties {
        
        
    public var accountName : String
    public var container : String
    public var blob : String
    public var snapshot : Date?
    public var timeout : Int32?

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
        self.method = "Head"
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
        
    public func execute(client: StorageRuntimeClient, completionHandler: @escaping (BlobProperties?, Error?) -> Void) {
        client.executeAsyncHead(command: self) {
            (res, error) in
            completionHandler(res, error)
        }
    }
        
    public func execute(client: StorageRuntimeClient) throws -> BlobProperties {
        return try client.executeHead(command: self)
    }
}
}
