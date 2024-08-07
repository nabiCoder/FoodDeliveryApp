import UIKit

enum FDButtonTitle: String {
    case getStarted = "GET STARTED"
    case signIn = "SIGN IN"
    case resetPassword = "RESET PASSWORD"
    case sendAgain = "SEND AGAIN"
    case signUp = "SIGN UP"
    case continueTitle = "CONTINUE"
    case addCard = "ADD CARD"
    case applyFilters = "APPLY FILTERS"
    case changeSettings = "CHANGE SETTINGS"
    case changePassword = "CHANGE PASSWORD"
}

class FDButton: UIView {
    // MARK: - Properties
    lazy var button = UIButton()
    private var title: FDButtonTitle {
        didSet { updateButtonTitle() }
    }
    var action: (() -> Void)?
    // MARK: - Init
    init(titleType: FDButtonTitle) {
        self.title = titleType
        super.init(frame: .zero)
        setupLayout()
        updateButtonTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Action
    @objc private func buttonPressed() {
        animateButtonPress()
        guard let action = self.action else { return }
        action()
    }
}
    // MARK: - Extensions, private methods
private extension FDButton {
    func setupLayout() {
        setupButton()
    }
    
    func setupButton() {
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.activeOrangeColor
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        button.setTitleColor(AppColors.backgroundWhiteColor, for: .normal)
        button.addTarget(self,
                         action: #selector(buttonPressed),
                         for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func updateButtonTitle() {
        button.setTitle(title.rawValue, for: .normal)
    }
}
