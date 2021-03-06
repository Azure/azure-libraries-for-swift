// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// VariableCreateOrUpdateParametersProtocol is the parameters supplied to the create or update variable operation.
public protocol VariableCreateOrUpdateParametersProtocol : Codable {
     var name: String { get set }
     var properties: VariableCreateOrUpdatePropertiesProtocol { get set }
}
