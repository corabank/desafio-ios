enum BankStatementSegment: Int, CaseIterable {
    case all
    case input
    case output
    case future
    
    private typealias Localizable = Strings.BankStatement.Segment
    
    var description: String {
        switch self {
        case .all:
            return Localizable.all
        case .input:
            return Localizable.input
        case .output:
            return Localizable.output
        case .future:
            return Localizable.future
        }
    }
}
