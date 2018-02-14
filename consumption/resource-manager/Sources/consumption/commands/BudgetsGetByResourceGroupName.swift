import Foundation
import azureSwiftRuntime
public protocol BudgetsGetByResourceGroupName  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var budgetName : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (BudgetProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Budgets {
// GetByResourceGroupName gets the budget for a resource group under a subscription by budget name.
internal class GetByResourceGroupNameCommand : BaseCommand, BudgetsGetByResourceGroupName {
    public var subscriptionId : String
    public var resourceGroupName : String
    public var budgetName : String
    public var apiVersion = "2018-01-31"

    public init(subscriptionId: String, resourceGroupName: String, budgetName: String) {
        self.subscriptionId = subscriptionId
        self.resourceGroupName = resourceGroupName
        self.budgetName = budgetName
        super.init()
        self.method = "Get"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Consumption/budgets/{budgetName}"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{budgetName}"] = String(describing: self.budgetName)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
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
