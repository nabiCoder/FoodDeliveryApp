import UIKit

enum FieldType {
    case name
    case email
    case password
}
enum PasswordButtonState {
    case invisible
    case visible
}
enum CheckmarkState {
    case done
    case notDone
}

class FDTextField: UIView, UITextFieldDelegate {
    // MARK: - Properties
    private lazy var fieldLabel = UILabel()
    lazy var textField = UITextField()
    lazy var checkmarkImage = UIImageView()
    lazy var passwordVisibilityButton = UIButton()
    private lazy var textFieldShadow = UIView()
    
    private var fieldType: FieldType
    private var savedText: String?
    
    var action: (() -> Void)?
    
    var fieldLabelText: String {
        didSet { updateFildLabelText() }
    }
    
    // MARK: - Init
    init(fildType: FieldType, fieldLabelText: String) {
        self.fieldType = fildType
        self.fieldLabelText = fieldLabelText
        super.init(frame: .zero)
        
        setupLayout()
        updateFildLabelText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Action
    @objc private func buttonPressed() {
        guard let action = self.action else { return }
        action()
    }
}

// MARK: - Extensions, private methods
private extension FDTextField {
    func updateFildLabelText() {
        fieldLabel.text = fieldLabelText
    }
}
// MARK: - Extensions, setupLayout
private extension FDTextField {
    func setupLayout() {
        setupFieldLabel()
        setupTextField()
        setupAdditionalComponents()
    }
    
    func setupAdditionalComponents() {
        switch fieldType {
        case .name:
            setupCheckmark()
            textField.isSecureTextEntry = false
        case .email:
            setupCheckmark()
            textField.isSecureTextEntry = false
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
        case .password:
            setupPasswordButton()
            textField.textContentType = .password
            textField.keyboardType = .default
        }
        setupTextFieldShadow()
    }
    
    func setupFieldLabel() {
        addSubview(fieldLabel)
        
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        fieldLabel.textColor = AppColors.badyTextGreyColor
        fieldLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        fieldLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            fieldLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: -1),
            fieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fieldLabel.widthAnchor.constraint(equalToConstant: 148),
            fieldLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setupTextField() {
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.isSecureTextEntry = true
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: fieldLabel.bottomAnchor,
                                           constant: 8),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.widthAnchor.constraint(equalToConstant: 230),
            textField.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupCheckmark() {
        addSubview(checkmarkImage)
        
        checkmarkImage.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImage.image = UIImage(resource: .checkMark)
        checkmarkImage.tintColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            checkmarkImage.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            checkmarkImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            checkmarkImage.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupPasswordButton() {
        addSubview(passwordVisibilityButton)
        
        passwordVisibilityButton.translatesAutoresizingMaskIntoConstraints = false
        passwordVisibilityButton.tintColor = AppColors.badyTextGreyColor
        passwordVisibilityButton.addTarget(self,
                                       action: #selector(buttonPressed),
                                       for: .touchUpInside)
        passwordVisibilityButton.setImage(.invisible, for: .normal)
        
        NSLayoutConstraint.activate([
            passwordVisibilityButton.centerYAnchor.constraint(equalTo: fieldLabel.centerYAnchor),
            passwordVisibilityButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            passwordVisibilityButton.widthAnchor.constraint(equalToConstant: 24),
            passwordVisibilityButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupTextFieldShadow() {
        addSubview(textFieldShadow)
        
        textFieldShadow.translatesAutoresizingMaskIntoConstraints = false
        textFieldShadow.backgroundColor = AppColors.shadowColor.withAlphaComponent(100)
        
        NSLayoutConstraint.activate([
            textFieldShadow.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 9),
            textFieldShadow.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textFieldShadow.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textFieldShadow.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}


