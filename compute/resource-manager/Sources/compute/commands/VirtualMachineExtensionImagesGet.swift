import Foundation
import azureSwiftRuntime
public protocol VirtualMachineExtensionImagesGet  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var publisherName : String { get set }
    var type : String { get set }
    var version : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (VirtualMachineExtensionImageProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineExtensionImages {
// Get gets a virtual machine extension image.
    internal class GetCommand : BaseCommand, VirtualMachineExtensionImagesGet {
        public var location : String
        public var publisherName : String
        public var type : String
        public var version : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"

        public init(location: String, publisherName: String, type: String, version: String, subscriptionId: String) {
            self.location = location
            self.publisherName = publisherName
            self.type = type
            self.version = version
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/publishers/{publisherName}/artifacttypes/vmextension/types/{type}/versions/{version}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{location}"] = String(describing: self.location)
            self.pathParameters["{publisherName}"] = String(describing: self.publisherName)
            self.pathParameters["{type}"] = String(describing: self.type)
            self.pathParameters["{version}"] = String(describing: self.version)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(VirtualMachineExtensionImageData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (VirtualMachineExtensionImageProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: VirtualMachineExtensionImageData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
