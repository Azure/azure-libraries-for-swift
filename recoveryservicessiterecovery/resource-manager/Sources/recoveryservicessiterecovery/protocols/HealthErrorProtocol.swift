// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// HealthErrorProtocol is health Error
public protocol HealthErrorProtocol : Codable {
     var innerHealthErrors: [InnerHealthErrorProtocol?]? { get set }
     var errorSource: String? { get set }
     var errorType: String? { get set }
     var errorLevel: String? { get set }
     var errorCategory: String? { get set }
     var errorCode: String? { get set }
     var summaryMessage: String? { get set }
     var errorMessage: String? { get set }
     var possibleCauses: String? { get set }
     var recommendedAction: String? { get set }
     var creationTimeUtc: Date? { get set }
     var recoveryProviderErrorMessage: String? { get set }
     var entityId: String? { get set }
}
