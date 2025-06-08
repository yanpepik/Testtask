import Foundation

enum Position: String, CaseIterable, Hashable {
    case frontend
    case backend
    case designer
    case qa
    
    var id: Int {
        switch self {
        case .frontend: return 1
        case .backend: return 2
        case .designer: return 3
        case .qa: return 4
        }
    }
    
    var localized: LocalizedStringResource {
        LocalizedStringResource(String.LocalizationValue(rawValue), table: "Localization")
    }
}
extension Position {
    static func from(id: Int) -> Position? {
        return Position.allCases.first(where: { $0.id == id })
    }
}
