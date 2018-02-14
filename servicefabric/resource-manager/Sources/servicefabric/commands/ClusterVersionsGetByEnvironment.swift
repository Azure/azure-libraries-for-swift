import Foundation
import azureSwiftRuntime
public protocol ClusterVersionsGetByEnvironment  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var environment : GetByEnvironmentEnvironmentEnum { get set }
    var subscriptionId : String { get set }
    var clusterVersion : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (ClusterCodeVersionsListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ClusterVersions {
// GetByEnvironment get cluster code versions by environment
internal class GetByEnvironmentCommand : BaseCommand, ClusterVersionsGetByEnvironment {
    public var location : String
    public var environment : GetByEnvironmentEnvironmentEnum
    public var subscriptionId : String
    public var clusterVersion : String
    public var apiVersion = "2017-07-01-preview"

    public init(location: String, environment: GetByEnvironmentEnvironmentEnum, subscriptionId: String, clusterVersion: String) {
        self.location = location
        self.environment = environment
        self.subscriptionId = subscriptionId
        self.clusterVersion = clusterVersion
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.ServiceFabric/locations/{location}/environments/{environment}/clusterVersions/{clusterVersion}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{location}"] = String(describing: self.location)
        self.pathParameters["{environment}"] = String(describing: self.environment)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{clusterVersion}"] = String(describing: self.clusterVersion)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(ClusterCodeVersionsListResultData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (ClusterCodeVersionsListResultProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: ClusterCodeVersionsListResultData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
