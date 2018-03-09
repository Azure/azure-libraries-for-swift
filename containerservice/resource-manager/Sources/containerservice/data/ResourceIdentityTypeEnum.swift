// ResourceIdentityType enumerates the values for resource identity type.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum ResourceIdentityTypeEnum: String, Codable
{
// ResourceIdentityTypeNone specifies the resource identity type none state for resource identity type.
    case ResourceIdentityTypeNone = "None"
// ResourceIdentityTypeSystemAssigned specifies the resource identity type system assigned state for resource identity
// type.
    case ResourceIdentityTypeSystemAssigned = "SystemAssigned"
// ResourceIdentityTypeSystemAssignedUserAssigned specifies the resource identity type system assigned user assigned
// state for resource identity type.
    case ResourceIdentityTypeSystemAssignedUserAssigned = "SystemAssigned, UserAssigned"
// ResourceIdentityTypeUserAssigned specifies the resource identity type user assigned state for resource identity
// type.
    case ResourceIdentityTypeUserAssigned = "UserAssigned"
}