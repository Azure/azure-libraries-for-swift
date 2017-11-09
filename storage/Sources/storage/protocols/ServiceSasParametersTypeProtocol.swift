import Foundation
// ServiceSasParametersTypeProtocol is the parameters to list service SAS credentials of a speicific resource.
public protocol ServiceSasParametersTypeProtocol : Codable {
     var canonicalizedResource: String? { get set }
     var signedResource: SignedResourceEnum? { get set }
     var signedPermission: PermissionsEnum? { get set }
     var signedIp: String? { get set }
     var signedProtocol: HttpProtocolEnum? { get set }
     var signedStart: String? { get set }
     var signedExpiry: String? { get set }
     var signedIdentifier: String? { get set }
     var startPk: String? { get set }
     var endPk: String? { get set }
     var startRk: String? { get set }
     var endRk: String? { get set }
     var keyToSign: String? { get set }
     var rscc: String? { get set }
     var rscd: String? { get set }
     var rsce: String? { get set }
     var rscl: String? { get set }
     var rsct: String? { get set }
}
