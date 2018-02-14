import Foundation
import azureSwiftRuntime
public protocol ServiceObjectivesGet  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var serverName : String { get set }
    var serviceObjectiveName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ServiceObjectiveProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServiceObjectives {
// Get gets a database service objective.
internal class GetCommand : BaseCommand, ServiceObjectivesGet {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var serverName : String
    public var serviceObjectiveName : String
    public var apiVersion = "2014-04-01"

    public init(subscriptionId: String, resourceGroupName: String, serverName: String, serviceObjectiveName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.serverName = serverName
        self.serviceObjectiveName = serviceObjectiveName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/serviceObjectives/{serviceObjectiveName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{serverName}"] = String(describing: self.serverName)
        self.pathParameters["{serviceObjectiveName}"] = String(describing: self.serviceObjectiveName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ServiceObjectiveData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ServiceObjectiveProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ServiceObjectiveData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
