//
//  OrderListCollectionView.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 15/03/21.
//

import UIKit

class OrderListCollectionView: UIView {
    
    var logoCollectionView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Cora")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var titleLabel: UILabel  = {
        let label = UILabel()
        label.text = "Pedidos"
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var allOrders: UILabel  = {
        let label = UILabel()
        label.text = "320 pedidos, totalizando R$ 115.345,45"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var currentUser: UILabel  = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.backgroundColor = .clear
    }
    
    private func setupViewHierarchy() {
        self.addSubview(logoCollectionView)
        self.addSubview(currentUser)
        self.addSubview(titleLabel)
        self.addSubview(allOrders)
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        self.logoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(24)
            make.leading.equalTo(self.snp.leading).offset(24)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        self.currentUser.snp.makeConstraints { make in
            make.centerY.equalTo(logoCollectionView.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoCollectionView.snp.bottom).offset(12)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)

        }
        
        self.allOrders.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.equalTo(self.snp.trailing).offset(-24)
            make.leading.equalTo(self.snp.leading).offset(24)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.allOrders.snp.bottom).offset(16)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
}
