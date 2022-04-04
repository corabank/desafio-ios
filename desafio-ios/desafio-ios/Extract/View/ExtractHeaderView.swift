//
//  ExtractHeaderView.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 19/03/22.
//

import Foundation
import UIKit

class ExtractHeaderView: UIView {
    
        lazy var allButton: UIButton = {
            let allButton = UIButton()
            allButton.setTitle("Tudo", for: .normal)
            allButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
            return allButton
        }()
    
        lazy var entranceButton: UIButton = {
            let entranceButton = UIButton()
            entranceButton.setTitle("Entrada", for: .normal)
            entranceButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
            return entranceButton
        }()
    
        lazy var exitButton: UIButton = {
            let exitButton = UIButton()
            exitButton.setTitle("Saída", for: .normal)
            exitButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
            return exitButton
        }()
    
        lazy var futureButton: UIButton = {
            let futureButton = UIButton()
            futureButton.setTitle("Futuro", for: .normal)
            futureButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
            return futureButton
        }()
    
        lazy var filterButton: UIButton = {
            let filterButton = UIButton()
            filterButton.setImage(UIImage(named: "ic_filter"), for: .normal)
            return filterButton
        }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Tudo", "Entrada", "Saída", "Futuro"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(segmentedControl)
    }
    
//    lazy var allButton: UIButton = {
//        let allButton = UIButton()
//        allButton.setTitle("Tudo", for: .normal)
//        allButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
//        return allButton
//    }()
//
//    lazy var entranceButton: UIButton = {
//        let entranceButton = UIButton()
//        entranceButton.setTitle("Entrada", for: .normal)
//        entranceButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
//        return entranceButton
//    }()
//
//    lazy var exitButton: UIButton = {
//        let exitButton = UIButton()
//        exitButton.setTitle("Saída", for: .normal)
//        exitButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
//        return exitButton
//    }()
//
//    lazy var futureButton: UIButton = {
//        let futureButton = UIButton()
//        futureButton.setTitle("Futuro", for: .normal)
//        futureButton.setTitleColor(UIColor(red: 254/255, green: 62/255, blue: 109/255, alpha: 1), for: .normal)
//        return futureButton
//    }()
//
//    lazy var filterButton: UIButton = {
//        let filterButton = UIButton()
//        filterButton.setImage(UIImage(named: "ic_filter"), for: .normal)
//        return filterButton
//    }()
//
//    init() {
//        super.init(frame: .zero)
//        backgroundColor = .white
//        setupViews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setupViews() {
//        allButton.translatesAutoresizingMaskIntoConstraints = false
//        entranceButton.translatesAutoresizingMaskIntoConstraints = false
//        exitButton.translatesAutoresizingMaskIntoConstraints = false
//        futureButton.translatesAutoresizingMaskIntoConstraints = false
//        filterButton.translatesAutoresizingMaskIntoConstraints = false
//
//        addSubview(allButton)
//        addSubview(entranceButton)
//        addSubview(exitButton)
//        addSubview(futureButton)
//        addSubview(filterButton)
//
//        NSLayoutConstraint.activate([
//            allButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
//            allButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
//            allButton.leftAnchor.constraint(equalTo: self.leftAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            entranceButton.topAnchor.constraint(equalTo: allButton.topAnchor),
//            entranceButton.leftAnchor.constraint(equalToSystemSpacingAfter: allButton.rightAnchor, multiplier: 2.20)
//        ])
//
//        NSLayoutConstraint.activate([
//            exitButton.topAnchor.constraint(equalTo: allButton.topAnchor),
//            exitButton.leftAnchor.constraint(equalToSystemSpacingAfter: entranceButton.rightAnchor, multiplier: 2.20)
//        ])
//
//        NSLayoutConstraint.activate([
//            futureButton.topAnchor.constraint(equalTo: allButton.topAnchor),
//            futureButton.leftAnchor.constraint(equalToSystemSpacingAfter: exitButton.rightAnchor, multiplier: 2.20)
//        ])
//
//        NSLayoutConstraint.activate([
//            filterButton.topAnchor.constraint(equalTo: allButton.topAnchor),
//            filterButton.leftAnchor.constraint(equalToSystemSpacingAfter: futureButton.rightAnchor, multiplier: 2.20)
//        ])
//    }
//
    
}
