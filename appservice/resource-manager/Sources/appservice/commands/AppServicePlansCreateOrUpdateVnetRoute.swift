import Foundation
import azureSwiftRuntime
public protocol AppServicePlansCreateOrUpdateVnetRoute  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var name : String { get set }
    var vnetName : String { get set }
    var routeName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var route :  VnetRouteProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (VnetRouteProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AppServicePlans {
// CreateOrUpdateVnetRoute create or update a Virtual Network route in an App Service plan.
internal class CreateOrUpdateVnetRouteCommand : BaseCommand, AppServicePlansCreateOrUpdateVnetRoute {
    public var resourceGroupName : String
    public var name : String
    public var vnetName : String
    public var routeName : String
    public var subscriptionId : String
    public var apiVersion = "2016-09-01"
    public var route :  VnetRouteProtocol?

    public init(resourceGroupName: String, name: String, vnetName: String, routeName: String, subscriptionId: String, route: VnetRouteProtocol) {
        self.resourceGroupName = resourceGroupName
        self.name = name
        self.vnetName = vnetName
        self.routeName = routeName
        self.subscriptionId = subscriptionId
        self.route = route
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/serverfarms/{name}/virtualNetworkConnections/{vnetName}/routes/{routeName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{name}"] = String(describing: self.name)
        self.pathParameters["{vnetName}"] = String(describing: self.vnetName)
        self.pathParameters["{routeName}"] = String(describing: self.routeName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = route
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(route)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(VnetRouteData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (VnetRouteProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: VnetRouteData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
