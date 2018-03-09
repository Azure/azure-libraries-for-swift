import Foundation
import azureSwiftRuntime
public protocol NetworkInterfacesGetVirtualMachineScaleSetNetworkInterface  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualMachineScaleSetName : String { get set }
    var virtualmachineIndex : String { get set }
    var networkInterfaceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NetworkInterfaceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkInterfaces {
// GetVirtualMachineScaleSetNetworkInterface get the specified network interface in a virtual machine scale set.
    internal class GetVirtualMachineScaleSetNetworkInterfaceCommand : BaseCommand, NetworkInterfacesGetVirtualMachineScaleSetNetworkInterface {
        public var resourceGroupName : String
        public var virtualMachineScaleSetName : String
        public var virtualmachineIndex : String
        public var networkInterfaceName : String
        public var subscriptionId : String
        public var apiVersion = "2017-03-30"
        public var expand : String?

        public init(resourceGroupName: String, virtualMachineScaleSetName: String, virtualmachineIndex: String, networkInterfaceName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.virtualMachineScaleSetName = virtualMachineScaleSetName
            self.virtualmachineIndex = virtualmachineIndex
            self.networkInterfaceName = networkInterfaceName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{virtualMachineScaleSetName}"] = String(describing: self.virtualMachineScaleSetName)
            self.pathParameters["{virtualmachineIndex}"] = String(describing: self.virtualmachineIndex)
            self.pathParameters["{networkInterfaceName}"] = String(describing: self.networkInterfaceName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(NetworkInterfaceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NetworkInterfaceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: NetworkInterfaceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
