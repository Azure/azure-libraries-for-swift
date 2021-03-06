// PrimaryAggregationType enumerates the values for primary aggregation type.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum PrimaryAggregationTypeEnum: String, Codable
{
// Average specifies the average state for primary aggregation type.
    case Average = "Average"
// Last specifies the last state for primary aggregation type.
    case Last = "Last"
// Maximum specifies the maximum state for primary aggregation type.
    case Maximum = "Maximum"
// Minimimum specifies the minimimum state for primary aggregation type.
    case Minimimum = "Minimimum"
// None specifies the none state for primary aggregation type.
    case None = "None"
// Total specifies the total state for primary aggregation type.
    case Total = "Total"
}
