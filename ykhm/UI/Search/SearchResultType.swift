enum SearchResultType {
    case city
    case name
    case originalWord

    func resultList() -> [String] {
        switch self {
        case .city:
            return ["Tokyo", "Osaka", "Nagoya", "New York", "London", "Busan"]
        case .name:
            return ["taro", "jiro"]
        case .originalWord:
            return ["w", "ww"]
        }
    }
}
