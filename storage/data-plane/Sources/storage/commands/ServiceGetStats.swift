import Foundation
import azureSwiftRuntime
public protocol ServiceGetStats  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var timeout : Int32? { get set }
    var restype : String { get set }
    var comp : String { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageServiceStatsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// GetStats retrieves statistics related to replication for the Blob service. It is only available on the secondary
// location endpoint when read-access geo-redundant replication is enabled for the storage account.
internal class GetStatsCommand : BaseCommand, ServiceGetStats {
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

    public init(accountName: String, restype: String, comp: String) {
        self.accountName = accountName
        self.restype = restype
        self.comp = comp
        super.init()
        self.baseUrl = "https://{accountName}.blob.core.windows.net"
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/"
        self.headerParameters = ["Content-Type":"application/xml; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        if self.timeout != nil { queryParameters["{timeout}"] = String(describing: self.timeout!) }
        self.queryParameters["{restype}"] = String(describing: self.restype)
        self.queryParameters["{comp}"] = String(describing: self.comp)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/xml"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            return try decoder.decode(StorageServiceStatsData?.self, from: data)
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (StorageServiceStatsProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: StorageServiceStatsData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
