// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// PowerBIOutputDataSourcePropertiesProtocol is the properties that are associated with a Power BI output.
public protocol PowerBIOutputDataSourcePropertiesProtocol : OAuthBasedDataSourcePropertiesProtocol {
     var dataset: String? { get set }
     var table: String? { get set }
     var groupId: String? { get set }
     var groupName: String? { get set }
}
