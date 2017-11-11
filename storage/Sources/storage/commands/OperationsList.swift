import Foundation
import azureSwiftRuntime
// List lists all of the available Storage Rest API operations.
public class OperationsListCommand : BaseCommand {
    public var apiVersion : String? = "2017-06-01"

    public init(test:String) {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Storage/operations"
    }
    public override init() {
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/providers/Microsoft.Storage/operations"
    }

    public override func preCall()  {
        if self.apiVersion != nil { queryParameters["api-version"] = String(describing: self.apiVersion!) }
    }


    public override func returnFunc(decoder: ResponseDecoder, jsonString: String) throws -> Decodable? {
        return try decoder.decode(OperationListResultType?.self, from: jsonString)
    }
    public func execute(client: RuntimeClient) throws -> OperationListResultTypeProtocol? {
        return try client.execute(command: self) as! OperationListResultTypeProtocol?
    }
    }
