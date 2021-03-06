// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// RelationshipLinkDefinitionProtocol is the definition of relationship link.
public protocol RelationshipLinkDefinitionProtocol : Codable {
     var displayName: [String:String]? { get set }
     var description: [String:String]? { get set }
     var interactionType: String { get set }
     var linkName: String? { get set }
     var mappings: [RelationshipLinkFieldMappingProtocol?]? { get set }
     var profilePropertyReferences: [ParticipantProfilePropertyReferenceProtocol] { get set }
     var provisioningState: ProvisioningStatesEnum? { get set }
     var relatedProfilePropertyReferences: [ParticipantProfilePropertyReferenceProtocol] { get set }
     var relationshipName: String { get set }
     var relationshipGuidId: String? { get set }
     var tenantId: String? { get set }
}
