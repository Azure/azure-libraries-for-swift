import Foundation
import azureSwiftRuntime
public protocol NetworkInterfacesListVirtualMachineScaleSetIpConfigurations  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualMachineScaleSetName : String { get set }
    var virtualmachineIndex : String { get set }
    var networkInterfaceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (NetworkInterfaceIPConfigurationListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.NetworkInterfaces {
// ListVirtualMachineScaleSetIpConfigurations get the specified network interface ip configuration in a virtual machine
// scale set.
    internal class ListVirtualMachineScaleSetIpConfigurationsCommand : BaseCommand, NetworkInterfacesListVirtualMachineScaleSetIpConfigurations {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
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
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipConfigurations"
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
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(NetworkInterfaceIPConfigurationListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (NetworkInterfaceIPConfigurationListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: NetworkInterfaceIPConfigurationListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
