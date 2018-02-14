import Foundation
import azureSwiftRuntime
public protocol AlertRuleIncidentsGet  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var ruleName : String { get set }
    var incidentName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (IncidentProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.AlertRuleIncidents {
// Get gets an incident associated to an alert rule
internal class GetCommand : BaseCommand, AlertRuleIncidentsGet {
    public var resourceGroupName : String
    public var ruleName : String
    public var incidentName : String
    public var subscriptionId : String
    public var apiVersion = "2016-03-01"

    public init(resourceGroupName: String, ruleName: String, incidentName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.ruleName = ruleName
        self.incidentName = incidentName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/microsoft.insights/alertrules/{ruleName}/incidents/{incidentName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{ruleName}"] = String(describing: self.ruleName)
        self.pathParameters["{incidentName}"] = String(describing: self.incidentName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(IncidentData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (IncidentProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: IncidentData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
