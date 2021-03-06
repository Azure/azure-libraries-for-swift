import Foundation
import azureSwiftRuntime
public protocol VaultsCheckNameAvailability  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var apiVersion : String { get set }
    var vaultName :  VaultCheckNameAvailabilityParametersProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (CheckNameAvailabilityResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Vaults {
// CheckNameAvailability checks that the vault name is valid and is not already in use.
    internal class CheckNameAvailabilityCommand : BaseCommand, VaultsCheckNameAvailability {
        public var subscriptionId : String
        public var apiVersion = "2016-10-01"
    public var vaultName :  VaultCheckNameAvailabilityParametersProtocol?

        public init(subscriptionId: String, vaultName: VaultCheckNameAvailabilityParametersProtocol) {
            self.subscriptionId = subscriptionId
            self.vaultName = vaultName
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/providers/Microsoft.KeyVault/checkNameAvailability"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = vaultName

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(vaultName as? VaultCheckNameAvailabilityParametersData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(CheckNameAvailabilityResultData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (CheckNameAvailabilityResultProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: CheckNameAvailabilityResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
