import Foundation
import azureSwiftRuntime
public protocol WebAppsSwapSlotWithProduction  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var slotSwapEntity :  CsmSlotEntityProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.WebApps {
// SwapSlotWithProduction swaps two deployment slots of an app. This method may poll for completion. Polling can be
// canceled by passing the cancel channel argument. The channel will be used to cancel polling and any outstanding HTTP
// requests.
    internal class SwapSlotWithProductionCommand : BaseCommand, WebAppsSwapSlotWithProduction {
        public var resourceGroupName : String
        public var name : String
        public var subscriptionId : String
        public var apiVersion = "2016-08-01"
    public var slotSwapEntity :  CsmSlotEntityProtocol?

        public init(resourceGroupName: String, name: String, subscriptionId: String, slotSwapEntity: CsmSlotEntityProtocol) {
            self.resourceGroupName = resourceGroupName
            self.name = name
            self.subscriptionId = subscriptionId
            self.slotSwapEntity = slotSwapEntity
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = true
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slotsswap"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = slotSwapEntity

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(slotSwapEntity as? CsmSlotEntityData)
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
