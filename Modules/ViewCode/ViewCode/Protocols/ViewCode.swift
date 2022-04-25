public protocol ViewCode {
    func setSubviews()
    func setConstraints()
    func extraSetups()
    func setupView()
}

public extension ViewCode {
    func extraSetups() {}
    func setupView() {
        setSubviews()
        setConstraints()
        extraSetups()
    }
}
