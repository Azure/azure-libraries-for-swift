// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
import Foundation
// IpsecPolicyProtocol is an IPSec Policy configuration for a virtual network gateway connection
public protocol IpsecPolicyProtocol : Codable {
     var saLifeTimeSeconds: Int32 { get set }
     var saDataSizeKilobytes: Int32 { get set }
     var ipsecEncryption: IpsecEncryptionEnum { get set }
     var ipsecIntegrity: IpsecIntegrityEnum { get set }
     var ikeEncryption: IkeEncryptionEnum { get set }
     var ikeIntegrity: IkeIntegrityEnum { get set }
     var dhGroup: DhGroupEnum { get set }
     var pfsGroup: PfsGroupEnum { get set }
}
