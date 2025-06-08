import SwiftUI

struct PrimaryTextField: View {
    // MARK: - Properties
    @FocusState private var isFocused: Bool
    @Binding private var text: String
    private let model: Model
    
    //MARK: - Initialization
    init(model: Model, text: Binding<String>) {
        self.model = model
        self._text = text
    }
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                Text(model.placeholderText)
                    .font(FontFamily.Nunito.regular.font(size: isFloating ? 12 : 16))
                    .foregroundColor(fieldColor)
                    .padding(.horizontal, 16)
                    .background(.white)
                    .offset(y: isFloating ? -12 : 0)
                    .animation(.easeInOut(duration: 0.2), value: isFloating)
                
                TextField("", text: $text)
                    .focused($isFocused)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
                    .keyboardType(model.fieldType.keyboardType)
                    .font(FontFamily.Nunito.regular.font(size: 16))
                    .onChange(of: text) {
                        switch model.fieldType {
                        case .phone:
                            let digitsOnly = text.filter { $0.isNumber }
                            text = digitsOnly.isEmpty ? "" : "+" + digitsOnly
                        case .name:
                            text = text.filter { $0.isLetter || $0.isWhitespace }
                        case .email:
                            text = text.lowercased()
                        }
                        
                        if let limit = model.characterLimit, text.count > limit {
                            text = String(text.prefix(limit))
                        }
                    }
            }
            .frame(height: 56)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(fieldColor, lineWidth: 1)
            )
            
            if hasError {
                Text(model.errorText ?? "")
                    .font(FontFamily.Nunito.regular.font(size: 12))
                    .foregroundColor(.errorRed)
            } else if model.fieldType == .phone {
                Text(String.localization.signup.phoneHint)
                    .font(FontFamily.Nunito.regular.font(size: 12))
                    .foregroundColor(.black.opacity(0.48))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
    
    private var isFloating: Bool {
        isFocused || !text.isEmpty
    }
    
    private var hasError: Bool {
        !(model.errorText?.isEmpty ?? true)
    }
    
    private var fieldColor: Color {
        hasError ? .errorRed : isFocused ? .functionalCyan : .black.opacity(0.48)
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil, from: nil, for: nil
            )
        }
    }
}
