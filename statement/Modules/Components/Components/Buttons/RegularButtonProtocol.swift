public protocol RegularButtonProtocol {
    func state(_ state: ButtonState)
}

public enum ButtonState {
    case disabled, enabled
}
