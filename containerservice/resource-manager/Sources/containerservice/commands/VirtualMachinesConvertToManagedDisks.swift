import Foundation
import azureSwiftRuntime
public protocol VirtualMachinesConvertToManagedDisks  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationStatusResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachines {
// ConvertToManagedDisks converts virtual machine disks from blob-based to managed disks. Virtual machine must be
// stop-deallocated before invoking this operation. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class ConvertToManagedDisksCommand : BaseCommand, VirtualMachinesConvertToManagedDisks {
    public var resourceGroupName : String
    public var vmName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"

    public init(resourceGroupName: String, vmName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.vmName = vmName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/convertToManagedDisks"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vmName}"] = String(describing: self.vmName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
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
