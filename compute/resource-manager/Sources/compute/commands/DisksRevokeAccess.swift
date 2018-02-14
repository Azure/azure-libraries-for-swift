import Foundation
import azureSwiftRuntime
public protocol DisksRevokeAccess  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var diskName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Disks {
// RevokeAccess revokes access to a disk. This method may poll for completion. Polling can be canceled by passing the
// cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class RevokeAccessCommand : BaseCommand, DisksRevokeAccess {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var diskName : String
    public var apiVersion = "2017-03-30"

    public init(subscriptionId: String, resourceGroupName: String, diskName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.diskName = diskName
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/disks/{diskName}/endGetAccess"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{diskName}"] = String(describing: self.diskName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(OperationStatusResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: OperationStatusResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
