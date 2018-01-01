// PublicAccessType enumerates the values for public access type.

public enum PublicAccessType: String, Codable
{
// PublicAccessTypeBlob specifies the public access type blob state for public access type.
    case PublicAccessTypeBlob = "blob"
// PublicAccessTypeContainer specifies the public access type container state for public access type.
    case PublicAccessTypeContainer = "container"
}
