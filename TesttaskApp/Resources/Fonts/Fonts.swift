import SwiftUI

struct FontFamily {
    enum Nunito: String, FontProtocol, CaseIterable {
        case regular = "Nunito-Regular"
        case semibold = "Nunito-SemiBold"
    }
}

extension FontFamily {
    static func registerFonts() {
        FontFamily.Nunito.allCases.forEach { font in
            registerFont(fontName: font.rawValue, fontExtension: "ttf")
        }
    }

    private static func registerFont(fontName: String, fontExtension: String) {
        guard let url = Bundle.main.url(forResource: fontName, withExtension: fontExtension) else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
}

protocol FontProtocol {
    func font(size: CGFloat) -> Font?
}

extension FontProtocol where Self: RawRepresentable, Self.RawValue == String {
    func font(size: CGFloat) -> Font? {
        return Font.custom(rawValue, size: size)
    }
}
