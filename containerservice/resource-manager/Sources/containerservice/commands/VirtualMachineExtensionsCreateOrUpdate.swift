import Foundation
import azureSwiftRuntime
public protocol VirtualMachineExtensionsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmName : String { get set }
    var vmExtensionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var extensionParameters :  VirtualMachineExtensionProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineExtensionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineExtensions {
// CreateOrUpdate the operation to create or update the extension. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
internal class CreateOrUpdateCommand : BaseCommand, VirtualMachineExtensionsCreateOrUpdate {
    public var resourceGroupName : String
    public var vmName : String
    public var vmExtensionName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"
    public var extensionParameters :  VirtualMachineExtensionProtocol?

    public init(resourceGroupName: String, vmName: String, vmExtensionName: String, subscriptionId: String, extensionParameters: VirtualMachineExtensionProtocol) {
        self.resourceGroupName = resourceGroupName
        self.vmName = vmName
        self.vmExtensionName = vmExtensionName
        self.subscriptionId = subscriptionId
        self.extensionParameters = extensionParameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/extensions/{vmExtensionName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vmName}"] = String(describing: self.vmName)
        self.pathParameters["{vmExtensionName}"] = String(describing: self.vmExtensionName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = extensionParameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(extensionParameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VirtualMachineExtensionData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineExtensionProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: VirtualMachineExtensionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
