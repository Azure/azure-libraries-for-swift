// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct DeleteOperationResultData : DeleteOperationResultProtocol {
    public var operationResult: Bool?

        enum CodingKeys: String, CodingKey {case operationResult = "boolean"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.operationResult) {
        self.operationResult = try container.decode(Bool?.self, forKey: .operationResult)
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
    if self.operationResult != nil {try container.encode(self.operationResult, forKey: .operationResult)}
  }
}

extension DataFactory {
  public static func createDeleteOperationResultProtocol() -> DeleteOperationResultProtocol {
    return DeleteOperationResultData()
  }
}
