// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct RelationshipsLookupData : RelationshipsLookupProtocol {
    public var profileName: String?
    public var profilePropertyReferences: [ParticipantProfilePropertyReferenceProtocol?]?
    public var relatedProfileName: String?
    public var relatedProfilePropertyReferences: [ParticipantProfilePropertyReferenceProtocol?]?
    public var existingRelationshipName: String?

        enum CodingKeys: String, CodingKey {case profileName = "profileName"
        case profilePropertyReferences = "profilePropertyReferences"
        case relatedProfileName = "relatedProfileName"
        case relatedProfilePropertyReferences = "relatedProfilePropertyReferences"
        case existingRelationshipName = "existingRelationshipName"
        }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.profileName) {
        self.profileName = try container.decode(String?.self, forKey: .profileName)
    }
    if container.contains(.profilePropertyReferences) {
        self.profilePropertyReferences = try container.decode([ParticipantProfilePropertyReferenceData?]?.self, forKey: .profilePropertyReferences)
    }
    if container.contains(.relatedProfileName) {
        self.relatedProfileName = try container.decode(String?.self, forKey: .relatedProfileName)
    }
    if container.contains(.relatedProfilePropertyReferences) {
        self.relatedProfilePropertyReferences = try container.decode([ParticipantProfilePropertyReferenceData?]?.self, forKey: .relatedProfilePropertyReferences)
    }
    if container.contains(.existingRelationshipName) {
        self.existingRelationshipName = try container.decode(String?.self, forKey: .existingRelationshipName)
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
    if self.profileName != nil {try container.encode(self.profileName, forKey: .profileName)}
    if self.profilePropertyReferences != nil {try container.encode(self.profilePropertyReferences as! [ParticipantProfilePropertyReferenceData?]?, forKey: .profilePropertyReferences)}
    if self.relatedProfileName != nil {try container.encode(self.relatedProfileName, forKey: .relatedProfileName)}
    if self.relatedProfilePropertyReferences != nil {try container.encode(self.relatedProfilePropertyReferences as! [ParticipantProfilePropertyReferenceData?]?, forKey: .relatedProfilePropertyReferences)}
    if self.existingRelationshipName != nil {try container.encode(self.existingRelationshipName, forKey: .existingRelationshipName)}
  }
}

extension DataFactory {
  public static func createRelationshipsLookupProtocol() -> RelationshipsLookupProtocol {
    return RelationshipsLookupData()
  }
}