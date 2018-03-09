import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetsUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  VirtualMachineScaleSetUpdateProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualMachineScaleSetProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSets {
// Update update a VM scale set. This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class UpdateCommand : BaseCommand, VirtualMachineScaleSetsUpdate {
        public var resourceGroupName : String
        public var vmScaleSetName : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"
    public var parameters :  VirtualMachineScaleSetUpdateProtocol?

        public init(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String, parameters: VirtualMachineScaleSetUpdateProtocol) {
            self.resourceGroupName = resourceGroupName
            self.vmScaleSetName = vmScaleSetName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? VirtualMachineScaleSetUpdateData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VirtualMachineScaleSetData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VirtualMachineScaleSetProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: VirtualMachineScaleSetData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
