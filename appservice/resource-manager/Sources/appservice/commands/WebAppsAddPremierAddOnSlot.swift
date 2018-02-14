import Foundation
import azureSwiftRuntime
public protocol WebAppsAddPremierAddOnSlot  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var premierAddOnName : String { get set }
    var slot : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var premierAddOn :  PremierAddOnProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (PremierAddOnProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.WebApps {
// AddPremierAddOnSlot updates a named add-on of an app.
internal class AddPremierAddOnSlotCommand : BaseCommand, WebAppsAddPremierAddOnSlot {
    public var resourceGroupName : String
    public var name : String
    public var premierAddOnName : String
    public var slot : String
    public var subscriptionId : String
    public var apiVersion = "2016-08-01"
    public var premierAddOn :  PremierAddOnProtocol?

    public init(resourceGroupName: String, name: String, premierAddOnName: String, slot: String, subscriptionId: String, premierAddOn: PremierAddOnProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.premierAddOnName = premierAddOnName
        self.slot = slot
        self.subscriptionId = subscriptionId
        self.premierAddOn = premierAddOn
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/slots/{slot}/premieraddons/{premierAddOnName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{premierAddOnName}"] = String(describing: self.premierAddOnName)
        self.pathParameters["{slot}"] = String(describing: self.slot)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = premierAddOn
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(premierAddOn)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(PremierAddOnData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (PremierAddOnProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: PremierAddOnData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
