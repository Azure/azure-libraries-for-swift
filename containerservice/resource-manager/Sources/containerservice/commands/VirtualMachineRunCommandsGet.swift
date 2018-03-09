import Foundation
import azureSwiftRuntime
public protocol VirtualMachineRunCommandsGet  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var commandId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (RunCommandDocumentProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.VirtualMachineRunCommands {
// Get gets specific run command for a subscription in a location.
    internal class GetCommand : BaseCommand, VirtualMachineRunCommandsGet {
        public var location : String
        public var commandId : String
        public var subscriptionId : String
        public var apiVersion = "2017-12-01"

        public init(location: String, commandId: String, subscriptionId: String) {
            self.location = location
            self.commandId = commandId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Compute/locations/{location}/runCommands/{commandId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{location}"] = String(describing: self.location)
            self.pathParameters["{commandId}"] = String(describing: self.commandId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(RunCommandDocumentData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (RunCommandDocumentProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: RunCommandDocumentData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
