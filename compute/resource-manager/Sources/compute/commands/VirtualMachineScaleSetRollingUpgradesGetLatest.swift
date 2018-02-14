import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetRollingUpgradesGetLatest  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RollingUpgradeStatusInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSetRollingUpgrades {
// GetLatest gets the status of the latest virtual machine scale set rolling upgrade.
internal class GetLatestCommand : BaseCommand, VirtualMachineScaleSetRollingUpgradesGetLatest {
    public var resourceGroupName : String
    public var vmScaleSetName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"

    public init(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.vmScaleSetName = vmScaleSetName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/rollingUpgrades/latest"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RollingUpgradeStatusInfoData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RollingUpgradeStatusInfoProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RollingUpgradeStatusInfoData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
