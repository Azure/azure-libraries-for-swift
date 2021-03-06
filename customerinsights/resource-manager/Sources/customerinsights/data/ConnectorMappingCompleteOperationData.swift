// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct ConnectorMappingCompleteOperationData : ConnectorMappingCompleteOperationProtocol {
    public var completionOperationType: CompletionOperationTypesEnum?
    public var destinationFolder: String?

        enum CodingKeys: String, CodingKey {case completionOperationType = "completionOperationType"
        case destinationFolder = "destinationFolder"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.completionOperationType) {
        self.completionOperationType = try container.decode(CompletionOperationTypesEnum?.self, forKey: .completionOperationType)
    }
    if container.contains(.destinationFolder) {
        self.destinationFolder = try container.decode(String?.self, forKey: .destinationFolder)
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
    if self.completionOperationType != nil {try container.encode(self.completionOperationType, forKey: .completionOperationType)}
    if self.destinationFolder != nil {try container.encode(self.destinationFolder, forKey: .destinationFolder)}
  }
}

extension DataFactory {
  public static func createConnectorMappingCompleteOperationProtocol() -> ConnectorMappingCompleteOperationProtocol {
    return ConnectorMappingCompleteOperationData()
  }
}
