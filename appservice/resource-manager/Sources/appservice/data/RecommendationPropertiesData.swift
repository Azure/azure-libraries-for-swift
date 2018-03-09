// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct RecommendationPropertiesData : RecommendationPropertiesProtocol {
    public var creationTime: Date?
    public var recommendationId: String?
    public var resourceId: String?
    public var resourceScope: ResourceScopeTypeEnum?
    public var ruleName: String?
    public var displayName: String?
    public var message: String?
    public var level: NotificationLevelEnum?
    public var channels: ChannelsEnum?
    public var tags: [String]?
    public var actionName: String?
    public var startTime: Date?
    public var endTime: Date?
    public var nextNotificationTime: Date?
    public var notificationExpirationTime: Date?
    public var notifiedTime: Date?
    public var score: Double?
    public var isDynamic: Bool?
    public var extensionName: String?
    public var bladeName: String?
    public var forwardLink: String?

        enum CodingKeys: String, CodingKey {case creationTime = "creationTime"
        case recommendationId = "recommendationId"
        case resourceId = "resourceId"
        case resourceScope = "resourceScope"
        case ruleName = "ruleName"
        case displayName = "displayName"
        case message = "message"
        case level = "level"
        case channels = "channels"
        case tags = "tags"
        case actionName = "actionName"
        case startTime = "startTime"
        case endTime = "endTime"
        case nextNotificationTime = "nextNotificationTime"
        case notificationExpirationTime = "notificationExpirationTime"
        case notifiedTime = "notifiedTime"
        case score = "score"
        case isDynamic = "isDynamic"
        case extensionName = "extensionName"
        case bladeName = "bladeName"
        case forwardLink = "forwardLink"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.creationTime) {
        self.creationTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .creationTime)), format: .dateTime)
    }
    if container.contains(.recommendationId) {
        self.recommendationId = try container.decode(String?.self, forKey: .recommendationId)
    }
    if container.contains(.resourceId) {
        self.resourceId = try container.decode(String?.self, forKey: .resourceId)
    }
    if container.contains(.resourceScope) {
        self.resourceScope = try container.decode(ResourceScopeTypeEnum?.self, forKey: .resourceScope)
    }
    if container.contains(.ruleName) {
        self.ruleName = try container.decode(String?.self, forKey: .ruleName)
    }
    if container.contains(.displayName) {
        self.displayName = try container.decode(String?.self, forKey: .displayName)
    }
    if container.contains(.message) {
        self.message = try container.decode(String?.self, forKey: .message)
    }
    if container.contains(.level) {
        self.level = try container.decode(NotificationLevelEnum?.self, forKey: .level)
    }
    if container.contains(.channels) {
        self.channels = try container.decode(ChannelsEnum?.self, forKey: .channels)
    }
    if container.contains(.tags) {
        self.tags = try container.decode([String]?.self, forKey: .tags)
    }
    if container.contains(.actionName) {
        self.actionName = try container.decode(String?.self, forKey: .actionName)
    }
    if container.contains(.startTime) {
        self.startTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .startTime)), format: .dateTime)
    }
    if container.contains(.endTime) {
        self.endTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .endTime)), format: .dateTime)
    }
    if container.contains(.nextNotificationTime) {
        self.nextNotificationTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .nextNotificationTime)), format: .dateTime)
    }
    if container.contains(.notificationExpirationTime) {
        self.notificationExpirationTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .notificationExpirationTime)), format: .dateTime)
    }
    if container.contains(.notifiedTime) {
        self.notifiedTime = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .notifiedTime)), format: .dateTime)
    }
    if container.contains(.score) {
        self.score = try container.decode(Double?.self, forKey: .score)
    }
    if container.contains(.isDynamic) {
        self.isDynamic = try container.decode(Bool?.self, forKey: .isDynamic)
    }
    if container.contains(.extensionName) {
        self.extensionName = try container.decode(String?.self, forKey: .extensionName)
    }
    if container.contains(.bladeName) {
        self.bladeName = try container.decode(String?.self, forKey: .bladeName)
    }
    if container.contains(.forwardLink) {
        self.forwardLink = try container.decode(String?.self, forKey: .forwardLink)
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
    if self.creationTime != nil {
        try container.encode(DateConverter.toString(date: self.creationTime!, format: .dateTime), forKey: .creationTime)
    }
    if self.recommendationId != nil {try container.encode(self.recommendationId, forKey: .recommendationId)}
    if self.resourceId != nil {try container.encode(self.resourceId, forKey: .resourceId)}
    if self.resourceScope != nil {try container.encode(self.resourceScope, forKey: .resourceScope)}
    if self.ruleName != nil {try container.encode(self.ruleName, forKey: .ruleName)}
    if self.displayName != nil {try container.encode(self.displayName, forKey: .displayName)}
    if self.message != nil {try container.encode(self.message, forKey: .message)}
    if self.level != nil {try container.encode(self.level, forKey: .level)}
    if self.channels != nil {try container.encode(self.channels, forKey: .channels)}
    if self.tags != nil {try container.encode(self.tags as! [String]?, forKey: .tags)}
    if self.actionName != nil {try container.encode(self.actionName, forKey: .actionName)}
    if self.startTime != nil {
        try container.encode(DateConverter.toString(date: self.startTime!, format: .dateTime), forKey: .startTime)
    }
    if self.endTime != nil {
        try container.encode(DateConverter.toString(date: self.endTime!, format: .dateTime), forKey: .endTime)
    }
    if self.nextNotificationTime != nil {
        try container.encode(DateConverter.toString(date: self.nextNotificationTime!, format: .dateTime), forKey: .nextNotificationTime)
    }
    if self.notificationExpirationTime != nil {
        try container.encode(DateConverter.toString(date: self.notificationExpirationTime!, format: .dateTime), forKey: .notificationExpirationTime)
    }
    if self.notifiedTime != nil {
        try container.encode(DateConverter.toString(date: self.notifiedTime!, format: .dateTime), forKey: .notifiedTime)
    }
    if self.score != nil {try container.encode(self.score, forKey: .score)}
    if self.isDynamic != nil {try container.encode(self.isDynamic, forKey: .isDynamic)}
    if self.extensionName != nil {try container.encode(self.extensionName, forKey: .extensionName)}
    if self.bladeName != nil {try container.encode(self.bladeName, forKey: .bladeName)}
    if self.forwardLink != nil {try container.encode(self.forwardLink, forKey: .forwardLink)}
  }
}

extension DataFactory {
  public static func createRecommendationPropertiesProtocol() -> RecommendationPropertiesProtocol {
    return RecommendationPropertiesData()
  }
}
