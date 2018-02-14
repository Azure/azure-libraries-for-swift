import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetsForceRecoveryServiceFabricPlatformUpdateDomainWalk  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmScaleSetName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var platformUpdateDomain : Int32 { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (RecoveryWalkResponseProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSets {
// ForceRecoveryServiceFabricPlatformUpdateDomainWalk manual platform update domain walk to update virtual machines in
// a service fabric virtual machine scale set.
internal class ForceRecoveryServiceFabricPlatformUpdateDomainWalkCommand : BaseCommand, VirtualMachineScaleSetsForceRecoveryServiceFabricPlatformUpdateDomainWalk {
    public var resourceGroupName : String
    public var vmScaleSetName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"
    public var platformUpdateDomain : Int32

    public init(resourceGroupName: String, vmScaleSetName: String, subscriptionId: String, platformUpdateDomain: Int32) {
        self.resourceGroupName = resourceGroupName
        self.vmScaleSetName = vmScaleSetName
        self.subscriptionId = subscriptionId
        self.platformUpdateDomain = platformUpdateDomain
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{vmScaleSetName}/forceRecoveryServiceFabricPlatformUpdateDomainWalk"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{vmScaleSetName}"] = String(describing: self.vmScaleSetName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
        self.queryParameters["platformUpdateDomain"] = String(describing: self.platformUpdateDomain)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(RecoveryWalkResponseData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (RecoveryWalkResponseProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: RecoveryWalkResponseData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
