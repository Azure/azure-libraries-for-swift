import Foundation
import azureSwiftRuntime
public protocol JobScheduleCreate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var automationAccountName : String { get set }
    var jobScheduleId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var parameters :  JobScheduleCreateParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (JobScheduleProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.JobSchedule {
// Create create a job schedule.
    internal class CreateCommand : BaseCommand, JobScheduleCreate {
        public var resourceGroupName : String
        public var automationAccountName : String
        public var jobScheduleId : String
        public var subscriptionId : String
        public var apiVersion = "2015-10-31"
    public var parameters :  JobScheduleCreateParametersProtocol?

        public init(resourceGroupName: String, automationAccountName: String, jobScheduleId: String, subscriptionId: String, parameters: JobScheduleCreateParametersProtocol) {
            self.resourceGroupName = resourceGroupName
            self.automationAccountName = automationAccountName
            self.jobScheduleId = jobScheduleId
            self.subscriptionId = subscriptionId
            self.parameters = parameters
            super.init()
            self.method = "Put"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/jobSchedules/{jobScheduleId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{automationAccountName}"] = String(describing: self.automationAccountName)
            self.pathParameters["{jobScheduleId}"] = String(describing: self.jobScheduleId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = parameters

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(parameters as? JobScheduleCreateParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(JobScheduleData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (JobScheduleProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: JobScheduleData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
