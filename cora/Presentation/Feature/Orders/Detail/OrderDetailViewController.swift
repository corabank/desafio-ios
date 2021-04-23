//
//  OrderDetailViewController.swift
//  cora
//
//  Created by Lucas Silveira on 18/04/21.
//

import UIKit

//sourcery: AutoMockable
protocol OrderDetailViewcontrollerDelegate: class {
    func back(orderID: UUID)
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
        backButton.setTitle("", for: .normal)
        backButton.setImage(UIImage(named: "chevron.down"), for: .normal)
        backButton.tintColor = .systemPink
        view.addSubview(backButton)
    }
    
    func label(textColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), text: String = "", fontSize: CGFloat = 12.dp,
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
    
    // MARK: Make Top View
    
    func makeTopView() {
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
            fontSize: 12.dp,
            isBold: true)
        paymentView.addSubview(paymentValueLabel)
        
        // paymentTypeLabel
        paymentTypeLabel = label(textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1), text: "Cartão de Crédito", fontSize: 9.dp)
        paymentView.addSubview(paymentTypeLabel)
        view.addSubview(paymentView)
        
        // buyerView
        buyerView = UIView()
        buyerView.translatesAutoresizingMaskIntoConstraints = false

        // buyerImageView
        buyerImageView = imageView(named: "person.circle.fill")
        buyerView.addSubview(buyerImageView)

        // buyerLabel
        buyerLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Comprador", fontSize: 8.dp)
        buyerView.addSubview(buyerLabel)

        // buyerNameLabel
        buyerNameLabel = label(textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1), text: viewModel?.order.buyerName ?? "", fontSize: 10.dp)
        buyerView.addSubview(buyerNameLabel)
        view.addSubview(buyerView)

        // emailView
        emailView = UIView()
        emailView.translatesAutoresizingMaskIntoConstraints = false

        // emailImageView
        emailImageView = imageView(named: "envelope.circle.fill")
        emailView.addSubview(emailImageView)

        // emailLabel
        emailLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Email", fontSize: 8.dp)
        emailView.addSubview(emailLabel)

        // emailValueLabel
        emailValueLabel = label(textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1), text: viewModel?.order.buyerEmail ?? "", fontSize: 10.dp)
        emailView.addSubview(emailValueLabel)
        view.addSubview(emailView)

        // createdView
        createdView = UIView()
        createdView.translatesAutoresizingMaskIntoConstraints = false

        // createdImageView
        createdImageView = imageView(named: "calendar.circle.fill")
        createdView.addSubview(createdImageView)

        // createdAtLabel
        createdAtLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Criado em", fontSize: 8.dp)
        createdView.addSubview(createdAtLabel)

        // emailValueLabel
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateFormat = "dd/MM/YYYY"
        createdAtValueLabel = label(
            textColor: #colorLiteral(red: 0.4198806882, green: 0.4239129424, blue: 0.4195774794, alpha: 1),
            text: dateToStringFormatter.string(from: viewModel?.order.createdAt ?? Date()),
            fontSize: 10.dp)
        createdView.addSubview(createdAtValueLabel)
        view.addSubview(createdView)

        // statusView
        statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false

        // statusImageView
        statusImageView = imageView(named: "circle.lefthalf.fill")
        statusView.addSubview(statusImageView)

        // statusLabel
        statusLabel = label(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Status", fontSize: 8.dp)
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

        statusLabelValue = label(textColor: color, text: status, fontSize: 10.dp)
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
        
        resumeLabel = label(textColor: #colorLiteral(red: 0.6373602748, green: 0.6508322358, blue: 0.6629142165, alpha: 1), text: "Resumo Financeiro", fontSize: 10.dp, isBold: true)
        resumeView.addSubview(resumeLabel)
        
        totalAmountLabel = label(textColor: #colorLiteral(red: 0.300034821, green: 0.3073332906, blue: 0.3257730603, alpha: 1), text: "Valor total", fontSize: 12.dp)
        totalAmountValueLabel = label(textColor: #colorLiteral(red: 0.300034821, green: 0.3073332906, blue: 0.3257730603, alpha: 1),
                                      text: viewModel?.order.value.toCurrency ?? "",
                                      fontSize: 12.dp)
        resumeView.addSubview(totalAmountLabel)
        resumeView.addSubview(totalAmountValueLabel)
        
        taxesLabel = label(textColor: #colorLiteral(red: 0.748716414, green: 0.1300586462, blue: 0.2132774293, alpha: 1), text: "Taxas", fontSize: 12.dp)
        taxesValueLabel = label(textColor: #colorLiteral(red: 0.748716414, green: 0.1300586462, blue: 0.2132774293, alpha: 1), text: viewModel?.order.taxes.toCurrency ?? "", fontSize: 12.dp)
        resumeView.addSubview(taxesLabel)
        resumeView.addSubview(taxesValueLabel)
        
        myReceiveLabel = label(textColor: #colorLiteral(red: 0.1344254017, green: 0.594214201, blue: 0.6358585954, alpha: 1), text: "Meu recebimento", fontSize: 13.dp, isBold: true)
        myReceiveValueLabel = label(textColor: #colorLiteral(red: 0.1344254017, green: 0.594214201, blue: 0.6358585954, alpha: 1), text: receive.toCurrency, fontSize: 13.dp, isBold: true)
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
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.dp),
            backButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -20.dp),
            
            // payment
            paymentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.dp),
            paymentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            paymentImageView.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 2.dp),
            paymentImageView.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 17.dp),
            paymentImageView.widthAnchor.constraint(equalToConstant: 26.dp),
            paymentImageView.heightAnchor.constraint(equalToConstant: 26.dp),

            paymentValueLabel.topAnchor.constraint(equalTo: paymentView.topAnchor),
            paymentValueLabel.leadingAnchor.constraint(equalTo: paymentImageView.trailingAnchor,
                                                       constant: 17.dp),

            paymentTypeLabel.topAnchor.constraint(equalTo: paymentValueLabel.bottomAnchor, constant: 4.dp),
            paymentTypeLabel.leadingAnchor.constraint(equalTo: paymentImageView.trailingAnchor,
                                                      constant: 17.dp),

            // buyer
            buyerView.topAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: 26.dp),
            buyerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buyerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            buyerImageView.topAnchor.constraint(equalTo: buyerView.topAnchor, constant: 20.5.dp),
            buyerImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            buyerImageView.widthAnchor.constraint(equalToConstant: 26.dp),
            buyerImageView.heightAnchor.constraint(equalToConstant: 26.dp),

            buyerLabel.topAnchor.constraint(equalTo: buyerView.topAnchor, constant: 20.dp),
            buyerLabel.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: 17.dp),

            buyerNameLabel.topAnchor.constraint(equalTo: buyerLabel.bottomAnchor, constant: 4.dp),
            buyerNameLabel.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: 17.dp),

            // email
            emailView.topAnchor.constraint(equalTo: buyerView.bottomAnchor, constant: 42.dp),
            emailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            emailImageView.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 21.dp),
            emailImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            emailImageView.widthAnchor.constraint(equalToConstant: 26.dp),
            emailImageView.heightAnchor.constraint(equalToConstant: 26.dp),

            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 20.dp),
            emailLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 17.dp),

            emailValueLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4.dp),
            emailValueLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor,
                                                     constant: 17.dp),

            // createdAt
            createdView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 42.dp),
            createdView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            createdView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            createdImageView.topAnchor.constraint(equalTo: createdView.topAnchor, constant: 21.dp),
            createdImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            createdImageView.widthAnchor.constraint(equalToConstant: 26.dp),
            createdImageView.heightAnchor.constraint(equalToConstant: 26.dp),

            createdAtLabel.topAnchor.constraint(equalTo: createdView.topAnchor, constant: 20.dp),
            createdAtLabel.leadingAnchor.constraint(equalTo: createdImageView.trailingAnchor,
                                                    constant: 17.dp),

            createdAtValueLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 4.dp),
            createdAtValueLabel.leadingAnchor.constraint(equalTo: createdImageView.trailingAnchor,
                                                         constant: 17.dp),

            // status
            statusView.topAnchor.constraint(equalTo: createdView.bottomAnchor, constant: 42.dp),
            statusView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            statusImageView.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 21.dp),
            statusImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: 26.dp),
            statusImageView.heightAnchor.constraint(equalToConstant: 26.dp),

            statusLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 20.dp),
            statusLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 17.dp),

            statusLabelValue.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4.dp),
            statusLabelValue.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor,
                                                      constant: 17.dp),

            // resume
            resumeView.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 80.dp),
            resumeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resumeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resumeView.heightAnchor.constraint(equalToConstant: 130.dp),

            resumeLabel.topAnchor.constraint(equalTo: resumeView.topAnchor, constant: 10.dp),
            resumeLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),

            // Left
            totalAmountLabel.topAnchor.constraint(equalTo: resumeLabel.bottomAnchor, constant: 25.dp),
            totalAmountLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),
            // Right
            totalAmountValueLabel.topAnchor.constraint(equalTo: resumeLabel.bottomAnchor, constant: 25.dp),
            totalAmountValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor,
                                                            constant: -20.dp),

            // Left
            taxesLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 10.dp),
            taxesLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),
            // Right
            taxesValueLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 10.dp),
            taxesValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor, constant: -20.dp),

            // Left
            myReceiveLabel.topAnchor.constraint(equalTo: taxesLabel.bottomAnchor, constant: 10.dp),
            myReceiveLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),
            // Right
            myReceiveValueLabel.topAnchor.constraint(equalTo: taxesLabel.bottomAnchor, constant: 10.dp),
            myReceiveValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor,
                                                          constant: -20.dp)
        ])
    }
    
    func addTargets() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back() {
        delegate?.back(orderID: viewModel?.order.id ?? UUID())
    }
}
