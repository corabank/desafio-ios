import UIKit

protocol HomeDisplaying: AnyObject {
    func displaySomething()
}

private extension HomeViewController.Layout {
    // example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class HomeViewController: UIViewController {
    fileprivate enum Layout { 
        // template
    }
    private lazy var imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundLogin")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 140
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var imageLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coraLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var homeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Conta Digital PJ\nPoderosamente simples"
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var homeSubtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua empresa livre burocracias e de taxas para gerar boletos, fazer transferências e pagamentos."
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Quero fazer parte!", for: [])
        button.setTitleColor(UIColor(named: "background"), for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Já sou cliente", for: [])
        button.setTitleColor(.white, for: [])
        button.layer.cornerRadius = 16
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.doSomething()
        buildView()
    }
    
    private let interactor: HomeInteracting
        
        init(interactor: HomeInteracting) {
            self.interactor = interactor
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

extension HomeViewController: ViewSetup {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: view.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackground.heightAnchor.constraint(equalToConstant: 340.0)
        ])
        
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageLogo.heightAnchor.constraint(equalToConstant: 24.0)
        ])
        
        NSLayoutConstraint.activate([
            homeTitle.topAnchor.constraint(equalTo: imageBackground.bottomAnchor, constant: 16),
            homeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            homeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            homeSubtitle.topAnchor.constraint(equalTo: homeTitle.bottomAnchor, constant: 16),
            homeSubtitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            homeSubtitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: homeSubtitle.bottomAnchor, constant: 24),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 64.0)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 64.0)
        ])
    }
    
    func setupHierarchy() {
        view.addSubview(imageBackground)
        view.addSubview(imageLogo)
        view.addSubview(homeTitle)
        view.addSubview(homeSubtitle)
        view.addSubview(signUpButton)
        view.addSubview(loginButton)
    }
    
    func setupStyles() {
        view.backgroundColor = UIColor(named: "background")
    }
}

// MARK: - HomeDisplaying
extension HomeViewController: HomeDisplaying {
    func displaySomething() { 
        // template
    }
}
