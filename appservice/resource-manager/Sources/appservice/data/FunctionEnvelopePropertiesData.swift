// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct FunctionEnvelopePropertiesData : FunctionEnvelopePropertiesProtocol {
    public var name: String?
    public var functionAppId: String?
    public var scriptRootPathHref: String?
    public var scriptHref: String?
    public var configHref: String?
    public var secretsFileHref: String?
    public var href: String?
    public var config: [String: String?]?
    public var files: [String:String]?
    public var testData: String?

        enum CodingKeys: String, CodingKey {case name = "name"
        case functionAppId = "functionAppId"
        case scriptRootPathHref = "scriptRootPathHref"
        case scriptHref = "scriptHref"
        case configHref = "configHref"
        case secretsFileHref = "secretsFileHref"
        case href = "href"
        case config = "config"
        case files = "files"
        case testData = "testData"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.functionAppId) {
        self.functionAppId = try container.decode(String?.self, forKey: .functionAppId)
    }
    if container.contains(.scriptRootPathHref) {
        self.scriptRootPathHref = try container.decode(String?.self, forKey: .scriptRootPathHref)
    }
    if container.contains(.scriptHref) {
        self.scriptHref = try container.decode(String?.self, forKey: .scriptHref)
    }
    if container.contains(.configHref) {
        self.configHref = try container.decode(String?.self, forKey: .configHref)
    }
    if container.contains(.secretsFileHref) {
        self.secretsFileHref = try container.decode(String?.self, forKey: .secretsFileHref)
    }
    if container.contains(.href) {
        self.href = try container.decode(String?.self, forKey: .href)
    }
    if container.contains(.config) {
        self.config = try container.decode([String: String?]?.self, forKey: .config)
    }
    if container.contains(.files) {
        self.files = try container.decode([String:String]?.self, forKey: .files)
    }
    if container.contains(.testData) {
        self.testData = try container.decode(String?.self, forKey: .testData)
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
    if self.name != nil {try container.encode(self.name, forKey: .name)}
    if self.functionAppId != nil {try container.encode(self.functionAppId, forKey: .functionAppId)}
    if self.scriptRootPathHref != nil {try container.encode(self.scriptRootPathHref, forKey: .scriptRootPathHref)}
    if self.scriptHref != nil {try container.encode(self.scriptHref, forKey: .scriptHref)}
    if self.configHref != nil {try container.encode(self.configHref, forKey: .configHref)}
    if self.secretsFileHref != nil {try container.encode(self.secretsFileHref, forKey: .secretsFileHref)}
    if self.href != nil {try container.encode(self.href, forKey: .href)}
    if self.config != nil {try container.encode(self.config, forKey: .config)}
    if self.files != nil {try container.encode(self.files, forKey: .files)}
    if self.testData != nil {try container.encode(self.testData, forKey: .testData)}
  }
}

extension DataFactory {
  public static func createFunctionEnvelopePropertiesProtocol() -> FunctionEnvelopePropertiesProtocol {
    return FunctionEnvelopePropertiesData()
  }
}
