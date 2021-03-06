// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct LocalDataVolumeData : LocalDataVolumeProtocol {
    public var hostPath: String
    public var localPath: String

        enum CodingKeys: String, CodingKey {case hostPath = "hostPath"
        case localPath = "localPath"
        }

  public init(hostPath: String, localPath: String)  {
    self.hostPath = hostPath
    self.localPath = localPath
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.hostPath = try container.decode(String.self, forKey: .hostPath)
    self.localPath = try container.decode(String.self, forKey: .localPath)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.hostPath, forKey: .hostPath)
    try container.encode(self.localPath, forKey: .localPath)
  }
}

extension DataFactory {
  public static func createLocalDataVolumeProtocol(hostPath: String, localPath: String) -> LocalDataVolumeProtocol {
    return LocalDataVolumeData(hostPath: hostPath, localPath: localPath)
  }
}
