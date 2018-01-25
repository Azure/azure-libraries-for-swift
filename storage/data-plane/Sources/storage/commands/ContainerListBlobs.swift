import Foundation
import azureSwiftRuntime
public protocol ContainerListBlobs  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var prefix : String? { get set }
    var delimiter : String? { get set }
    var marker : String? { get set }
    var maxresults : Int32? { get set }
    var include : ListBlobsInclude? { get set }
    var timeout : Int32? { get set }
    var restype : String { get set }
    var comp : String { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BlobEnumerationResultsProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Container {
// ListBlobs the List Blobs operation returns a list of the blobs under the specified container
internal class ListBlobsCommand : BaseCommand, ContainerListBlobs {
    public var accountName : String
    public var container : String
    public var prefix : String?
    public var delimiter : String?
    public var marker : String?
    public var maxresults : Int32?
    public var include : ListBlobsInclude?
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
    
    let azureStorageKey: String

    public init(azureStorageKey: String, accountName: String, container: String, restype: String, comp: String) {
        self.azureStorageKey = azureStorageKey
        self.accountName = accountName
        self.container = container
        self.restype = restype
        self.comp = comp
        super.init()
        self.baseUrl = "https://{accountName}.blob.core.windows.net"
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/{container}"
        self.headerParameters = ["Content-Type":"application/xml; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{accountName}"] = String(describing: self.accountName)
        self.pathParameters["{container}"] = String(describing: self.container)
        if self.prefix != nil { queryParameters["prefix"] = String(describing: self.prefix!) }
        if self.delimiter != nil { queryParameters["delimiter"] = String(describing: self.delimiter!) }
        if self.marker != nil { queryParameters["marker"] = String(describing: self.marker!) }
        if self.maxresults != nil { queryParameters["maxresults"] = String(describing: self.maxresults!) }
        if self.include != nil { queryParameters["include"] = String(describing: self.include!) }
        if self.timeout != nil { queryParameters["timeout"] = String(describing: self.timeout!) }
        self.queryParameters["restype"] = String(describing: self.restype)
        self.queryParameters["comp"] = String(describing: self.comp)
        self.signRequest(azureStorageKey: self.azureStorageKey, storageAccountName: self.accountName)
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/xml"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
//            return try decoder.decode(BlobEnumerationResultsData?.self, from: data)
            do {
                let res = try decoder.decode(BlobEnumerationResultsData?.self, from: data)
                return res
                
            } catch {
                print("=== returnFunc error:", error)
            }
        }
        
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BlobEnumerationResultsProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BlobEnumerationResultsData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
