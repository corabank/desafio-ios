//
//  OrderDetailViewController.swift
//  cora
//
//  Created by Lucas Silveira on 18/04/21.
//

import UIKit

protocol OrderDetailViewcontrollerDelegate: class {
    func back()
}

class OrderDetailViewcontroller: UIViewController {
    weak var delegate: OrderDetailViewcontrollerDelegate?
    var viewModel: OrderDetailViewModel?
    
    // back button
    private var backButton: UIButton!
    
    // top
    private var paymentView: UIView!
    private var paymentImageView: UIImageView!
    private var paymentValueLabel: UILabel!
    private var paymentTypeLabel: UILabel!
    
    private var buyerView: UIView!
    private var buyerImageView: UIImageView!
    private var buyerLabel: UILabel!
    private var buyerNameLabel: UILabel!
    
    private var emailView: UIView!
    private var emailImageView: UIImageView!
    private var emailLabel: UILabel!
    private var emailValueLabel: UILabel!
    
    private var createdView: UIView!
    private var createdImageView: UIImageView!
    private var createdAtLabel: UILabel!
    private var createdAtValueLabel: UILabel!
    
    private var statusView: UIView!
    private var statusImageView: UIImageView!
    private var statusLabel: UILabel!
    private var statusLabelValue: UILabel!
    
    // resume
    private var resumeView: UIView!
    private var resumeLabel: UILabel!
    
    private var totalAmountLabel: UILabel!
    private var totalAmountValueLabel: UILabel!
    
    private var taxesLabel: UILabel!
    private var taxesValueLabel: UILabel!
    
    private var myReceiveLabel: UILabel!
    private var myReceiveValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeView()
        setConstraints()
        addTargets()
    }
    
    func makeBackButton() {
        backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("  Voltar", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backButton.setTitleColor(.systemPink, for: .normal)
        backButton.tintColor = .systemPink
        backButton.setImage(UIImage(named: "arrow.left"), for: .normal)
        view.addSubview(backButton)
    }
    
    func label(textColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), text: String = "", fontSize: CGFloat = 12,
               isBold: Bool = false) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = textColor
        label.text = text
        label.font = isBold ?
            UIFont.boldSystemFont(ofSize: fontSize) :
            UIFont.systemFont(ofSize: fontSize)
        return label
    }
    
    func imageView(named: String = "person", tintColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)) -> UIImageView {
        var imageView = UIImageView()
        imageView = UIImageView(image: UIImage(named: named)?
                                        .withRenderingMode(.automatic))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    func makeTopView() {
        // MARK: PAYMENT ITENS
        
        // paymentView
        paymentView = UIView()
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        
        // paymentImageView
        paymentImageView = imageView(named: "creditcard.circle.fill")
        paymentView.addSubview(paymentImageView)
        
        // paymentValueLabel
        paymentValueLabel = label(
            textColor: #colorLiteral(red: 0.1580600441, green: 0.1580889821, blue: 0.1580537558, alpha: 1),
            text: viewModel?.order.value.toCurrency ?? "",
            fontSize: 16,
            isBold: true)
        paymentView.addSubview(paymentValueLabel)
        
        // paymentTypeLabel
        paymentTypeLabel = label(textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1), text: "Cartão de Crédito", fontSize: 11)
        paymentView.addSubview(paymentTypeLabel)
        view.addSubview(paymentView)
        
        // buyerView
        buyerView = UIView()
        buyerView.translatesAutoresizingMaskIntoConstraints = false
        
        // buyerImageView
        buyerImageView = imageView(named: "person")
        buyerView.addSubview(buyerImageView)
        
        // buyerLabel
        buyerLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Comprador", fontSize: 10)
        buyerView.addSubview(buyerLabel)
        
        // buyerNameLabel
        buyerNameLabel = label(textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1), text: viewModel?.order.buyerName ?? "", fontSize: 12)
        buyerView.addSubview(buyerNameLabel)
        view.addSubview(buyerView)
        
        // emailView
        emailView = UIView()
        emailView.translatesAutoresizingMaskIntoConstraints = false
        
        // emailImageView
        emailImageView = imageView(named: "envelope")
        emailView.addSubview(emailImageView)
        
        // emailLabel
        emailLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Email", fontSize: 10)
        emailView.addSubview(emailLabel)
        
        // emailValueLabel
        emailValueLabel = label(textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1), text: viewModel?.order.buyerEmail ?? "", fontSize: 12)
        emailView.addSubview(emailValueLabel)
        view.addSubview(emailView)
        
        // createdView
        createdView = UIView()
        createdView.translatesAutoresizingMaskIntoConstraints = false
        
        // createdImageView
        createdImageView = imageView(named: "calendar")
        createdView.addSubview(createdImageView)
        
        // createdAtLabel
        createdAtLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Criado em", fontSize: 10)
        createdView.addSubview(createdAtLabel)
        
        // emailValueLabel
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateFormat = "dd/MM/YYYY"
        createdAtValueLabel = label(
            textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1),
            text: dateToStringFormatter.string(from: viewModel?.order.createdAt ?? Date()),
            fontSize: 12)
        createdView.addSubview(createdAtValueLabel)
        view.addSubview(createdView)
        
        // statusView
        statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        // statusImageView
        statusImageView = imageView(named: "timer")
        statusView.addSubview(statusImageView)
        
        // statusLabel
        statusLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Status", fontSize: 10)
        statusView.addSubview(statusLabel)
        
        // emailValueLabel
        var status = ""
        var color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switch viewModel?.order.status {
        case .late:
            status = "Não Pago"
            color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .paid:
            status = "Pago"
            color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .pending:
            status = "Aguardando"
            color = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        default: break
        }
        
        statusLabelValue = label(textColor: color, text: status, fontSize: 12)
        statusView.addSubview(statusLabelValue)
        view.addSubview(statusView)
    }
    
    var receive: Double {
        let value = viewModel?.order.value ?? 0
        let taxes = viewModel?.order.taxes ?? 0
        
        return value - taxes
    }
    
    func makeResumeView() {
        resumeView = UIView()
        resumeView.translatesAutoresizingMaskIntoConstraints = false
        resumeView.backgroundColor = #colorLiteral(red: 0.8349554539, green: 0.8430009484, blue: 0.8553692698, alpha: 1)
        
        resumeLabel = label(textColor: #colorLiteral(red: 0.6373602748, green: 0.6508322358, blue: 0.6629142165, alpha: 1), text: "Resumo Financeiro", fontSize: 10, isBold: true)
        resumeView.addSubview(resumeLabel)
        
        totalAmountLabel = label(textColor: #colorLiteral(red: 0.300034821, green: 0.3073332906, blue: 0.3257730603, alpha: 1), text: "Valor total", fontSize: 12)
        totalAmountValueLabel = label(textColor: #colorLiteral(red: 0.300034821, green: 0.3073332906, blue: 0.3257730603, alpha: 1),
                                      text: viewModel?.order.value.toCurrency ?? "",
                                      fontSize: 12)
        resumeView.addSubview(totalAmountLabel)
        resumeView.addSubview(totalAmountValueLabel)
        
        taxesLabel = label(textColor: #colorLiteral(red: 0.748716414, green: 0.1300586462, blue: 0.2132774293, alpha: 1), text: "Taxas", fontSize: 12)
        taxesValueLabel = label(textColor: #colorLiteral(red: 0.748716414, green: 0.1300586462, blue: 0.2132774293, alpha: 1), text: viewModel?.order.taxes.toCurrency ?? "", fontSize: 12)
        resumeView.addSubview(taxesLabel)
        resumeView.addSubview(taxesValueLabel)
        
        myReceiveLabel = label(textColor: #colorLiteral(red: 0.1344254017, green: 0.594214201, blue: 0.6358585954, alpha: 1), text: "Meu recebimento", fontSize: 13, isBold: true)
        myReceiveValueLabel = label(textColor: #colorLiteral(red: 0.1344254017, green: 0.594214201, blue: 0.6358585954, alpha: 1), text: receive.toCurrency, fontSize: 13, isBold: true)
        resumeView.addSubview(myReceiveLabel)
        resumeView.addSubview(myReceiveValueLabel)
        
        view.addSubview(resumeView)
    }
    
    func makeView() {
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.setNavigationBarHidden(true, animated: false)
        makeBackButton()
        makeTopView()
        makeResumeView()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            // back button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 20),
            
            // payment
            paymentView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            paymentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            paymentImageView.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 30),
            paymentImageView.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 17),
            paymentImageView.widthAnchor.constraint(equalToConstant: 40),
            paymentImageView.heightAnchor.constraint(equalToConstant: 40),
            
            paymentValueLabel.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 30),
            paymentValueLabel.leadingAnchor.constraint(equalTo: paymentImageView.trailingAnchor,
                                                       constant: 17),
            
            paymentTypeLabel.topAnchor.constraint(equalTo: paymentValueLabel.bottomAnchor, constant: 4),
            paymentTypeLabel.leadingAnchor.constraint(equalTo: paymentImageView.trailingAnchor, constant: 20),
            
            // buyer
            buyerView.topAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: 70),
            buyerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buyerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            buyerImageView.topAnchor.constraint(equalTo: buyerView.topAnchor, constant: 30),
            buyerImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            buyerImageView.widthAnchor.constraint(equalToConstant: 25),
            buyerImageView.heightAnchor.constraint(equalToConstant: 25),
            
            buyerLabel.topAnchor.constraint(equalTo: buyerView.topAnchor, constant: 27),
            buyerLabel.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: 27),
            
            buyerNameLabel.topAnchor.constraint(equalTo: buyerLabel.bottomAnchor, constant: 4),
            buyerNameLabel.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: 27),
            
            // email
            emailView.topAnchor.constraint(equalTo: buyerView.bottomAnchor, constant: 60),
            emailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            emailImageView.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 30),
            emailImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            emailImageView.widthAnchor.constraint(equalToConstant: 25),
            emailImageView.heightAnchor.constraint(equalToConstant: 25),
            
            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 27),
            emailLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 27),
            
            emailValueLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            emailValueLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 27),
            
            // createdAt
            createdView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 60),
            createdView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            createdView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            createdImageView.topAnchor.constraint(equalTo: createdView.topAnchor, constant: 30),
            createdImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            createdImageView.widthAnchor.constraint(equalToConstant: 25),
            createdImageView.heightAnchor.constraint(equalToConstant: 25),
            
            createdAtLabel.topAnchor.constraint(equalTo: createdView.topAnchor, constant: 27),
            createdAtLabel.leadingAnchor.constraint(equalTo: createdImageView.trailingAnchor, constant: 27),
            
            createdAtValueLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 4),
            createdAtValueLabel.leadingAnchor.constraint(equalTo: createdImageView.trailingAnchor,
                                                         constant: 27),
            
            // status
            statusView.topAnchor.constraint(equalTo: createdView.bottomAnchor, constant: 60),
            statusView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            statusImageView.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 30),
            statusImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: 25),
            statusImageView.heightAnchor.constraint(equalToConstant: 25),
            
            statusLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 27),
            statusLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 27),
            
            statusLabelValue.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            statusLabelValue.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor,
                                                      constant: 27),
            
            // resume
            resumeView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 100),
            resumeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resumeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resumeView.heightAnchor.constraint(equalToConstant: 200),
            
            resumeLabel.topAnchor.constraint(equalTo: resumeView.topAnchor, constant: 20),
            resumeLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20),
            
            // Left
            totalAmountLabel.topAnchor.constraint(equalTo: resumeLabel.bottomAnchor, constant: 20),
            totalAmountLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20),
            // Right
            totalAmountValueLabel.topAnchor.constraint(equalTo: resumeLabel.bottomAnchor, constant: 20),
            totalAmountValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor,
                                                            constant: -20),
            
            // Left
            taxesLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 20),
            taxesLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20),
            // Right
            taxesValueLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 20),
            taxesValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor, constant: -20),
            
            // Left
            myReceiveLabel.topAnchor.constraint(equalTo: taxesLabel.bottomAnchor, constant: 20),
            myReceiveLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20),
            // Right
            myReceiveValueLabel.topAnchor.constraint(equalTo: taxesLabel.bottomAnchor, constant: 20),
            myReceiveValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor, constant: -20)
        ])
    }
    
    func addTargets() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back() {
        delegate?.back()
    }
}
