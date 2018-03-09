import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetExtensionsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var vmssExtensionName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var extensionParameters :  VirtualMachineScaleSetExtensionProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualMachineScaleSetExtensionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSetExtensions {
// CreateOrUpdate the operation to create or update an extension. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class CreateOrUpdateCommand : BaseCommand, VirtualMachineScaleSetExtensionsCreateOrUpdate {
        public var resourceGroupName : String
        public var vmScaleSetName : String
        public var vmssExtensionName : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"
    public var extensionParameters :  VirtualMachineScaleSetExtensionProtocol?

        public init(resourceGroupName: String, vmScaleSetName: String, vmssExtensionName: String, subscriptionId: String, extensionParameters: VirtualMachineScaleSetExtensionProtocol) {
            self.resourceGroupName = resourceGroupName
            self.vmScaleSetName = vmScaleSetName
            self.vmssExtensionName = vmssExtensionName
            self.subscriptionId = subscriptionId
            self.extensionParameters = extensionParameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/extensions/{vmssExtensionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
            self.pathParameters["{vmssExtensionName}"] = String(describing: self.vmssExtensionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = extensionParameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(extensionParameters as? VirtualMachineScaleSetExtensionData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VirtualMachineScaleSetExtensionData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VirtualMachineScaleSetExtensionProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: VirtualMachineScaleSetExtensionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
