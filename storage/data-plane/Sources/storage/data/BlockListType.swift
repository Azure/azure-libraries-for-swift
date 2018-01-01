// BlockListType enumerates the values for block list type.

public enum BlockListType: String, Codable
{
// All specifies the all state for block list type.
    case All = "all"
// Committed specifies the committed state for block list type.
    case Committed = "committed"
// Uncommitted specifies the uncommitted state for block list type.
    case Uncommitted = "uncommitted"
}
