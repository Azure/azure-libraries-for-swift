import Foundation
import azureSwiftRuntime
// List lists all of the available Storage Rest API operations.
class OperationsListCommand : BaseCommand {
    var apiVersion : String? = "2017-06-01"

    override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Storage/operations"
    }

    override func preCall()  {
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }


    override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(OperationListResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> OperationListResultTypeProtocol? {
        return try client.execute(command: self) as! OperationListResultTypeProtocol?
    }
    }
