// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
import azureSwiftRuntime
internal struct SalesforceTableData : SalesforceTableProtocol {
    public var isProfile: String?
    public var tableCategory: String
    public var tableName: String
    public var tableRemarks: String?
    public var tableSchema: String

        enum CodingKeys: String, CodingKey {case isProfile = "isProfile"
        case tableCategory = "tableCategory"
        case tableName = "tableName"
        case tableRemarks = "tableRemarks"
        case tableSchema = "tableSchema"
        }

  public init(tableCategory: String, tableName: String, tableSchema: String)  {
    self.tableCategory = tableCategory
    self.tableName = tableName
    self.tableSchema = tableSchema
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
      if container.contains(.isProfile) {
        self.isProfile = try container.decode(String?.self, forKey: .isProfile)
    }
    self.tableCategory = try container.decode(String.self, forKey: .tableCategory)
    self.tableName = try container.decode(String.self, forKey: .tableName)
    if container.contains(.tableRemarks) {
        self.tableRemarks = try container.decode(String?.self, forKey: .tableRemarks)
    }
    self.tableSchema = try container.decode(String.self, forKey: .tableSchema)
    if var pageDecoder = decoder as? PageDecoder  {
      if pageDecoder.isPagedData,
        let nextLinkName = pageDecoder.nextLinkName {
          pageDecoder.nextLink = try UnknownCodingKey.decodeStringForKey(decoder: decoder, keyForDecode: nextLinkName)
      }
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.isProfile != nil {try container.encode(self.isProfile, forKey: .isProfile)}
    try container.encode(self.tableCategory, forKey: .tableCategory)
    try container.encode(self.tableName, forKey: .tableName)
    if self.tableRemarks != nil {try container.encode(self.tableRemarks, forKey: .tableRemarks)}
    try container.encode(self.tableSchema, forKey: .tableSchema)
  }
}

extension DataFactory {
  public static func createSalesforceTableProtocol(tableCategory: String, tableName: String, tableSchema: String) -> SalesforceTableProtocol {
    return SalesforceTableData(tableCategory: tableCategory, tableName: tableName, tableSchema: tableSchema)
  }
}
