// KeyKind enumerates the values for key kind.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum KeyKindEnum: String, Codable
{
// Primary specifies the primary state for key kind.
    case Primary = "primary"
// PrimaryReadonly specifies the primary readonly state for key kind.
    case PrimaryReadonly = "primaryReadonly"
// Secondary specifies the secondary state for key kind.
    case Secondary = "secondary"
// SecondaryReadonly specifies the secondary readonly state for key kind.
    case SecondaryReadonly = "secondaryReadonly"
}