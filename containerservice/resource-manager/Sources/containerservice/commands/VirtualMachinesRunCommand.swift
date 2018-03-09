import Foundation
import azureSwiftRuntime
public protocol VirtualMachinesRunCommand  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var vmName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  RunCommandInputProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RunCommandResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachines {
// RunCommand run command on the VM. This method may poll for completion. Polling can be canceled by passing the cancel
// channel argument. The channel will be used to cancel polling and any outstanding HTTP requests.
    internal class RunCommandCommand : BaseCommand, VirtualMachinesRunCommand {
        public var resourceGroupName : String
        public var vmName : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"
    public var parameters :  RunCommandInputProtocol?

        public init(resourceGroupName: String, vmName: String, subscriptionId: String, parameters: RunCommandInputProtocol) {
            self.resourceGroupName = resourceGroupName
            self.vmName = vmName
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/virtualMachines/{vmName}/runCommand"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{vmName}"] = String(describing: self.vmName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? RunCommandInputData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RunCommandResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RunCommandResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsyncLRO(command: self) {
                (result: RunCommandResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
