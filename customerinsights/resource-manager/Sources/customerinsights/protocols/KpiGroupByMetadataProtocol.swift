// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// KpiGroupByMetadataProtocol is the KPI GroupBy field metadata.
public protocol KpiGroupByMetadataProtocol : Codable {
     var displayName: [String:String]? { get set }
     var fieldName: String? { get set }
     var fieldType: String? { get set }
}