import Foundation
public struct ServiceSasParametersType : ServiceSasParametersTypeProtocol {
    public var canonicalizedResource: String?
    public var signedResource: SignedResourceEnum?
    public var signedPermission: PermissionsEnum?
    public var signedIp: String?
    public var signedProtocol: HttpProtocolEnum?
    public var signedStart: String?
    public var signedExpiry: String?
    public var signedIdentifier: String?
    public var startPk: String?
    public var endPk: String?
    public var startRk: String?
    public var endRk: String?
    public var keyToSign: String?
    public var rscc: String?
    public var rscd: String?
    public var rsce: String?
    public var rscl: String?
    public var rsct: String?

    enum CodingKeys: String, CodingKey {
        case canonicalizedResource = "canonicalizedResource"
        case signedResource = "signedResource"
        case signedPermission = "signedPermission"
        case signedIp = "signedIp"
        case signedProtocol = "signedProtocol"
        case signedStart = "signedStart"
        case signedExpiry = "signedExpiry"
        case signedIdentifier = "signedIdentifier"
        case startPk = "startPk"
        case endPk = "endPk"
        case startRk = "startRk"
        case endRk = "endRk"
        case keyToSign = "keyToSign"
        case rscc = "rscc"
        case rscd = "rscd"
        case rsce = "rsce"
        case rscl = "rscl"
        case rsct = "rsct"
    }

  public init() {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.canonicalizedResource) {
        canonicalizedResource = try container.decode(String?.self, forKey: .canonicalizedResource)
    }
    if container.contains(.signedResource) {
        signedResource = try container.decode(SignedResourceEnum?.self, forKey: .signedResource)
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
    if container.contains(.signedIdentifier) {
        signedIdentifier = try container.decode(String?.self, forKey: .signedIdentifier)
    }
    if container.contains(.startPk) {
        startPk = try container.decode(String?.self, forKey: .startPk)
    }
    if container.contains(.endPk) {
        endPk = try container.decode(String?.self, forKey: .endPk)
    }
    if container.contains(.startRk) {
        startRk = try container.decode(String?.self, forKey: .startRk)
    }
    if container.contains(.endRk) {
        endRk = try container.decode(String?.self, forKey: .endRk)
    }
    if container.contains(.keyToSign) {
        keyToSign = try container.decode(String?.self, forKey: .keyToSign)
    }
    if container.contains(.rscc) {
        rscc = try container.decode(String?.self, forKey: .rscc)
    }
    if container.contains(.rscd) {
        rscd = try container.decode(String?.self, forKey: .rscd)
    }
    if container.contains(.rsce) {
        rsce = try container.decode(String?.self, forKey: .rsce)
    }
    if container.contains(.rscl) {
        rscl = try container.decode(String?.self, forKey: .rscl)
    }
    if container.contains(.rsct) {
        rsct = try container.decode(String?.self, forKey: .rsct)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.canonicalizedResource != nil {try container.encode(canonicalizedResource, forKey: .canonicalizedResource)}
    if self.signedResource != nil {try container.encode(signedResource, forKey: .signedResource)}
    if self.signedPermission != nil {try container.encode(signedPermission, forKey: .signedPermission)}
    if self.signedIp != nil {try container.encode(signedIp, forKey: .signedIp)}
    if self.signedProtocol != nil {try container.encode(signedProtocol, forKey: .signedProtocol)}
    if self.signedStart != nil {try container.encode(signedStart, forKey: .signedStart)}
    if self.signedExpiry != nil {try container.encode(signedExpiry, forKey: .signedExpiry)}
    if self.signedIdentifier != nil {try container.encode(signedIdentifier, forKey: .signedIdentifier)}
    if self.startPk != nil {try container.encode(startPk, forKey: .startPk)}
    if self.endPk != nil {try container.encode(endPk, forKey: .endPk)}
    if self.startRk != nil {try container.encode(startRk, forKey: .startRk)}
    if self.endRk != nil {try container.encode(endRk, forKey: .endRk)}
    if self.keyToSign != nil {try container.encode(keyToSign, forKey: .keyToSign)}
    if self.rscc != nil {try container.encode(rscc, forKey: .rscc)}
    if self.rscd != nil {try container.encode(rscd, forKey: .rscd)}
    if self.rsce != nil {try container.encode(rsce, forKey: .rsce)}
    if self.rscl != nil {try container.encode(rscl, forKey: .rscl)}
    if self.rsct != nil {try container.encode(rsct, forKey: .rsct)}
  }
}
