import Foundation
import azureSwiftRuntime
public protocol ServiceGetAvailableOperations  {
    var headerParameters: [String: String] { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationListProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Service {
// GetAvailableOperations indicates which operations can be performed by the Power BI Resource Provider.
internal class GetAvailableOperationsCommand : BaseCommand, ServiceGetAvailableOperations {
    public var apiVersion = "2016-01-29"

    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.PowerBI/operations"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(OperationListData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (OperationListProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: OperationListData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
