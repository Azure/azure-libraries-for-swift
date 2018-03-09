import Foundation
import azureSwiftRuntime
public protocol JobsListOutputFiles  {
    var nextLink: String? { get }
    var hasAdditionalPages : Bool { get }
    var headerParameters: [String: String] { get set }
    var resourceGroupName : String { get set }
    var jobName : String { get set }
    var subscriptionId : String { get set }
    var outputdirectoryid : String { get set }
    var linkexpiryinminutes : Int32? { get set }
    var maxResults : Int32? { get set }
    var apiVersion : String { get set }
    func execute(client: RuntimeClient,
    completionHandler: @escaping (FileListResultProtocol?, Error?) -> Void) -> Void ;
}

extension Commands.Jobs {
// ListOutputFiles list all files inside the given output directory (Only if the output directory is on Azure File
// Share or Azure Storage container).
    internal class ListOutputFilesCommand : BaseCommand, JobsListOutputFiles {
        var nextLink: String?
        public var hasAdditionalPages : Bool {
        get {
            return nextLink != nil
        }
    }
        public var resourceGroupName : String
        public var jobName : String
        public var subscriptionId : String
        public var outputdirectoryid : String
        public var linkexpiryinminutes : Int32?
        public var maxResults : Int32?
        public var apiVersion = "2017-09-01-preview"

        public init(resourceGroupName: String, jobName: String, subscriptionId: String, outputdirectoryid: String) {
            self.resourceGroupName = resourceGroupName
            self.jobName = jobName
            self.subscriptionId = subscriptionId
            self.outputdirectoryid = outputdirectoryid
            super.init()
            self.method = "Post"
            self.isLongRunningOperation = false
            self.path = "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.BatchAI/jobs/{jobName}/listOutputFiles"
            self.headerParameters = ["Content-Type":"application/json; charset=utf-8"]
        }

        public override func preCall()  {
            self.pathParameters["{resourceGroupName}"] = String(describing: self.resourceGroupName)
            self.pathParameters["{jobName}"] = String(describing: self.jobName)
            self.pathParameters["{subscriptionId}"] = String(describing: self.subscriptionId)
            self.queryParameters["outputdirectoryid"] = String(describing: self.outputdirectoryid)
            if self.linkexpiryinminutes != nil { queryParameters["linkexpiryinminutes"] = String(describing: self.linkexpiryinminutes!) }
            if self.maxResults != nil { queryParameters["maxresults"] = String(describing: self.maxResults!) }
            self.queryParameters["api-version"] = String(describing: self.apiVersion)

        }

        public override func returnFunc(data: Data) throws -> Decodable? {
            let contentType = "application/json"
            if let mimeType = MimeType.getType(forStr: contentType) {
                let decoder = try CoderFactory.decoder(for: mimeType)
                if var pageDecoder = decoder as? PageDecoder {
                    pageDecoder.isPagedData = true
                    pageDecoder.nextLinkName = "NextLink"
                }
                let result = try decoder.decode(FileListResultData?.self, from: data)
                if var pageDecoder = decoder as? PageDecoder {
                    self.nextLink = pageDecoder.nextLink
                }
                return result;
            }
            throw DecodeError.unknownMimeType
        }
        public func execute(client: RuntimeClient,
            completionHandler: @escaping (FileListResultProtocol?, Error?) -> Void) -> Void {
            if self.nextLink != nil {
                self.path = nextLink!
                self.nextLink = nil;
                self.pathType = .absolute
            }
            client.executeAsync(command: self) {
                (result: FileListResultData?, error: Error?) in
                completionHandler(result, error)
            }
        }
    }
}
