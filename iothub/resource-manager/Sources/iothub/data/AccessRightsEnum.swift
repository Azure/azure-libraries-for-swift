// AccessRights enumerates the values for access rights.

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
public enum AccessRightsEnum: String, Codable
{
// DeviceConnect specifies the device connect state for access rights.
    case DeviceConnect = "DeviceConnect"
// RegistryRead specifies the registry read state for access rights.
    case RegistryRead = "RegistryRead"
// RegistryReadDeviceConnect specifies the registry read device connect state for access rights.
    case RegistryReadDeviceConnect = "RegistryRead, DeviceConnect"
// RegistryReadRegistryWrite specifies the registry read registry write state for access rights.
    case RegistryReadRegistryWrite = "RegistryRead, RegistryWrite"
// RegistryReadRegistryWriteDeviceConnect specifies the registry read registry write device connect state for access
// rights.
    case RegistryReadRegistryWriteDeviceConnect = "RegistryRead, RegistryWrite, DeviceConnect"
// RegistryReadRegistryWriteServiceConnect specifies the registry read registry write service connect state for access
// rights.
    case RegistryReadRegistryWriteServiceConnect = "RegistryRead, RegistryWrite, ServiceConnect"
// RegistryReadRegistryWriteServiceConnectDeviceConnect specifies the registry read registry write service connect
// device connect state for access rights.
    case RegistryReadRegistryWriteServiceConnectDeviceConnect = "RegistryRead, RegistryWrite, ServiceConnect, DeviceConnect"
// RegistryReadServiceConnect specifies the registry read service connect state for access rights.
    case RegistryReadServiceConnect = "RegistryRead, ServiceConnect"
// RegistryReadServiceConnectDeviceConnect specifies the registry read service connect device connect state for access
// rights.
    case RegistryReadServiceConnectDeviceConnect = "RegistryRead, ServiceConnect, DeviceConnect"
// RegistryWrite specifies the registry write state for access rights.
    case RegistryWrite = "RegistryWrite"
// RegistryWriteDeviceConnect specifies the registry write device connect state for access rights.
    case RegistryWriteDeviceConnect = "RegistryWrite, DeviceConnect"
// RegistryWriteServiceConnect specifies the registry write service connect state for access rights.
    case RegistryWriteServiceConnect = "RegistryWrite, ServiceConnect"
// RegistryWriteServiceConnectDeviceConnect specifies the registry write service connect device connect state for
// access rights.
    case RegistryWriteServiceConnectDeviceConnect = "RegistryWrite, ServiceConnect, DeviceConnect"
// ServiceConnect specifies the service connect state for access rights.
    case ServiceConnect = "ServiceConnect"
// ServiceConnectDeviceConnect specifies the service connect device connect state for access rights.
    case ServiceConnectDeviceConnect = "ServiceConnect, DeviceConnect"
}