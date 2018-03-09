import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetVMsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var instanceId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualMachineScaleSetVMProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSetVMs {
// Get gets a virtual machine from a VM scale set.
    internal class GetCommand : BaseCommand, VirtualMachineScaleSetVMsGet {
        public var resourceGroupName : String
        public var vmScaleSetName : String
        public var instanceId : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"

        public init(resourceGroupName: String, vmScaleSetName: String, instanceId: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.vmScaleSetName = vmScaleSetName
            self.instanceId = instanceId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/virtualmachines/{instanceId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
            self.pathParameters["{instanceId}"] = String(describing: self.instanceId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
            client.executeAsync(command: self) {
                (result: VirtualMachineScaleSetVMData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
