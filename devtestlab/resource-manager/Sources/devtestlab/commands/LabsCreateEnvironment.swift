import Foundation
import azureSwiftRuntime
public protocol LabsCreateEnvironment  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var labVirtualMachineCreationParameter :  LabVirtualMachineCreationParameterProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Labs {
// CreateEnvironment create virtual machines in a lab. This operation can take a while to complete. This method may
// poll for completion. Polling can be canceled by passing the cancel channel argument. The channel will be used to
// cancel polling and any outstanding HTTP requests.
internal class CreateEnvironmentCommand : BaseCommand, LabsCreateEnvironment {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var name : String
    public var apiVersion = "2016-05-15"
    public var labVirtualMachineCreationParameter :  LabVirtualMachineCreationParameterProtocol?

    public init(subscriptionId: String, resourceGroupName: String, name: String, labVirtualMachineCreationParameter: LabVirtualMachineCreationParameterProtocol) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.labVirtualMachineCreationParameter = labVirtualMachineCreationParameter
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = true
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{name}/createEnvironment"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = labVirtualMachineCreationParameter
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(labVirtualMachineCreationParameter)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsyncLRO(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
