// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.

// FeatureSupport is the open API 2.0 Specs for Azure RecoveryServices Backup service
import Foundation
import azureSwiftRuntime
extension Commands {
public struct FeatureSupport {
    public static func Validate(azureRegion: String, subscriptionId: String, parameters: FeatureSupportRequestProtocol) -> FeatureSupportValidate {
        return ValidateCommand(azureRegion: azureRegion, subscriptionId: subscriptionId, parameters: parameters)
    }
}
}