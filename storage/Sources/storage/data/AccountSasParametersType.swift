import Foundation
public struct AccountSasParametersType : AccountSasParametersTypeProtocol {
    public var signedServices: ServicesEnum?
    public var signedResourceTypes: SignedResourceTypesEnum?
    public var signedPermission: PermissionsEnum?
    public var signedIp: String?
    public var signedProtocol: HttpProtocolEnum?
    public var signedStart: String?
    public var signedExpiry: String?
    public var keyToSign: String?

    enum CodingKeys: String, CodingKey {
        case signedServices = "signedServices"
        case signedResourceTypes = "signedResourceTypes"
        case signedPermission = "signedPermission"
        case signedIp = "signedIp"
        case signedProtocol = "signedProtocol"
        case signedStart = "signedStart"
        case signedExpiry = "signedExpiry"
        case keyToSign = "keyToSign"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.signedServices) {
        signedServices = try container.decode(ServicesEnum?.self, forKey: .signedServices)
    }
    if container.contains(.signedResourceTypes) {
        signedResourceTypes = try container.decode(SignedResourceTypesEnum?.self, forKey: .signedResourceTypes)
    }
    if container.contains(.signedPermission) {
        signedPermission = try container.decode(PermissionsEnum?.self, forKey: .signedPermission)
    }
    if container.contains(.signedIp) {
        signedIp = try container.decode(String?.self, forKey: .signedIp)
    }
    if container.contains(.signedProtocol) {
        signedProtocol = try container.decode(HttpProtocolEnum?.self, forKey: .signedProtocol)
    }
    if container.contains(.signedStart) {
        signedStart = try container.decode(String?.self, forKey: .signedStart)
    }
    if container.contains(.signedExpiry) {
        signedExpiry = try container.decode(String?.self, forKey: .signedExpiry)
    }
    if container.contains(.keyToSign) {
        keyToSign = try container.decode(String?.self, forKey: .keyToSign)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(signedServices as! ServicesEnum?, forKey: .signedServices)
    try container.encode(signedResourceTypes as! SignedResourceTypesEnum?, forKey: .signedResourceTypes)
    try container.encode(signedPermission as! PermissionsEnum?, forKey: .signedPermission)
    try container.encode(signedIp, forKey: .signedIp)
    try container.encode(signedProtocol as! HttpProtocolEnum?, forKey: .signedProtocol)
    try container.encode(signedStart, forKey: .signedStart)
    try container.encode(signedExpiry, forKey: .signedExpiry)
    try container.encode(keyToSign, forKey: .keyToSign)
  }
}
