// BlobType enumerates the values for blob type.

public enum BlobType: String, Codable
{
// AppendBlob specifies the append blob state for blob type.
    case AppendBlob = "AppendBlob"
// BlockBlob specifies the block blob state for blob type.
    case BlockBlob = "BlockBlob"
// PageBlob specifies the page blob state for blob type.
    case PageBlob = "PageBlob"
}
