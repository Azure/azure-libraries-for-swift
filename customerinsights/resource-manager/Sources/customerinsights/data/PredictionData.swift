// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct PredictionData : PredictionProtocol {
    public var description: [String:String]?
    public var displayName: [String:String]?
    public var involvedInteractionTypes: [String]?
    public var involvedKpiTypes: [String]?
    public var involvedRelationships: [String]?
    public var negativeOutcomeExpression: String
    public var positiveOutcomeExpression: String
    public var primaryProfileType: String
    public var provisioningState: ProvisioningStatesEnum?
    public var predictionName: String?
    public var scopeExpression: String
    public var tenantId: String?
    public var autoAnalyze: Bool
    public var mappings: PredictionMappingsProtocol
    public var scoreLabel: String
    public var grades: [PredictionGradesItemProtocol?]?
    public var systemGeneratedEntities: PredictionSystemGeneratedEntitiesProtocol?

        enum CodingKeys: String, CodingKey {case description = "description"
        case displayName = "displayName"
        case involvedInteractionTypes = "involvedInteractionTypes"
        case involvedKpiTypes = "involvedKpiTypes"
        case involvedRelationships = "involvedRelationships"
        case negativeOutcomeExpression = "negativeOutcomeExpression"
        case positiveOutcomeExpression = "positiveOutcomeExpression"
        case primaryProfileType = "primaryProfileType"
        case provisioningState = "provisioningState"
        case predictionName = "predictionName"
        case scopeExpression = "scopeExpression"
        case tenantId = "tenantId"
        case autoAnalyze = "autoAnalyze"
        case mappings = "mappings"
        case scoreLabel = "scoreLabel"
        case grades = "grades"
        case systemGeneratedEntities = "systemGeneratedEntities"
        }

  public init(negativeOutcomeExpression: String, positiveOutcomeExpression: String, primaryProfileType: String, scopeExpression: String, autoAnalyze: Bool, mappings: PredictionMappingsProtocol, scoreLabel: String)  {
    self.negativeOutcomeExpression = negativeOutcomeExpression
    self.positiveOutcomeExpression = positiveOutcomeExpression
    self.primaryProfileType = primaryProfileType
    self.scopeExpression = scopeExpression
    self.autoAnalyze = autoAnalyze
    self.mappings = mappings
    self.scoreLabel = scoreLabel
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.description) {
        self.description = try container.decode([String:String]?.self, forKey: .description)
    }
    if container.contains(.displayName) {
        self.displayName = try container.decode([String:String]?.self, forKey: .displayName)
    }
    if container.contains(.involvedInteractionTypes) {
        self.involvedInteractionTypes = try container.decode([String]?.self, forKey: .involvedInteractionTypes)
    }
    if container.contains(.involvedKpiTypes) {
        self.involvedKpiTypes = try container.decode([String]?.self, forKey: .involvedKpiTypes)
    }
    if container.contains(.involvedRelationships) {
        self.involvedRelationships = try container.decode([String]?.self, forKey: .involvedRelationships)
    }
    self.negativeOutcomeExpression = try container.decode(String.self, forKey: .negativeOutcomeExpression)
    self.positiveOutcomeExpression = try container.decode(String.self, forKey: .positiveOutcomeExpression)
    self.primaryProfileType = try container.decode(String.self, forKey: .primaryProfileType)
    if container.contains(.provisioningState) {
        self.provisioningState = try container.decode(ProvisioningStatesEnum?.self, forKey: .provisioningState)
    }
    if container.contains(.predictionName) {
        self.predictionName = try container.decode(String?.self, forKey: .predictionName)
    }
    self.scopeExpression = try container.decode(String.self, forKey: .scopeExpression)
    if container.contains(.tenantId) {
        self.tenantId = try container.decode(String?.self, forKey: .tenantId)
    }
    self.autoAnalyze = try container.decode(Bool.self, forKey: .autoAnalyze)
    self.mappings = try container.decode(PredictionMappingsData.self, forKey: .mappings)
    self.scoreLabel = try container.decode(String.self, forKey: .scoreLabel)
    if container.contains(.grades) {
        self.grades = try container.decode([PredictionGradesItemData?]?.self, forKey: .grades)
    }
    if container.contains(.systemGeneratedEntities) {
        self.systemGeneratedEntities = try container.decode(PredictionSystemGeneratedEntitiesData?.self, forKey: .systemGeneratedEntities)
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
    if self.description != nil {try container.encode(self.description, forKey: .description)}
    if self.displayName != nil {try container.encode(self.displayName, forKey: .displayName)}
    if self.involvedInteractionTypes != nil {try container.encode(self.involvedInteractionTypes as! [String]?, forKey: .involvedInteractionTypes)}
    if self.involvedKpiTypes != nil {try container.encode(self.involvedKpiTypes as! [String]?, forKey: .involvedKpiTypes)}
    if self.involvedRelationships != nil {try container.encode(self.involvedRelationships as! [String]?, forKey: .involvedRelationships)}
    try container.encode(self.negativeOutcomeExpression, forKey: .negativeOutcomeExpression)
    try container.encode(self.positiveOutcomeExpression, forKey: .positiveOutcomeExpression)
    try container.encode(self.primaryProfileType, forKey: .primaryProfileType)
    if self.provisioningState != nil {try container.encode(self.provisioningState, forKey: .provisioningState)}
    if self.predictionName != nil {try container.encode(self.predictionName, forKey: .predictionName)}
    try container.encode(self.scopeExpression, forKey: .scopeExpression)
    if self.tenantId != nil {try container.encode(self.tenantId, forKey: .tenantId)}
    try container.encode(self.autoAnalyze, forKey: .autoAnalyze)
    try container.encode(self.mappings as! PredictionMappingsData, forKey: .mappings)
    try container.encode(self.scoreLabel, forKey: .scoreLabel)
    if self.grades != nil {try container.encode(self.grades as! [PredictionGradesItemData?]?, forKey: .grades)}
    if self.systemGeneratedEntities != nil {try container.encode(self.systemGeneratedEntities as! PredictionSystemGeneratedEntitiesData?, forKey: .systemGeneratedEntities)}
  }
}

extension DataFactory {
  public static func createPredictionProtocol(negativeOutcomeExpression: String, positiveOutcomeExpression: String, primaryProfileType: String, scopeExpression: String, autoAnalyze: Bool, mappings: PredictionMappingsProtocol, scoreLabel: String) -> PredictionProtocol {
    return PredictionData(negativeOutcomeExpression: negativeOutcomeExpression, positiveOutcomeExpression: positiveOutcomeExpression, primaryProfileType: primaryProfileType, scopeExpression: scopeExpression, autoAnalyze: autoAnalyze, mappings: mappings, scoreLabel: scoreLabel)
  }
}
