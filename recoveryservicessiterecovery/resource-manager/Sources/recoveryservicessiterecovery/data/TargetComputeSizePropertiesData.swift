// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct TargetComputeSizePropertiesData : TargetComputeSizePropertiesProtocol {
    public var name: String?
    public var friendlyName: String?
    public var cpuCoresCount: Int32?
    public var memoryInGB: Double?
    public var maxDataDiskCount: Int32?
    public var maxNicsCount: Int32?
    public var errors: [ComputeSizeErrorDetailsProtocol?]?
    public var highIopsSupported: String?

        enum CodingKeys: String, CodingKey {case name = "name"
        case friendlyName = "friendlyName"
        case cpuCoresCount = "cpuCoresCount"
        case memoryInGB = "memoryInGB"
        case maxDataDiskCount = "maxDataDiskCount"
        case maxNicsCount = "maxNicsCount"
        case errors = "errors"
        case highIopsSupported = "highIopsSupported"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.name) {
        self.name = try container.decode(String?.self, forKey: .name)
    }
    if container.contains(.friendlyName) {
        self.friendlyName = try container.decode(String?.self, forKey: .friendlyName)
    }
    if container.contains(.cpuCoresCount) {
        self.cpuCoresCount = try container.decode(Int32?.self, forKey: .cpuCoresCount)
    }
    if container.contains(.memoryInGB) {
        self.memoryInGB = try container.decode(Double?.self, forKey: .memoryInGB)
    }
    if container.contains(.maxDataDiskCount) {
        self.maxDataDiskCount = try container.decode(Int32?.self, forKey: .maxDataDiskCount)
    }
    if container.contains(.maxNicsCount) {
        self.maxNicsCount = try container.decode(Int32?.self, forKey: .maxNicsCount)
    }
    if container.contains(.errors) {
        self.errors = try container.decode([ComputeSizeErrorDetailsData?]?.self, forKey: .errors)
    }
    if container.contains(.highIopsSupported) {
        self.highIopsSupported = try container.decode(String?.self, forKey: .highIopsSupported)
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
    if self.friendlyName != nil {try container.encode(self.friendlyName, forKey: .friendlyName)}
    if self.cpuCoresCount != nil {try container.encode(self.cpuCoresCount, forKey: .cpuCoresCount)}
    if self.memoryInGB != nil {try container.encode(self.memoryInGB, forKey: .memoryInGB)}
    if self.maxDataDiskCount != nil {try container.encode(self.maxDataDiskCount, forKey: .maxDataDiskCount)}
    if self.maxNicsCount != nil {try container.encode(self.maxNicsCount, forKey: .maxNicsCount)}
    if self.errors != nil {try container.encode(self.errors as! [ComputeSizeErrorDetailsData?]?, forKey: .errors)}
    if self.highIopsSupported != nil {try container.encode(self.highIopsSupported, forKey: .highIopsSupported)}
  }
}

extension DataFactory {
  public static func createTargetComputeSizePropertiesProtocol() -> TargetComputeSizePropertiesProtocol {
    return TargetComputeSizePropertiesData()
  }
}