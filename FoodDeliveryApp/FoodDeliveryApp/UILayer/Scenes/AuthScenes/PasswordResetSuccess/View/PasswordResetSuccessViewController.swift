import UIKit

class PasswordResetSuccessViewController: UIViewController {
    // MARK: - Views
    private let navigationTitle = "Forgot Password"
    private let mainLabel = UILabel()
    private let subLabel = UILabel()
    private let sendAgainButton = FDButton(titleType: .sendAgain)
    private let logoImage = UIImageView()
    // MARK: - Properties
    private var passwordResetSuccessViewOutput: PasswordResetSuccessViewOutput?
    private var email: String
    // MARK: - Init
    init(email: String, PRSViewOutput: PasswordResetSuccessViewOutput) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
        self.passwordResetSuccessViewOutput = PRSViewOutput
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavBar()
    }
    // MARK: - @objc
    @objc private func sendAgainButtonTapped() {
        print("send Again Button Tapped")
    }
}
// MARK: - Extension methods
private extension PasswordResetSuccessViewController {
    func setupLayout() {
        setupView()
        setupNavigationController()
        setupMainLabel()
        setupSubLabel()
        setupSendAgainButton()
        setupLogoImage()
    }
    
    func setupView() {
        view.backgroundColor = AppColors.inputWhiteColor
    }
    
    func setupNavigationController() {
        title = navigationTitle
    }
    
    func setupMainLabel() {
        view.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = "Reset email sent"
        mainLabel.textAlignment = .left
        mainLabel.font = UIFont(name: "AvenirNext-Regular", size: 34)
        mainLabel.textColor = AppColors.mainBlackColor
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 118),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            mainLabel.widthAnchor.constraint(equalToConstant: 263),
            mainLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupSubLabel() {
        view.addSubview(subLabel)
        
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.text = "We have sent a instructions email to\n\(email)."
        subLabel.numberOfLines = 2
        subLabel.textAlignment = .left
        subLabel.font = UIFont(name: "AvenirNext-Regular", size: 16)
        subLabel.textColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 12),
            subLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            subLabel.widthAnchor.constraint(equalToConstant: 280),
            subLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupSendAgainButton() {
        view.addSubview(sendAgainButton)
        
        sendAgainButton.translatesAutoresizingMaskIntoConstraints = false
        sendAgainButton.action = sendAgainButtonTapped
        
        NSLayoutConstraint.activate([
            sendAgainButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 24),
            sendAgainButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendAgainButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendAgainButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupLogoImage() {
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(resource: .cofeeMan)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: sendAgainButton.bottomAnchor, constant: 123),
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            logoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            logoImage.heightAnchor.constraint(equalToConstant: 237)
        ])
    }
}
