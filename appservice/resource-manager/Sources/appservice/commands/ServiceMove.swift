import Foundation
import azureSwiftRuntime
public protocol ServiceMove  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var moveResourceEnvelope :  CsmMoveResourceEnvelopeProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Service {
// Move move resources between resource groups.
    internal class MoveCommand : BaseCommand, ServiceMove {
        public var resourceGroupName : String
        public var subscriptionId : String
        public var apiVersion = "2016-03-01"
    public var moveResourceEnvelope :  CsmMoveResourceEnvelopeProtocol?

        public init(resourceGroupName: String, subscriptionId: String, moveResourceEnvelope: CsmMoveResourceEnvelopeProtocol) {
            self.resourceGroupName = resourceGroupName
            self.subscriptionId = subscriptionId
            self.moveResourceEnvelope = moveResourceEnvelope
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/moveResources"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = moveResourceEnvelope

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(moveResourceEnvelope as? CsmMoveResourceEnvelopeData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public func execute(client: RuntimeClient,
            completionHandler: @escaping (Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (error) in
                completionHandler(error)
            }
        }
    }
}
