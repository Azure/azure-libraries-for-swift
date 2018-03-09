import Foundation
import azureSwiftRuntime
public protocol ServersListOperationStatuses  {
    var headerParameters: [String: String] { get set }
    var location : String { get set }
    var operationId : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (OperationStatusProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Servers {
// ListOperationStatuses list the status of operation.
    internal class ListOperationStatusesCommand : BaseCommand, ServersListOperationStatuses {
        public var location : String
        public var operationId : String
        public var subscriptionId : String
        public var apiVersion = "2017-08-01"

        public init(location: String, operationId: String, subscriptionId: String) {
            self.location = location
            self.operationId = operationId
            self.subscriptionId = subscriptionId
            super.init()
            self.method = "Get"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/locations/{location}/operationstatuses/{operationId}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{location}"] = String(describing: self.location)
            self.pathParameters["{operationId}"] = String(describing: self.operationId)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(OperationStatusData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (OperationStatusProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: OperationStatusData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
