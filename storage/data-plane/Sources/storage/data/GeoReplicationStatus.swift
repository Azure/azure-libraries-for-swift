// GeoReplicationStatus enumerates the values for geo replication status.

public enum GeoReplicationStatus: String, Codable
{
// Bootstrap specifies the bootstrap state for geo replication status.
    case Bootstrap = "bootstrap"
// Live specifies the live state for geo replication status.
    case Live = "live"
// Unavailable specifies the unavailable state for geo replication status.
    case Unavailable = "unavailable"
}
