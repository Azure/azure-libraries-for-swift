// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct JobScheduleCreateParametersData : JobScheduleCreateParametersProtocol {
    public var properties: JobScheduleCreatePropertiesProtocol

        enum CodingKeys: String, CodingKey {case properties = "properties"
        }

  public init(properties: JobScheduleCreatePropertiesProtocol)  {
    self.properties = properties
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.properties = try container.decode(JobScheduleCreatePropertiesData.self, forKey: .properties)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.properties as! JobScheduleCreatePropertiesData, forKey: .properties)
  }
}

extension DataFactory {
  public static func createJobScheduleCreateParametersProtocol(properties: JobScheduleCreatePropertiesProtocol) -> JobScheduleCreateParametersProtocol {
    return JobScheduleCreateParametersData(properties: properties)
  }
}