// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct AS2EnvelopeSettingsData : AS2EnvelopeSettingsProtocol {
    public var messageContentType: String
    public var transmitFileNameInMimeHeader: Bool
    public var fileNameTemplate: String
    public var suspendMessageOnFileNameGenerationError: Bool
    public var autogenerateFileName: Bool

        enum CodingKeys: String, CodingKey {case messageContentType = "messageContentType"
        case transmitFileNameInMimeHeader = "transmitFileNameInMimeHeader"
        case fileNameTemplate = "fileNameTemplate"
        case suspendMessageOnFileNameGenerationError = "suspendMessageOnFileNameGenerationError"
        case autogenerateFileName = "autogenerateFileName"
        }

  public init(messageContentType: String, transmitFileNameInMimeHeader: Bool, fileNameTemplate: String, suspendMessageOnFileNameGenerationError: Bool, autogenerateFileName: Bool)  {
    self.messageContentType = messageContentType
    self.transmitFileNameInMimeHeader = transmitFileNameInMimeHeader
    self.fileNameTemplate = fileNameTemplate
    self.suspendMessageOnFileNameGenerationError = suspendMessageOnFileNameGenerationError
    self.autogenerateFileName = autogenerateFileName
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.messageContentType = try container.decode(String.self, forKey: .messageContentType)
    self.transmitFileNameInMimeHeader = try container.decode(Bool.self, forKey: .transmitFileNameInMimeHeader)
    self.fileNameTemplate = try container.decode(String.self, forKey: .fileNameTemplate)
    self.suspendMessageOnFileNameGenerationError = try container.decode(Bool.self, forKey: .suspendMessageOnFileNameGenerationError)
    self.autogenerateFileName = try container.decode(Bool.self, forKey: .autogenerateFileName)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.messageContentType, forKey: .messageContentType)
    try container.encode(self.transmitFileNameInMimeHeader, forKey: .transmitFileNameInMimeHeader)
    try container.encode(self.fileNameTemplate, forKey: .fileNameTemplate)
    try container.encode(self.suspendMessageOnFileNameGenerationError, forKey: .suspendMessageOnFileNameGenerationError)
    try container.encode(self.autogenerateFileName, forKey: .autogenerateFileName)
  }
}

extension DataFactory {
  public static func createAS2EnvelopeSettingsProtocol(messageContentType: String, transmitFileNameInMimeHeader: Bool, fileNameTemplate: String, suspendMessageOnFileNameGenerationError: Bool, autogenerateFileName: Bool) -> AS2EnvelopeSettingsProtocol {
    return AS2EnvelopeSettingsData(messageContentType: messageContentType, transmitFileNameInMimeHeader: transmitFileNameInMimeHeader, fileNameTemplate: fileNameTemplate, suspendMessageOnFileNameGenerationError: suspendMessageOnFileNameGenerationError, autogenerateFileName: autogenerateFileName)
  }
}
