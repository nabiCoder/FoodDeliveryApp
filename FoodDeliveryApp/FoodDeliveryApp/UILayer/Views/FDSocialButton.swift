import UIKit

enum FDSocialLoginButtonType: String {
    case facebook
    case google
}

class FDSocialButton: UIView {
    // MARK: - Properties
    private let button = UIButton()
    private let imageView = UIImageView()
    private var type: FDSocialLoginButtonType
    var action: (() -> Void)?
    // MARK: - Init
    init(type: FDSocialLoginButtonType) {
        self.type = type
        super.init(frame: .zero)
        setupLayout()
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
private extension FDSocialButton {
    func setupLayout() {
        setupButton()
        setupImageView()
        setupAppearance()
    }
    
    func setupAppearance() {
        switch type {
            
        case .facebook:
            button.backgroundColor = AppColors.facbookColor
            button.setTitle("CONNECT WITH FACEBOOK", for: .normal)
            imageView.image = UIImage(resource: .facebook)
        case .google:
            button.backgroundColor = AppColors.googleColor
            button.setTitle("CONNECT WITH GOOGLE", for: .normal)
            imageView.image = UIImage(resource: .google)
        }
    }
    
    func setupButton() {
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 12)
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
    
    func setupImageView() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = AppColors.backgroundWhiteColor
        imageView.layer.cornerRadius = 4
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
}
