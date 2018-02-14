import Foundation
import azureSwiftRuntime
public protocol WebAppsListSlotDifferencesFromProduction  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var slotSwapEntity :  CsmSlotEntityProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (SlotDifferenceCollectionProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// ListSlotDifferencesFromProduction get the difference in configuration settings between two web app slots.
internal class ListSlotDifferencesFromProductionCommand : BaseCommand, WebAppsListSlotDifferencesFromProduction {
    var nextLink: String?
    public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
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
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slotsdiffs"
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
            let encodedValue = try encoder.encode(slotSwapEntity)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            if var pageDecoder = decoder as? PageDecoder {
                pageDecoder.isPagedData = true
                pageDecoder.nextLinkName = "NextLink"
            }
            let result = try decoder.decode(SlotDifferenceCollectionData?.self, from: data)
            if var pageDecoder = decoder as? PageDecoder {
                self.nextLink = pageDecoder.nextLink
            }
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (SlotDifferenceCollectionProtocol?, Error?) -> Void) -> Void {
        if self.nextLink != nil {
            self.path = nextLink!
            self.nextLink = nil;
            self.pathType = .absolute
        }
        client.executeAsync(command: self) {
            (result: SlotDifferenceCollectionData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
