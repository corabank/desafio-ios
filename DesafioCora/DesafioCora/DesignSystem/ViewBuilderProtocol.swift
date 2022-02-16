protocol ViewBuilderProtocol {
    func setupHierarchy()
    func setupConstraints()
    func setupViews()
    func buildLayout()
}

extension ViewBuilderProtocol {
    func buildLayout() {
        setupHierarchy()
        setupConstraints()
        setupViews()
    }
}
