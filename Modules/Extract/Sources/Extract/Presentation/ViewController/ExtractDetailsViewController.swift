//
//  ExtractDetailsViewController.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 18/03/24.
//

import UIKit
import Core
import Network

class ExtractDetailsViewController: UIViewController {
    
    enum ExtractDetailsConstants {
        static let imageSize: CGFloat = 24.0
    }
    
    //MARK: - properties
    
    private let detailsId: String
    private let dummyData = ExtractDetails.getMock()
    
    private let navigationService: ExtractCoordinator
    private let viewModel: ExtractDetailsViewModelProtocol
    
    //MARK: - views
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = Constants.defaultPadding
        return view
    }()
    
    private let shareButton: ButtonView = {
        let view = ButtonView()
        view.style = .primary
        view.size = .big
        view.text = "Compartilhar Comprovante"
        view.image = Images.Extract.shareIcon
        return view
    }()
    
    //MARK: - setup
    
    init(navigationService: ExtractCoordinator, viewModel: ExtractDetailsViewModelProtocol, detailsId: String) {
        self.navigationService = navigationService
        self.viewModel = viewModel
        self.detailsId = detailsId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = nil
        title = "Detalhes da transferência"
        
        scrollView.contentSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        
        viewModel.onFetchError = {
            print("[ERROR]:: \($0)")
        }
        
        viewModel.onFetchSuccess = { [weak self] _ in
            DispatchQueue.main.async {
                self?.prepareContent()
            }
        }
        
        viewModel.fetchData(withId: detailsId)
    }
    
    private func prepareView() {
        view.backgroundColor = AppColors.navigationBarBackground
        
        prepareScrollView()
        prepareContent()
    }
    
    private func prepareScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Constants.defaultPadding),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Constants.defaultPadding),
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.defaultPadding),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Constants.defaultPadding),
            scrollStackViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (Constants.defaultPadding * 2))
        ])
    }
    
    private func prepareContent() {
        let dataToUse = viewModel.data ?? dummyData
        
        scrollStackViewContainer.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        scrollStackViewContainer.addArrangedSubview(
            makeTitleStack(image: Images.Extract.arrowUpOut, text: dataToUse.label)
        )
        
        scrollStackViewContainer.addArrangedSubview(
            makeLabelStack(topText: "Valor", bottomText: dataToUse.amount.asCurrency)
        )
        
        scrollStackViewContainer.addArrangedSubview(
            makeLabelStack(topText: "Data", bottomText: dataToUse.dateEvent.asDate(currentFormat: "YYYY-MM-dd", toFormat: "EEEE - dd 'de' MMMM"))
        )
        
        if let sender = dataToUse.sender {
            scrollStackViewContainer.addArrangedSubview(
                makeBankStack(bankDetails: sender, isSender: true)
            )
        }
        
        if let recipient = dataToUse.recipient {
            scrollStackViewContainer.addArrangedSubview(
                makeBankStack(bankDetails: recipient)
            )
        }
        
        scrollStackViewContainer.addArrangedSubview(
            makeLabelStack(topText: "Descrição", bottomText: dataToUse.description)
        )
        
        scrollStackViewContainer.addArrangedSubview(
            shareButton
        )
        
        shareButton.stopShimmeringAnimation()
        
        view.layoutIfNeeded()
        if dataToUse.id == dummyData.id {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                scrollStackViewContainer.arrangedSubviews.forEach { $0.startShimmeringAnimation() }
                scrollView.contentSize = scrollStackViewContainer.frame.size
                scrollView.layoutIfNeeded()
            }
        }
    }
    
    private func makeTitleStack(image: UIImage, text: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = Constants.defaultPadding / 4
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.heightAnchor.constraint(equalToConstant: ExtractDetailsConstants.imageSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: ExtractDetailsConstants.imageSize).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.text = text
        titleLabel.textColor = AppColors.textColorOnWhite
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.defaultPadding).isActive = true
        
        return stackView
    }
    
    private func makeLabelStack(topText: String, bottomText: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.defaultPadding / 6
        
        let topLabel = UILabel()
        topLabel.font = .systemFont(ofSize: 14)
        topLabel.text = topText
        topLabel.textColor = AppColors.textColorOnWhite
        
        let bottomLabel = UILabel()
        bottomLabel.font = .systemFont(ofSize: 16)
        bottomLabel.text = bottomText
        bottomLabel.textColor = AppColors.textColorOnWhite
        
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(bottomLabel)
        
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.defaultPadding * 2).isActive = true

        return stackView
    }
    
    private func makeBankStack(bankDetails: BankDetails, isSender: Bool = false) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.defaultPadding / 6
        
        let topLabel = UILabel()
        topLabel.font = .systemFont(ofSize: 14)
        topLabel.text = isSender ? "De" : "Para"
        topLabel.textColor = AppColors.textColorOnWhite
        
        let bigLabel = UILabel()
        bigLabel.font = .systemFont(ofSize: 16)
        bigLabel.text = bankDetails.name
        bigLabel.textColor = AppColors.textColorOnWhite
        
        let smallInfoStack = UIStackView()
        smallInfoStack.axis = .vertical
        smallInfoStack.spacing = .zero
        
        let smallInfoTexts = [
            "\(bankDetails.documentType) \(bankDetails.documentNumber)",
            bankDetails.bankName,
            "Agência \(bankDetails.agencyNumber) - Conta \(bankDetails.accountNumber)"
        ]
        
        smallInfoTexts.forEach { text in
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: 14)
            label.textColor = AppColors.textSecondaryColor
            smallInfoStack.addArrangedSubview(label)
        }
        
        stackView.addArrangedSubview(topLabel)
        stackView.addArrangedSubview(bigLabel)
        stackView.addArrangedSubview(smallInfoStack)
        
        stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.defaultPadding * 4.7).isActive = true

        return stackView
    }

}
