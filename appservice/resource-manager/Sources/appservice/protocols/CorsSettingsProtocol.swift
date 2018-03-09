// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// CorsSettingsProtocol is cross-Origin Resource Sharing (CORS) settings for the app.
public protocol CorsSettingsProtocol : Codable {
     var allowedOrigins: [String]? { get set }
}