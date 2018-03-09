import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetsUpdateInstances  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var vmInstanceIDs :  VirtualMachineScaleSetVMInstanceRequiredIDsProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (OperationStatusResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSets {
// UpdateInstances upgrades one or more virtual machines to the latest SKU set in the VM scale set model. This method
// may poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
    internal class UpdateInstancesCommand : BaseCommand, VirtualMachineScaleSetsUpdateInstances {
        public var resourceGroupName : String
        public var vmScaleSetName : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"
    public var vmInstanceIDs :  VirtualMachineScaleSetVMInstanceRequiredIDsProtocol?

        public init(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String, vmInstanceIDs: VirtualMachineScaleSetVMInstanceRequiredIDsProtocol) {
            self.resourceGroupName = resourceGroupName
            self.vmScaleSetName = vmScaleSetName
            self.subscriptionId = subscriptionId
            self.vmInstanceIDs = vmInstanceIDs
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/manualupgrade"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = vmInstanceIDs

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(vmInstanceIDs as? VirtualMachineScaleSetVMInstanceRequiredIDsData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
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
