// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// SlotConfigNamesProtocol is names for connection strings and application settings to be marked as sticky to the
// deployment slot and not moved during a swap operation.
// This is valid for all deployment slots in an app.
public protocol SlotConfigNamesProtocol : Codable {
     var connectionStringNames: [String]? { get set }
     var appSettingNames: [String]? { get set }
}