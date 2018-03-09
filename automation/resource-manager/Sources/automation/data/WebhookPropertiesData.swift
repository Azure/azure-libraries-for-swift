// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct WebhookPropertiesData : WebhookPropertiesProtocol {
    public var isEnabled: Bool?
    public var uri: String?
    public var expiryTime: Date?
    public var lastInvokedTime: Date?
    public var parameters: [String:String]?
    public var runbook: RunbookAssociationPropertyProtocol?
    public var runOn: String?
    public var creationTime: Date?
    public var lastModifiedTime: Date?
    public var description: String?

        enum CodingKeys: String, CodingKey {case isEnabled = "isEnabled"
        case uri = "uri"
        case expiryTime = "expiryTime"
        case lastInvokedTime = "lastInvokedTime"
        case parameters = "parameters"
        case runbook = "runbook"
        case runOn = "runOn"
        case creationTime = "creationTime"
        case lastModifiedTime = "lastModifiedTime"
        case description = "description"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.isEnabled) {
        self.isEnabled = try container.decode(Bool?.self, forKey: .isEnabled)
    }
    if container.contains(.uri) {
        self.uri = try container.decode(String?.self, forKey: .uri)
    }
    if container.contains(.expiryTime) {
        self.expiryTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .expiryTime)), format: .dateTime)
    }
    if container.contains(.lastInvokedTime) {
        self.lastInvokedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastInvokedTime)), format: .dateTime)
    }
    if container.contains(.parameters) {
        self.parameters = try container.decode([String:String]?.self, forKey: .parameters)
    }
    if container.contains(.runbook) {
        self.runbook = try container.decode(RunbookAssociationPropertyData?.self, forKey: .runbook)
    }
    if container.contains(.runOn) {
        self.runOn = try container.decode(String?.self, forKey: .runOn)
    }
    if container.contains(.creationTime) {
        self.creationTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .creationTime)), format: .dateTime)
    }
    if container.contains(.lastModifiedTime) {
        self.lastModifiedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .lastModifiedTime)), format: .dateTime)
    }
    if container.contains(.description) {
        self.description = try container.decode(String?.self, forKey: .description)
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
    if self.isEnabled != nil {try container.encode(self.isEnabled, forKey: .isEnabled)}
    if self.uri != nil {try container.encode(self.uri, forKey: .uri)}
    if self.expiryTime != nil {
        try container.encode(DateConverter.toString(date: self.expiryTime!, format: .dateTime), forKey: .expiryTime)
    }
    if self.lastInvokedTime != nil {
        try container.encode(DateConverter.toString(date: self.lastInvokedTime!, format: .dateTime), forKey: .lastInvokedTime)
    }
    if self.parameters != nil {try container.encode(self.parameters, forKey: .parameters)}
    if self.runbook != nil {try container.encode(self.runbook as! RunbookAssociationPropertyData?, forKey: .runbook)}
    if self.runOn != nil {try container.encode(self.runOn, forKey: .runOn)}
    if self.creationTime != nil {
        try container.encode(DateConverter.toString(date: self.creationTime!, format: .dateTime), forKey: .creationTime)
    }
    if self.lastModifiedTime != nil {
        try container.encode(DateConverter.toString(date: self.lastModifiedTime!, format: .dateTime), forKey: .lastModifiedTime)
    }
    if self.description != nil {try container.encode(self.description, forKey: .description)}
  }
}

extension DataFactory {
  public static func createWebhookPropertiesProtocol() -> WebhookPropertiesProtocol {
    return WebhookPropertiesData()
  }
}