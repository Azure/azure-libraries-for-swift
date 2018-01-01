// KeySource enumerates the values for key source.

public enum KeySource: String, Codable
{
// MicrosoftKeyvault specifies the microsoft keyvault state for key source.
    case MicrosoftKeyvault = "Microsoft.Keyvault"
// MicrosoftStorage specifies the microsoft storage state for key source.
    case MicrosoftStorage = "Microsoft.Storage"
}
