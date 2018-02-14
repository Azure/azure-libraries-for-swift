import Foundation
import azureSwiftRuntime
public protocol ProfilesGetEnrichingKpis  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var hubName : String { get set }
    var profileName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping ([KpiDefinitionProtocol?]?, Error?) -> Void) -> Void ;
}

extension Commands.Profiles {
// GetEnrichingKpis gets the KPIs that enrich the profile Type identified by the supplied name. Enrichment happens
// through participants of the Interaction on an Interaction KPI and through Relationships for Profile KPIs.
internal class GetEnrichingKpisCommand : BaseCommand, ProfilesGetEnrichingKpis {
    public var resourceGroupName : String
    public var hubName : String
    public var profileName : String
    public var subscriptionId : String
    public var apiVersion = "2017-04-26"

    public init(resourceGroupName: String, hubName: String, profileName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.hubName = hubName
        self.profileName = profileName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CustomerInsights/hubs/{hubName}/profiles/{profileName}/getEnrichingKpis"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{hubName}"] = String(describing: self.hubName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode([KpiDefinitionData?]?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping ([KpiDefinitionProtocol?]?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: [KpiDefinitionData?]?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
