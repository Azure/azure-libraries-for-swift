import Foundation
import azureSwiftRuntime
public protocol HeatMapGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var profileName : String { get set }
    var heatMapType : String { get set }
    var topLeft : [Double]? { get set }
    var botRight : [Double]? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (HeatMapModelProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.HeatMap {
// Get gets latest heatmap for Traffic Manager profile.
internal class GetCommand : BaseCommand, HeatMapGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var profileName : String
    public var heatMapType : String
    public var topLeft : [Double]?
    public var botRight : [Double]?
    public var apiVersion = "2017-09-01-preview"

    public init(subscriptionId: String, resourceGroupName: String, profileName: String, heatMapType: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.profileName = profileName
        self.heatMapType = heatMapType
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/trafficmanagerprofiles/{profileName}/heatMaps/{heatMapType}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{profileName}"] = String(describing: self.profileName)
        self.pathParameters["{heatMapType}"] = String(describing: self.heatMapType)
        if self.topLeft != nil { queryParameters["topLeft"] = String(describing: self.topLeft!) }
        if self.botRight != nil { queryParameters["botRight"] = String(describing: self.botRight!) }
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(HeatMapModelData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (HeatMapModelProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: HeatMapModelData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
