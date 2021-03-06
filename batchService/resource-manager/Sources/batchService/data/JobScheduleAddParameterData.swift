// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct JobScheduleAddParameterData : JobScheduleAddParameterProtocol {
    public var id: String
    public var displayName: String?
    public var schedule: ScheduleProtocol
    public var jobSpecification: JobSpecificationProtocol
    public var metadata: [MetadataItemProtocol?]?

        enum CodingKeys: String, CodingKey {case id = "id"
        case displayName = "displayName"
        case schedule = "schedule"
        case jobSpecification = "jobSpecification"
        case metadata = "metadata"
        }

  public init(id: String, schedule: ScheduleProtocol, jobSpecification: JobSpecificationProtocol)  {
    self.id = id
    self.schedule = schedule
    self.jobSpecification = jobSpecification
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      self.id = try container.decode(String.self, forKey: .id)
    if container.contains(.displayName) {
        self.displayName = try container.decode(String?.self, forKey: .displayName)
    }
    self.schedule = try container.decode(ScheduleData.self, forKey: .schedule)
    self.jobSpecification = try container.decode(JobSpecificationData.self, forKey: .jobSpecification)
    if container.contains(.metadata) {
        self.metadata = try container.decode([MetadataItemData?]?.self, forKey: .metadata)
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
    try container.encode(self.id, forKey: .id)
    if self.displayName != nil {try container.encode(self.displayName, forKey: .displayName)}
    try container.encode(self.schedule as! ScheduleData, forKey: .schedule)
    try container.encode(self.jobSpecification as! JobSpecificationData, forKey: .jobSpecification)
    if self.metadata != nil {try container.encode(self.metadata as! [MetadataItemData?]?, forKey: .metadata)}
  }
}

extension DataFactory {
  public static func createJobScheduleAddParameterProtocol(id: String, schedule: ScheduleProtocol, jobSpecification: JobSpecificationProtocol) -> JobScheduleAddParameterProtocol {
    return JobScheduleAddParameterData(id: id, schedule: schedule, jobSpecification: jobSpecification)
  }
}
