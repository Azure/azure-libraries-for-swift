// KeySourceEnum enumerates the values for key source enum.

public enum KeySourceEnum: String, Codable
{
// MicrosoftKeyvault specifies the microsoft keyvault state for key source enum.
    case MicrosoftKeyvault = "Microsoft.Keyvault"
// MicrosoftStorage specifies the microsoft storage state for key source enum.
    case MicrosoftStorage = "Microsoft.Storage"
}
