// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct IntegrationAccountSchemaPropertiesData : IntegrationAccountSchemaPropertiesProtocol {
    public var schemaType: SchemaTypeEnum
    public var targetNamespace: String?
    public var documentName: String?
    public var fileName: String?
    public var createdTime: Date?
    public var changedTime: Date?
    public var metadata: [String: String?]?
    public var content: String?
    public var contentType: String?
    public var contentLink: ContentLinkProtocol?

        enum CodingKeys: String, CodingKey {case schemaType = "schemaType"
        case targetNamespace = "targetNamespace"
        case documentName = "documentName"
        case fileName = "fileName"
        case createdTime = "createdTime"
        case changedTime = "changedTime"
        case metadata = "metadata"
        case content = "content"
        case contentType = "contentType"
        case contentLink = "contentLink"
        }

  public init(schemaType: SchemaTypeEnum)  {
    self.schemaType = schemaType
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.schemaType = try container.decode(SchemaTypeEnum.self, forKey: .schemaType)
    if container.contains(.targetNamespace) {
        self.targetNamespace = try container.decode(String?.self, forKey: .targetNamespace)
    }
    if container.contains(.documentName) {
        self.documentName = try container.decode(String?.self, forKey: .documentName)
    }
    if container.contains(.fileName) {
        self.fileName = try container.decode(String?.self, forKey: .fileName)
    }
    if container.contains(.createdTime) {
        self.createdTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .createdTime)), format: .dateTime)
    }
    if container.contains(.changedTime) {
        self.changedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .changedTime)), format: .dateTime)
    }
    if container.contains(.metadata) {
        self.metadata = try container.decode([String: String?]?.self, forKey: .metadata)
    }
    if container.contains(.content) {
        self.content = try container.decode(String?.self, forKey: .content)
    }
    if container.contains(.contentType) {
        self.contentType = try container.decode(String?.self, forKey: .contentType)
    }
    if container.contains(.contentLink) {
        self.contentLink = try container.decode(ContentLinkData?.self, forKey: .contentLink)
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
    try container.encode(self.schemaType, forKey: .schemaType)
    if self.targetNamespace != nil {try container.encode(self.targetNamespace, forKey: .targetNamespace)}
    if self.documentName != nil {try container.encode(self.documentName, forKey: .documentName)}
    if self.fileName != nil {try container.encode(self.fileName, forKey: .fileName)}
    if self.createdTime != nil {
        try container.encode(DateConverter.toString(date: self.createdTime!, format: .dateTime), forKey: .createdTime)
    }
    if self.changedTime != nil {
        try container.encode(DateConverter.toString(date: self.changedTime!, format: .dateTime), forKey: .changedTime)
    }
    if self.metadata != nil {try container.encode(self.metadata, forKey: .metadata)}
    if self.content != nil {try container.encode(self.content, forKey: .content)}
    if self.contentType != nil {try container.encode(self.contentType, forKey: .contentType)}
    if self.contentLink != nil {try container.encode(self.contentLink as! ContentLinkData?, forKey: .contentLink)}
  }
}

extension DataFactory {
  public static func createIntegrationAccountSchemaPropertiesProtocol(schemaType: SchemaTypeEnum) -> IntegrationAccountSchemaPropertiesProtocol {
    return IntegrationAccountSchemaPropertiesData(schemaType: schemaType)
  }
}
