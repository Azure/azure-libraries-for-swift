import Foundation
import azureSwiftRuntime
public protocol VirtualMachineExtensionsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmName : String { get set }
    var vmExtensionName : String { get set }
    var subscriptionId : String { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualMachineExtensionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineExtensions {
// Get the operation to get the extension.
    internal class GetCommand : BaseCommand, VirtualMachineExtensionsGet {
        public var resourceGroupName : String
        public var vmName : String
        public var vmExtensionName : String
        public var subscriptionId : String
        public var expand : String?
        public var apiVersion = "2017-12-01"

        public init(resourceGroupName: String, vmName: String, vmExtensionName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.vmName = vmName
            self.vmExtensionName = vmExtensionName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/extensions/{vmExtensionName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmName}"] = String(describing: self.vmName)
            self.pathParameters["{vmExtensionName}"] = String(describing: self.vmExtensionName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

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
            client.executeAsync(command: self) {
                (result: VirtualMachineExtensionData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
