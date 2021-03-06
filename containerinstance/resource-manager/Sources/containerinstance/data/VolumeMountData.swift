// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct VolumeMountData : VolumeMountProtocol {
    public var name: String
    public var mountPath: String
    public var readOnly: Bool?

        enum CodingKeys: String, CodingKey {case name = "name"
        case mountPath = "mountPath"
        case readOnly = "readOnly"
        }

  public init(name: String, mountPath: String)  {
    self.name = name
    self.mountPath = mountPath
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.name = try container.decode(String.self, forKey: .name)
    self.mountPath = try container.decode(String.self, forKey: .mountPath)
    if container.contains(.readOnly) {
        self.readOnly = try container.decode(Bool?.self, forKey: .readOnly)
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
    try container.encode(self.name, forKey: .name)
    try container.encode(self.mountPath, forKey: .mountPath)
    if self.readOnly != nil {try container.encode(self.readOnly, forKey: .readOnly)}
  }
}

extension DataFactory {
  public static func createVolumeMountProtocol(name: String, mountPath: String) -> VolumeMountProtocol {
    return VolumeMountData(name: name, mountPath: mountPath)
  }
}
