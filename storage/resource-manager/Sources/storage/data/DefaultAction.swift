// DefaultAction enumerates the values for default action.

public enum DefaultAction: String, Codable
{
// DefaultActionAllow specifies the default action allow state for default action.
    case DefaultActionAllow = "Allow"
// DefaultActionDeny specifies the default action deny state for default action.
    case DefaultActionDeny = "Deny"
}
