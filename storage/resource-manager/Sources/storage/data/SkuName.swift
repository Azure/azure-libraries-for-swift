// SkuName enumerates the values for sku name.

public enum SkuName: String, Codable
{
// PremiumLRS specifies the premium lrs state for sku name.
    case PremiumLRS = "Premium_LRS"
// StandardGRS specifies the standard grs state for sku name.
    case StandardGRS = "Standard_GRS"
// StandardLRS specifies the standard lrs state for sku name.
    case StandardLRS = "Standard_LRS"
// StandardRAGRS specifies the standard ragrs state for sku name.
    case StandardRAGRS = "Standard_RAGRS"
// StandardZRS specifies the standard zrs state for sku name.
    case StandardZRS = "Standard_ZRS"
}
