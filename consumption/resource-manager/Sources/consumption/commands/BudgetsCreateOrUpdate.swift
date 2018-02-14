import Foundation
import azureSwiftRuntime
public protocol BudgetsCreateOrUpdate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var budgetName : String { get set }
    var apiVersion : String { get set }
    var parameters :  BudgetProtocol?  { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BudgetProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Budgets {
// CreateOrUpdate the operation to create or update a budget. Update operation requires latest eTag to be set in the
// request mandatorily. You may obtain the latest eTag by performing a get operation. Create operation does not require
// eTag.
internal class CreateOrUpdateCommand : BaseCommand, BudgetsCreateOrUpdate {
    public var subscriptionId : String
    public var budgetName : String
    public var apiVersion = "2018-01-31"
    public var parameters :  BudgetProtocol?

    public init(subscriptionId: String, budgetName: String, parameters: BudgetProtocol) {
        self.subscriptionId = subscriptionId
        self.budgetName = budgetName
        self.parameters = parameters
        super.init()
        self.method = "Put"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.Consumption/budgets/{budgetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{budgetName}"] = String(describing: self.budgetName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
    self.body = parameters
}

    public override func encodeBody() throws -> Data? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let encoder = try CoderFactory.encoder(for: mimeType)
            let encodedValue = try encoder.encode(parameters)
            return encodedValue
        }
        throw DecodeError.unknownMimeType
    }

    public override func returnFunc(data: Data) throws -> Decodable? {
        let contentType = "application/json"
        if let mimeType = MimeType.getType(forStr: contentType) {
            let decoder = try CoderFactory.decoder(for: mimeType)
            let result = try decoder.decode(BudgetData?.self, from: data)
            return result;
        }
        throw DecodeError.unknownMimeType
    }
    public func execute(client: RuntimeClient,
        completionHandler: @escaping (BudgetProtocol?, Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (result: BudgetData?, error: Error?) in
            completionHandler(result, error)
        }
    }
}
}
