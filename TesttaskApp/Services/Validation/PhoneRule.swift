struct PhoneRule {
    let prefix: String
    let length: Length

    func isValid(_ phone: String) -> Bool {
        phone.hasPrefix(prefix) && length.isSatisfied(by: phone.count)
    }
}

extension PhoneRule {
    enum Length {
        case fixed(Int)
        case range(min: Int, max: Int)

        func isSatisfied(by count: Int) -> Bool {
            switch self {
            case .fixed(let length):
                return count == length
            case .range(let min, let max):
                return (min...max).contains(count)
            }
        }
    }
}
