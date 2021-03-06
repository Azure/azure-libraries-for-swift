// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// MetricDefinitionsListResultProtocol is the response to a list metric definitions request.
public protocol MetricDefinitionsListResultProtocol : Codable {
     var value: [MetricDefinitionProtocol?]? { get set }
}
