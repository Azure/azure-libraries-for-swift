import Foundation
import azureSwiftRuntime
public protocol ServicesUpdate  {
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var searchServiceName : String { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var clientRequestId : String? { get set }
    var service :  SearchServiceProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (SearchServiceProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Services {
// Update updates an existing Search service in the given resource group.
    internal class UpdateCommand : BaseCommand, ServicesUpdate {
        public var resourceGroupName : String
        public var searchServiceName : String
        public var subscriptionId : String
        public var apiVersion = "2015-08-19"
        public var clientRequestId : String?
    public var service :  SearchServiceProtocol?

        public init(resourceGroupName: String, searchServiceName: String, subscriptionId: String, service: SearchServiceProtocol) {
            self.resourceGroupName = resourceGroupName
            self.searchServiceName = searchServiceName
            self.subscriptionId = subscriptionId
            self.service = service
            super.init()
            self.method = "Patch"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{searchServiceName}"] = String(describing: self.searchServiceName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            if self.clientRequestId != nil { headerParameters["x-ms-client-request-id"] = String(describing: self.clientRequestId!) }
            self.body = service

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(service as? SearchServiceData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(SearchServiceData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (SearchServiceProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: SearchServiceData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
