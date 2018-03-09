import Foundation
import azureSwiftRuntime
public protocol CertificatesDelete  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var resourceName : String { get set }
    var certificateName : String { get set }
    var apiVersion : String { get set }
    var ifMatch : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (Error?) -> Void) -> Void;
}

extension Commands.Certificates {
// Delete deletes an existing X509 certificate or does nothing if it does not exist.
    internal class DeleteCommand : BaseCommand, CertificatesDelete {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var resourceName : String
        public var certificateName : String
        public var apiVersion = "2017-07-01"
        public var ifMatch : String

        public init(subscriptionId: String, resourceGroupName: String, resourceName: String, certificateName: String, ifMatch: String) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.resourceName = resourceName
            self.certificateName = certificateName
            self.ifMatch = ifMatch
            super.init()
            self.method = "Delete"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/IotHubs/{resourceName}/certificates/{certificateName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{resourceName}"] = String(describing: self.resourceName)
            self.pathParameters["{certificateName}"] = String(describing: self.certificateName)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.headerParameters["If-Match"] = String(describing: self.ifMatch)

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
