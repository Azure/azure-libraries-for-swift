import Foundation
import azureSwiftRuntime
public protocol VirtualMachineScaleSetVMsList  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var virtualMachineScaleSetName : String { get set }
    var subscriptionId : String { get set }
    var filter : String? { get set }
    var select : String? { get set }
    var expand : String? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineScaleSetVMListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineScaleSetVMs {
// List gets a list of all virtual machines in a VM scale sets.
internal class ListCommand : BaseCommand, VirtualMachineScaleSetVMsList {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
    public var resourceGroupName : String
    public var virtualMachineScaleSetName : String
    public var subscriptionId : String
    public var filter : String?
    public var select : String?
    public var expand : String?
    public var apiVersion = "2017-12-01"

    public init(resourceGroupName: String, virtualMachineScaleSetName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.virtualMachineScaleSetName = virtualMachineScaleSetName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachineScaleSets/{virtualMachineScaleSetName}/virtualMachines"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{virtualMachineScaleSetName}"] = String(describing: self.virtualMachineScaleSetName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        if self.filter != nil { queryParameters["$filter"] = String(describing: self.filter!) }
        if self.select != nil { queryParameters["$select"] = String(describing: self.select!) }
        if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(VirtualMachineScaleSetVMListResultData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VirtualMachineScaleSetVMListResultProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: VirtualMachineScaleSetVMListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
