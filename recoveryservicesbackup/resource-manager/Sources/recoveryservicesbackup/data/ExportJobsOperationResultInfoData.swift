// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ExportJobsOperationResultInfoData : ExportJobsOperationResultInfoProtocol, OperationResultInfoBaseProtocol {
    public var blobUrl: String?
    public var blobSasKey: String?

        enum CodingKeys: String, CodingKey {case blobUrl = "blobUrl"
        case blobSasKey = "blobSasKey"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.blobUrl) {
        self.blobUrl = try container.decode(String?.self, forKey: .blobUrl)
    }
    if container.contains(.blobSasKey) {
        self.blobSasKey = try container.decode(String?.self, forKey: .blobSasKey)
    }
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.blobUrl != nil {try container.encode(self.blobUrl, forKey: .blobUrl)}
    if self.blobSasKey != nil {try container.encode(self.blobSasKey, forKey: .blobSasKey)}
  }
}

extension DataFactory {
  public static func createExportJobsOperationResultInfoProtocol() -> ExportJobsOperationResultInfoProtocol {
    return ExportJobsOperationResultInfoData()
  }
}
