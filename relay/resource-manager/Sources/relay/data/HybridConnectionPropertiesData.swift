// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct HybridConnectionPropertiesData : HybridConnectionPropertiesProtocol {
    public var createdAt: Date?
    public var updatedAt: Date?
    public var listenerCount: Int32?
    public var requiresClientAuthorization: Bool?
    public var userMetadata: String?

        enum CodingKeys: String, CodingKey {case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case listenerCount = "listenerCount"
        case requiresClientAuthorization = "requiresClientAuthorization"
        case userMetadata = "userMetadata"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.createdAt) {
        self.createdAt = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .createdAt)), format: .dateTime)
    }
    if container.contains(.updatedAt) {
        self.updatedAt = DateConverter.fromString(dateStr: (try container.decode(String?.self, forKey: .updatedAt)), format: .dateTime)
    }
    if container.contains(.listenerCount) {
        self.listenerCount = try container.decode(Int32?.self, forKey: .listenerCount)
    }
    if container.contains(.requiresClientAuthorization) {
        self.requiresClientAuthorization = try container.decode(Bool?.self, forKey: .requiresClientAuthorization)
    }
    if container.contains(.userMetadata) {
        self.userMetadata = try container.decode(String?.self, forKey: .userMetadata)
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
    if self.createdAt != nil {
        try container.encode(DateConverter.toString(date: self.createdAt!, format: .dateTime), forKey: .createdAt)
    }
    if self.updatedAt != nil {
        try container.encode(DateConverter.toString(date: self.updatedAt!, format: .dateTime), forKey: .updatedAt)
    }
    if self.listenerCount != nil {try container.encode(self.listenerCount, forKey: .listenerCount)}
    if self.requiresClientAuthorization != nil {try container.encode(self.requiresClientAuthorization, forKey: .requiresClientAuthorization)}
    if self.userMetadata != nil {try container.encode(self.userMetadata, forKey: .userMetadata)}
  }
}

extension DataFactory {
  public static func createHybridConnectionPropertiesProtocol() -> HybridConnectionPropertiesProtocol {
    return HybridConnectionPropertiesData()
  }
}
