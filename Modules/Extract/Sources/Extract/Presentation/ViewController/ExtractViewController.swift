//
//  ExtractViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 16/03/24.
//

import UIKit
import Core

class ExtractViewController: UIViewController, PresentableExtractView {
    
    enum ExtractConstants {
        static let filterBarItems = ["Tudo", "Entrada", "Saída", "Futuro"]
    }
    
    //MARK: - properties
    
    private let navigationService: ExtractCoordinator
    private let viewModel: ExtractViewModelProtocol
    
    //MARK: - views
    
    private lazy var filterBarView: FilterBarView = {
        let filterBarView = FilterBarView(
            items: ExtractConstants.filterBarItems,
            selectedItemIndex: .zero
        )
        
        filterBarView.translatesAutoresizingMaskIntoConstraints = false
        return filterBarView
    }()
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorInset = .init(top: Constants.defaultPadding / 4, left: .zero, bottom: Constants.defaultPadding / 4, right: .zero)
        tableView.register(ExtractListItemCell.self, forCellReuseIdentifier: ExtractListItemCell.identifier)
        tableView.refreshControl = refreshControl
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0 }
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    //MARK: - setup
    
    init(navigationService: ExtractCoordinator, viewModel: ExtractViewModelProtocol) {
        self.navigationService = navigationService
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        
        viewModel.onFetchError = {
            print("[ERROR]:: \($0)")
        }
        
        viewModel.onFetchSuccess = { [weak self] _ in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.Extract.signOutIcon, style: .plain, target: nil, action: nil)
        title = "Extrato"
    }
    
    private func prepareView() {
        view.backgroundColor = AppColors.navigationBarBackground
        
        prepareFilterBarView()
        prepareTableView()
        
        refreshControl.tintColor = AppColors.primary
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
    }
    
    private func prepareFilterBarView() {
        view.addSubview(filterBarView)
        
        NSLayoutConstraint.activate([
            filterBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterBarView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc
    private func didPullRefresh() {
        tableView.visibleCells.forEach {
            guard let cell = $0 as? ExtractListItemCell else { return }
            cell.showShimmerAnimation()
        }
        
        viewModel.fetchData()
    }
}

//MARK: - table view data source

extension ExtractViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let listData = viewModel.listData else { return 5 }
        return listData.results.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listData = viewModel.listData else { return 1 }
        return listData.results[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExtractListItemCell.identifier, for: indexPath) as? ExtractListItemCell else { return UITableViewCell() }

        if let listData = viewModel.listData {
            cell.prepare(item: listData.results[indexPath.section].items[indexPath.row])
        } else {
            cell.showShimmerAnimation()
        }

        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - table view delegate

extension ExtractViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listData = viewModel.listData else { return }
        guard indexPath.section < listData.results.count else { return }
        guard indexPath.row < listData.results[indexPath.section].items.count else { return }
        
        navigationService.openExtractDetails(withId: listData.results[indexPath.section].items[indexPath.row].id)
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let listData = viewModel.listData else { return nil }
        return ExtractTableHeaderView(dateString: listData.results[section].date)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = viewModel.listData else { return .leastNonzeroMagnitude }
        return Constants.defaultPadding * 1.25
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}
