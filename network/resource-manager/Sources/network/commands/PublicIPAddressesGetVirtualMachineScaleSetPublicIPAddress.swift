import Foundation
import azureSwiftRuntime
public protocol PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddress  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualMachineScaleSetName : String { get set }
    var virtualmachineIndex : String { get set }
    var networkInterfaceName : String { get set }
    var ipConfigurationName : String { get set }
    var publicIpAddressName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var expand : String? { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PublicIPAddressProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.PublicIPAddresses {
// GetVirtualMachineScaleSetPublicIPAddress get the specified public IP address in a virtual machine scale set.
internal class GetVirtualMachineScaleSetPublicIPAddressCommand : BaseCommand, PublicIPAddressesGetVirtualMachineScaleSetPublicIPAddress {
    public var resourceGroupName : String
    public var virtualMachineScaleSetName : String
    public var virtualmachineIndex : String
    public var networkInterfaceName : String
    public var ipConfigurationName : String
    public var publicIpAddressName : String
    public var subscriptionId : String
    public var apiVersion = "2017-03-30"
    public var expand : String?

    public init(resourceGroupName: String, virtualMachineScaleSetName: String, virtualmachineIndex: String, networkInterfaceName: String, ipConfigurationName: String, publicIpAddressName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.virtualMachineScaleSetName = virtualMachineScaleSetName
        self.virtualmachineIndex = virtualmachineIndex
        self.networkInterfaceName = networkInterfaceName
        self.ipConfigurationName = ipConfigurationName
        self.publicIpAddressName = publicIpAddressName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines/{virtualmachineIndex}/networkInterfaces/{networkInterfaceName}/ipconfigurations/{ipConfigurationName}/publicipaddresses/{publicIpAddressName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{virtualMachineScaleSetName}"] = String(describing: self.virtualMachineScaleSetName)
        self.pathParameters["{virtualmachineIndex}"] = String(describing: self.virtualmachineIndex)
        self.pathParameters["{networkInterfaceName}"] = String(describing: self.networkInterfaceName)
        self.pathParameters["{ipConfigurationName}"] = String(describing: self.ipConfigurationName)
        self.pathParameters["{publicIpAddressName}"] = String(describing: self.publicIpAddressName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(PublicIPAddressData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (PublicIPAddressProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: PublicIPAddressData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
