//
//  InvoiceScreen.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 15/05/22.
//

import UIKit

protocol InvoiceScreenDelegate: AnyObject {
    func payButtonPressed()
    func automaticDebitPressed()
    func barChartPressed()
}

final class InvoiceScreen : UIView {
    private let maxHeaderHeight: CGFloat = 300
    private let minHeaderHeight: CGFloat = 0
    private var previousScrollOffset: CGFloat = 0
    private var previousScrollViewHeight: CGFloat = 0
    private var cardView: UIView?

    private var data: InvoiceModel?
    
    weak var delegate: InvoiceScreenDelegate?

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: UIScreen.main.bounds)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .brown
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private lazy var cardSelector: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .systemGray4
        button.setTitle("Todos os Cartoes", for: .normal)
        button.setTitle("Todos os Cartoes", for: .selected)
        button.titleLabel?.font = Fonts.getFont(.bold(size: 14))()
        button.setTitleColor(.primary, for: [])
        button.setImage(Images.chevronDownIcon, for: .normal)
        button.setImage(Images.chevronDownIcon, for: .selected) // change after by a chevronUp
        button.addImageOnRightSide()
        button.addTarget(self, action: #selector(cardSelectorViewPressed), for: .touchUpInside)
        button.isSelected = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.delegate = self
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()

    private lazy var headerHeightConstraint: NSLayoutConstraint = {
        return headerView.constraints.filter{$0.firstAttribute == .height}.first!
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(InvoiceRowViewCell.self, forCellReuseIdentifier: "InvoiceRowViewCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
        self.tableView.reloadData()
        self.previousScrollViewHeight = self.tableView.contentSize.height
        self.headerHeightConstraint.constant = self.maxHeaderHeight
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addNewView(to container: UIView) -> UIView { // making this static for now
        let label1 = UILabel()
        label1.text = self.data?.cards?[0].cardName
        label1.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(card1Clicked))
        label1.addGestureRecognizer(tap)

        let label2 = UILabel()
        label2.text = self.data?.cards?[1].cardName
        label2.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(card2Clicked))
        label2.addGestureRecognizer(tap2)

        let stack = UIStackView(arrangedSubviews: [label1, label2])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        container.addSubview(stack)
        stack.backgroundColor = .systemGray4
        stack.frame = CGRect(x: cardSelector.frame.minX, y: cardSelector.frame.maxY, width: cardSelector.frame.width, height: 100)
        return stack
    }

    @objc private func cardSelectorViewPressed() {
        if cardSelector.isSelected {
            cardView?.removeFromSuperview()
        } else {
            cardView = addNewView(to: contentView)
        }
        cardSelector.isSelected.toggle()
    }

    @objc private func card1Clicked() {
        // CTA to filter table data
    }

    @objc private func card2Clicked() {
        // CTA to filter table data
    }
    
    func configure(data: InvoiceModel) {
        self.data = data
        headerView.configure(data: data.invoiceResume)
        tableView.reloadData()
    }
}

extension InvoiceScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data?.dataForTable[section].transactions.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        data?.dataForTable.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 32))
        view.backgroundColor = .systemGray4
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width, height: 32))
        label.font = Fonts.getFont(.regular(size: 14))()
        label.textColor = .gray1
        guard let cardName = data?.dataForTable[section].cardName,
              let number = data?.dataForTable[section].finalCardNumber else { return nil }
        label.text = "\(cardName) •••• \(number)"
        view.addSubview(label)
        return view
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceRowViewCell", for: indexPath)
        guard let rowCell = cell as? InvoiceRowViewCell,
              let data = data?.dataForTable[indexPath.section].transactions[indexPath.row] else {  return UITableViewCell() }
        rowCell.passData(model: data)
        rowCell.selectionStyle = .none
        return cell
    }
}
extension InvoiceScreen: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        defer {
            self.previousScrollViewHeight = scrollView.contentSize.height
            self.previousScrollOffset = scrollView.contentOffset.y
        }
        cardView?.removeFromSuperview()
        cardSelector.isSelected = false
        let heightDiff = scrollView.contentSize.height - self.previousScrollViewHeight
        let scrollDiff = (scrollView.contentOffset.y - self.previousScrollOffset)

        guard heightDiff == 0 else { return }

        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;

        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom

        if canAnimateHeader(scrollView) {
            var newHeight = self.headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.headerHeightConstraint.constant + abs(scrollDiff))
            }
            if newHeight != self.headerHeightConstraint.constant {
                self.headerHeightConstraint.constant = newHeight
                self.setScrollPosition(self.previousScrollOffset)
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidStopScrolling()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.scrollViewDidStopScrolling()
        }
    }

    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)

        if self.headerHeightConstraint.constant > midPoint {
            self.expandHeader()
        } else {
            self.collapseHeader()
        }
    }

    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + self.headerHeightConstraint.constant - minHeaderHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }

    func collapseHeader() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.minHeaderHeight
            self.layoutIfNeeded()
        })
    }

    func expandHeader() {
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.headerHeightConstraint.constant = self.maxHeaderHeight
            self.layoutIfNeeded()
        })
    }

    func setScrollPosition(_ position: CGFloat) {
        self.tableView.contentOffset = CGPoint(x: self.tableView.contentOffset.x, y: position)
    }
}
extension InvoiceScreen: HeaderViewDelegate {
    func payButtonPressed() {
        delegate?.payButtonPressed()
    }

    func automaticDebitPRessed() {
        delegate?.automaticDebitPressed()
    }

    func barChartPressed() {
        
    }
}

extension InvoiceScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(cardSelector)
        contentView.addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    
        NSLayoutConstraint.activate([
            cardSelector.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            cardSelector.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cardSelector.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cardSelector.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: cardSelector.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            tableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }

    func setupAdditionalConfigaration() {
        backgroundColor = .lightGray
    }
}
