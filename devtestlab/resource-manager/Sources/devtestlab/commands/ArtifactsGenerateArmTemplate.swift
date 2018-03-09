import Foundation
import azureSwiftRuntime
public protocol ArtifactsGenerateArmTemplate  {
    var headerParameters: [String: String] { get set }
    var subscriptionId : String { get set }
    var resourceGroupName : String { get set }
    var labName : String { get set }
    var artifactSourceName : String { get set }
    var name : String { get set }
    var apiVersion : String { get set }
    var generateArmTemplateRequest :  GenerateArmTemplateRequestProtocol?  { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (ArmTemplateInfoProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Artifacts {
// GenerateArmTemplate generates an ARM template for the given artifact, uploads the required files to a storage
// account, and validates the generated artifact.
    internal class GenerateArmTemplateCommand : BaseCommand, ArtifactsGenerateArmTemplate {
        public var subscriptionId : String
        public var resourceGroupName : String
        public var labName : String
        public var artifactSourceName : String
        public var name : String
        public var apiVersion = "2016-05-15"
    public var generateArmTemplateRequest :  GenerateArmTemplateRequestProtocol?

        public init(subscriptionId: String, resourceGroupName: String, labName: String, artifactSourceName: String, name: String, generateArmTemplateRequest: GenerateArmTemplateRequestProtocol) {
            self.subscriptionId = subscriptionId
            self.resourceGroupName = resourceGroupName
            self.labName = labName
            self.artifactSourceName = artifactSourceName
            self.name = name
            self.generateArmTemplateRequest = generateArmTemplateRequest
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DevTestLab/labs/{labName}/artifactsources/{artifactSourceName}/artifacts/{name}/generateArmTemplate"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{labName}"] = String(describing: self.labName)
            self.pathParameters["{artifactSourceName}"] = String(describing: self.artifactSourceName)
            self.pathParameters["{name}"] = String(describing: self.name)
            self.queryParameters["api-version"] = String(describing: self.apiVersion)
            self.body = generateArmTemplateRequest

        }
        public override func encodeBody() throws -> Data? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let encoder = try CoderFactory.encoder(for: mimeType)
                let encodedValue = try encoder.encode(generateArmTemplateRequest as? GenerateArmTemplateRequestData)
                return encodedValue
            }
            throw DecodeError.unknownMimeType
        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                let result = try decoder.decode(ArmTemplateInfoData?.self, from: data)
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (ArmTemplateInfoProtocol?, Error?) -> Void) -> Void {
            client.executeAsync(command: self) {
                (result: ArmTemplateInfoData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
