import Foundation
import azureSwiftRuntime
public protocol ContainerSetAcl  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var timeout : Int32? { get set }
    var restype : String { get set }
    var comp : String { get set }
    var leaseId : String?  { get set }
    var access : String?  { get set }
    var ifModifiedSince : String?  { get set }
    var ifUnmodifiedSince : String?  { get set }
    var ifMatches : String?  { get set }
    var ifNoneMatch : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    var containerAcl :  [SignedIdentifierProtocol?]?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Container {
// SetAcl sends the set acl request.
internal class SetAclCommand : BaseCommand, ContainerSetAcl {
    public var accountName : String
    public var container : String
    public var timeout : Int32?
    public var restype : String
    public var comp : String

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

    public var access : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-blob-public-access"] = newValue!
            }else {
                headerParameters["x-ms-blob-public-access"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-blob-public-access" }) {
                return headerParameters["x-ms-blob-public-access"]
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
    public var containerAcl :  [SignedIdentifierProtocol?]?
    
    let azureStorageKey: String

    public init(azureStorageKey: String, accountName: String, container: String, restype: String, comp: String) {
        self.azureStorageKey = azureStorageKey
        self.accountName = accountName
        self.container = container
        self.restype = restype
        self.comp = comp
        super.init()
        self.baseUrl = "https://{accountName}.blob.core.windows.net"
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/{container}"
        self.headerParameters = ["Content-Type":"application/xml; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{container}"] = String(describing: self.container)
        if self.timeout != nil { queryParameters["{timeout}"] = String(describing: self.timeout!) }
        self.queryParameters["restype"] = String(describing: self.restype)
        self.queryParameters["comp"] = String(describing: self.comp)
        self.body = containerAcl
        self.signRequest(azureStorageKey: self.azureStorageKey, storageAccountName: self.accountName)
    }

    public override func encodeBody() throws -> Data? {
        let contentType = "application/xml"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(containerAcl)
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
