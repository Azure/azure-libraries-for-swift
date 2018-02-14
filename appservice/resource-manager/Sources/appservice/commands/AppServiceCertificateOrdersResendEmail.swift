import Foundation
import azureSwiftRuntime
public protocol AppServiceCertificateOrdersResendEmail  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var certificateOrderName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.AppServiceCertificateOrders {
// ResendEmail resend certificate email.
internal class ResendEmailCommand : BaseCommand, AppServiceCertificateOrdersResendEmail {
    public var resourceGroupName : String
    public var certificateOrderName : String
    public var subscriptionId : String
    public var apiVersion = "2015-08-01"

    public init(resourceGroupName: String, certificateOrderName: String, subscriptionId: String) {
        self.resourceGroupName = resourceGroupName
        self.certificateOrderName = certificateOrderName
        self.subscriptionId = subscriptionId
        super.init()
        self.method = "Post"
        self.isLongRunningOperation = false
        self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CertificateRegistration/certificateOrders/{certificateOrderName}/resendEmail"
        self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
    }

    public override func preCall()  {
        self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
        self.pathParameters["{certificateOrderName}"] = String(describing: self.certificateOrderName)
        self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
        self.queryParameters["api-version"] = String(describing: self.apiVersion)
}


    public func execute(client: RuntimeClient,
        completionHandler: @escaping (Error?) -> Void) -> Void {
        client.executeAsync(command: self) {
            (error) in
            completionHandler(error)
        }
    }
}
}
