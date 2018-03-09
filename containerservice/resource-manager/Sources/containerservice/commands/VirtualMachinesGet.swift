import Foundation
import azureSwiftRuntime
public protocol VirtualMachinesGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmName : String { get set }
    var subscriptionId : String { get set }
    var expand : InstanceViewTypesEnum? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualMachineProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachines {
// Get retrieves information about the model view or the instance view of a virtual machine.
    internal class GetCommand : BaseCommand, VirtualMachinesGet {
        public var resourceGroupName : String
        public var vmName : String
        public var subscriptionId : String
        public var expand : InstanceViewTypesEnum?
        public var apiVersion = "2017-12-01"

        public init(resourceGroupName: String, vmName: String, subscriptionId: String) {
            self.resourceGroupName = resourceGroupName
            self.vmName = vmName
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmName}"] = String(describing: self.vmName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            if self.expand != nil { queryParameters["$expand"] = String(describing: self.expand!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VirtualMachineData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VirtualMachineProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VirtualMachineData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
