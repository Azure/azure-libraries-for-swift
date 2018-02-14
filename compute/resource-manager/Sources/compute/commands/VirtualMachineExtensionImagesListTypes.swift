import Foundation
import azureSwiftRuntime
public protocol VirtualMachineExtensionImagesListTypes  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var publisherName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping ([VirtualMachineExtensionImageProtocol?]?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineExtensionImages {
// ListTypes gets a list of virtual machine extension image types.
internal class ListTypesCommand : BaseCommand, VirtualMachineExtensionImagesListTypes {
    public var location : String
    public var publisherName : String
    public var subscriptionId : String
    public var apiVersion = "2017-12-01"

    public init(location: String, publisherName: String, subscriptionId: String) {
        self.location = location
        self.publisherName = publisherName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{location}"] = String(describing: self.location)
        self.pathParameters["{publisherName}"] = String(describing: self.publisherName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode([VirtualMachineExtensionImageData?]?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping ([VirtualMachineExtensionImageProtocol?]?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: [VirtualMachineExtensionImageData?]?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
