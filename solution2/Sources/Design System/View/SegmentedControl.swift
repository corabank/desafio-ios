import UIKit

private final class SegmentedButton: UIButton {
    override var isSelected: Bool {
        didSet {
            isSelected ? setSelectedStyle() : setDefaultStyle()
        }
    }
    
    var title: String? = nil {
        didSet {
            setTitle(title, for: [])
        }
    }
    
    private func setDefaultStyle() {
        setTitleColor(Colors.gray01.color, for: [])
        titleLabel?.font = Font.Regular.primarySubtitle
    }
    
    private func setSelectedStyle() {
        setTitleColor(Colors.branding00.color, for: [])
        titleLabel?.font = Font.Highlighted.primarySubtitle
    }
}

protocol SegmentedControlDelegate: AnyObject {
    func didChangeSelection(to index: Int)
}

final class SegmentedControl: UIView {
    weak var delegate: SegmentedControlDelegate?
    private var segments = [SegmentedButton]()
    
    private lazy var selectIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.branding00.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: segments)
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = Spacing.space05
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: Spacing.space03,
                                           left: .zero,
                                           bottom:  Spacing.space03,
                                           right: .zero)
        return stack
    }()
    
    private(set) var selectedIndex = 0 {
        didSet {
            segments[selectedIndex].isSelected = true
            delegate?.didChangeSelection(to: selectedIndex)
        }
    }
    
    init(titles: [String], selectedIndex: Int) {
        super.init(frame: .zero)
        setSegments(titles: titles, selectedIndex: selectedIndex)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        adjustsIndicator()
    }
}

private extension SegmentedControl {
    func clearSelections() {
        segments.forEach { $0.isSelected = false }
    }
    
    func didTapSegment(at index: Int) {
        clearSelections()
        selectedIndex = index
        adjustsIndicator()
    }
    
    func setSegments(titles: [String], selectedIndex: Int) {
        titles.enumerated().forEach { index, title in
            let segment = SegmentedButton()
            segment.title = title
            segment.isSelected = false
            let action = UIAction { _ in
                self.didTapSegment(at: index)
            }
            segment.addAction(action, for: .touchUpInside)
            segments.append(segment)
        }
        
        self.selectedIndex = selectedIndex
    }
    
    func adjustsIndicator() {
        layoutIfNeeded()
        let titleFrame = segments[selectedIndex].titleLabel?.frame
        let buttonWidth = segments[selectedIndex].frame.width
        let newWidth = titleFrame?.width ?? 0
        let xPosition = segments[selectedIndex].frame.origin.x + ((buttonWidth - newWidth) / 2)
        let yPosition = segments[selectedIndex].frame.maxY
        
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
            self.selectIndicator.frame.origin.x = xPosition
            self.selectIndicator.frame.origin.y = yPosition
            self.selectIndicator.frame.size.width = newWidth
            self.selectIndicator.frame.size.height = 1
        })
    }
}

extension SegmentedControl: BuildableView {
    func setupHierarchy() {
        addSubviews(stackView, selectIndicator)
    }
    
    func setupConstraints() {
        stackView.fitToParent()
    }
}
