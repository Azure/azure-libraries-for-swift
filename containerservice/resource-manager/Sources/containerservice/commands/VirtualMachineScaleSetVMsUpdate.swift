import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetVMsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var instanceId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  VirtualMachineScaleSetVMProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineScaleSetVMProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSetVMs {
// Update updates a virtual machine of a VM scale set. This method may poll for completion. Polling can be canceled by
// passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
internal class UpdateCommand : BaseCommand, VirtualMachineScaleSetVMsUpdate {
    public var resourceGroupName : String
    public var vmScaleSetName : String
    public var instanceId : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"
    public var parameters :  VirtualMachineScaleSetVMProtocol?

    public init(resourceGroupName: String, vmScaleSetName: String, instanceId: String, subscriptionId: String, parameters: VirtualMachineScaleSetVMProtocol) {
        self.resourceGroupName = resourceGroupName
        self.vmScaleSetName = vmScaleSetName
        self.instanceId = instanceId
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualmachines/{instanceId}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
        self.pathParameters["{instanceId}"] = String(describing: self.instanceId)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VirtualMachineScaleSetVMData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineScaleSetVMProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: VirtualMachineScaleSetVMData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
