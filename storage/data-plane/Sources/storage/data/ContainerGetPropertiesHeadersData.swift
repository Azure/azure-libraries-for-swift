// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is regenerated.
import Foundation
internal struct ContainerGetPropertiesHeadersData : ContainerGetPropertiesHeadersProtocol {
    public var metadata: [String:String]?
    public var eTag: String?
    public var lastModified: String?
    public var leaseDuration: LeaseDurationType?
    public var leaseState: LeaseStateType?
    public var leaseStatus: LeaseStatusType?
    public var requestId: String?
    public var version: String?
    public var date: Date?
    public var blobPublicAccess: PublicAccessType?

    enum CodingKeys: String, CodingKey {
        case metadata = "x-ms-meta"
        case eTag = "ETag"
        case lastModified = "Last-Modified"
        case leaseDuration = "x-ms-lease-duration"
        case leaseState = "x-ms-lease-state"
        case leaseStatus = "x-ms-lease-status"
        case requestId = "x-ms-request-id"
        case version = "x-ms-version"
        case date = "Date"
        case blobPublicAccess = "x-ms-blob-public-access"
    }

  public init()  {
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    if container.contains(.metadata) {
        metadata = try container.decode([String:String]?.self, forKey: .metadata)
    }
    if container.contains(.eTag) {
        eTag = try container.decode(String.self, forKey: .eTag)
    }
    if container.contains(.lastModified) {
        lastModified = try container.decode(String.self, forKey: .lastModified)
    }
    if container.contains(.leaseDuration) {
        leaseDuration = try container.decode(LeaseDurationType?.self, forKey: .leaseDuration)
    }
    if container.contains(.leaseState) {
        leaseState = try container.decode(LeaseStateType?.self, forKey: .leaseState)
    }
    if container.contains(.leaseStatus) {
        leaseStatus = try container.decode(LeaseStatusType?.self, forKey: .leaseStatus)
    }
    if container.contains(.requestId) {
        requestId = try container.decode(String.self, forKey: .requestId)
    }
    if container.contains(.version) {
        version = try container.decode(String.self, forKey: .version)
    }
    if container.contains(.date) {
        date = try container.decode(Date.self, forKey: .date)
    }
    if container.contains(.blobPublicAccess) {
        blobPublicAccess = try container.decode(PublicAccessType?.self, forKey: .blobPublicAccess)
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if self.metadata != nil {try container.encode(metadata, forKey: .metadata)}
    if self.eTag != nil {try container.encode(eTag, forKey: .eTag)}
    if self.lastModified != nil {try container.encode(lastModified, forKey: .lastModified)}
    if self.leaseDuration != nil {try container.encode(leaseDuration, forKey: .leaseDuration)}
    if self.leaseState != nil {try container.encode(leaseState, forKey: .leaseState)}
    if self.leaseStatus != nil {try container.encode(leaseStatus, forKey: .leaseStatus)}
    if self.requestId != nil {try container.encode(requestId, forKey: .requestId)}
    if self.version != nil {try container.encode(version, forKey: .version)}
    if self.date != nil {try container.encode(date, forKey: .date)}
    if self.blobPublicAccess != nil {try container.encode(blobPublicAccess, forKey: .blobPublicAccess)}
  }
}

extension DataFactory {
  public static func createContainerGetPropertiesHeadersProtocol() -> ContainerGetPropertiesHeadersProtocol {
    return ContainerGetPropertiesHeadersData()
  }
}
