import Foundation
import azureSwiftRuntime
public protocol ServiceRunnersCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var serviceRunner :  ServiceRunnerProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ServiceRunnerProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.ServiceRunners {
// CreateOrUpdate create or replace an existing Service runner.
    internal class CreateOrUpdateCommand : BaseCommand, ServiceRunnersCreateOrUpdate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var serviceRunner :  ServiceRunnerProtocol?

        public init(subscriptionId: String, resourceGroupName: String, labName: String, name: String, serviceRunner: ServiceRunnerProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.name = name
            self.serviceRunner = serviceRunner
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/servicerunners/{name}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = serviceRunner

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(serviceRunner as? ServiceRunnerData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ServiceRunnerData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ServiceRunnerProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ServiceRunnerData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
