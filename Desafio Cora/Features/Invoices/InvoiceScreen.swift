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

    private var data: [InvoiceModel]
    
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

    private lazy var teste: UIView = {
      let contentView = UIView()
        contentView.backgroundColor = .brown
      contentView.translatesAutoresizingMaskIntoConstraints = false
      return contentView
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(frame: CGRect = .zero, data: [InvoiceModel]) {
        self.data = data
        super.init(frame: frame)
        setupView()
        self.tableView.reloadData()
        self.previousScrollViewHeight = self.tableView.contentSize.height
        self.headerHeightConstraint.constant = self.maxHeaderHeight
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InvoiceScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        60
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceRowViewCell", for: indexPath)
        guard let rowCell = cell as? InvoiceRowViewCell else {
            let x =  UITableViewCell()
            x.backgroundColor = .black
            return x
        }
        rowCell.passData(model: InvoiceModel())
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
        contentView.addSubview(teste)
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
            teste.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            teste.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            teste.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            teste.heightAnchor.constraint(equalToConstant: 56)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: teste.bottomAnchor, constant: 0),
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
