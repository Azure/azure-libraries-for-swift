import Foundation
import azureSwiftRuntime
public protocol ServiceSetProperties  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var timeout : Int32? { get set }
    var restype : String { get set }
    var comp : String { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    var storageServiceProperties :  StorageServicePropertiesProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Service {
// SetProperties sets properties for a storage account's Blob service endpoint, including properties for Storage
// Analytics and CORS (Cross-Origin Resource Sharing) rules
internal class SetPropertiesCommand : BaseCommand, ServiceSetProperties {
    public var accountName : String
    public var timeout : Int32?
    public var restype : String
    public var comp : String

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
    public var storageServiceProperties :  StorageServicePropertiesProtocol?

    public init(accountName: String, restype: String, comp: String, storageServiceProperties: StorageServicePropertiesProtocol) {
        self.accountName = accountName
        self.restype = restype
        self.comp = comp
        self.storageServiceProperties = storageServiceProperties
        super.init()
        self.baseUrl = "https://{accountName}.blob.core.windows.net"
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/"
        self.headerParameters = ["Content-Type":"application/xml; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        if self.timeout != nil { queryParameters["{timeout}"] = String(describing: self.timeout!) }
        self.queryParameters["{restype}"] = String(describing: self.restype)
        self.queryParameters["{comp}"] = String(describing: self.comp)
    self.body = storageServiceProperties
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/xml"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(storageServiceProperties)
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
