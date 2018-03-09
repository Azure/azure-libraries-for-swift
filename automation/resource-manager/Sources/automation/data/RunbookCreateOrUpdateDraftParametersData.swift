// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct RunbookCreateOrUpdateDraftParametersData : RunbookCreateOrUpdateDraftParametersProtocol {
    public var runbookContent: String

        enum CodingKeys: String, CodingKey {case runbookContent = "runbookContent"
        }

  public init(runbookContent: String)  {
    self.runbookContent = runbookContent
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.runbookContent = try container.decode(String.self, forKey: .runbookContent)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.runbookContent, forKey: .runbookContent)
  }
}

extension DataFactory {
  public static func createRunbookCreateOrUpdateDraftParametersProtocol(runbookContent: String) -> RunbookCreateOrUpdateDraftParametersProtocol {
    return RunbookCreateOrUpdateDraftParametersData(runbookContent: runbookContent)
  }
}