import Foundation
import azureSwiftRuntime
public protocol VirtualMachinesCapture  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  VirtualMachineCaptureParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineCaptureResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachines {
// Capture captures the VM by copying virtual hard disks of the VM and outputs a template that can be used to create
// similar VMs. This method may poll for completion. Polling can be canceled by passing the cancel channel argument.
// The channel will be used to cancel polling and any outstanding HTTP requests.
internal class CaptureCommand : BaseCommand, VirtualMachinesCapture {
    public var resourceGroupName : String
    public var vmName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"
    public var parameters :  VirtualMachineCaptureParametersProtocol?

    public init(resourceGroupName: String, vmName: String, subscriptionId: String, parameters: VirtualMachineCaptureParametersProtocol) {
        self.resourceGroupName = resourceGroupName
        self.vmName = vmName
        self.subscriptionId = subscriptionId
        self.parameters = parameters
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/capture"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vmName}"] = String(describing: self.vmName)
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
            let result = try decoder.decode(VirtualMachineCaptureResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineCaptureResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (result: VirtualMachineCaptureResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
