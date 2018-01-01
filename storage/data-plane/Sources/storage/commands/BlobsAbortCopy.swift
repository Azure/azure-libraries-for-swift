import Foundation
import azureSwiftRuntime
public protocol BlobsAbortCopy  {
    var headerParameters: [String: String] { get set }
    var accountName : String { get set }
    var container : String { get set }
    var blob : String { get set }
    var copyId : String { get set }
    var timeout : Int32? { get set }
    var comp : String { get set }
    var leaseId : String?  { get set }
    var copyActionAbortConstant : String?  { get set }
    var version : String?  { get set }
    var requestId : String?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Blobs {
// AbortCopy the Abort Copy Blob operation aborts a pending Copy Blob operation, and leaves a destination blob with
// zero length and full metadata.
internal class AbortCopyCommand : BaseCommand, BlobsAbortCopy {
    public var accountName : String
    public var container : String
    public var blob : String
    public var copyId : String
    public var timeout : Int32?
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

    public var copyActionAbortConstant : String? {
        set {
            if newValue != nil {
                headerParameters["x-ms-copy-action"] = newValue!
            }else {
                headerParameters["x-ms-copy-action"] = nil
            }
        }
        get {
            if headerParameters.contains(where: { $0.key == "x-ms-copy-action" }) {
                return headerParameters["x-ms-copy-action"]
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

    public init(accountName: String, container: String, blob: String, copyId: String, comp: String) {
        self.accountName = accountName
        self.container = container
        self.blob = blob
        self.copyId = copyId
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
        self.queryParameters["{copyid}"] = String(describing: self.copyId)
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
