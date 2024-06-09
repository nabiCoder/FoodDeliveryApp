import UIKit

enum FlagType {
    case rus
    case usa
    case kz
}

class FDPhoneNumberTextField: UIView {
    // MARK: - Properties
    private lazy var fieldLabel = UILabel()
    private lazy var flagImage = UIImageView()
    private lazy var selectCountryButton = UIButton()
    private lazy var textField = UITextField()
    private lazy var textFieldShadow = UIView()
    
    private var flagType: FlagType
    private let countryCode = "+7"
    private let maxCharacters = 16
    
    var action: (() -> Void)?
    
    // MARK: - Init
    init(flagType: FlagType) {
        self.flagType = flagType
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        textField.becomeFirstResponder()
    }
    // MARK: - Action
    @objc private func buttonPressed() {
        guard let action = self.action else { return }
        action()
    }
}
// MARK: - Extensions, setupLayout
private extension FDPhoneNumberTextField {
    func setupLayout() {
        setupFieldLabel()
        setupFlagImage()
        setupSelectCountryButton()
        setupTextField()
        setupTextFieldShadow()
        setupAdditionalComponents()
    }
    
    func setupAdditionalComponents() {
        switch flagType {
            
        case .rus:
            flagImage.image = UIImage(resource: .RU)
            textField.text = "+7"
        case .usa:
            flagImage.image = UIImage(resource: .US)
            textField.text = "+1"
        case .kz:
            flagImage.image = UIImage(resource: .KZ)
            textField.text = "+76"
        }
    }
    
    func setupFieldLabel() {
        addSubview(fieldLabel)
        
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        fieldLabel.textColor = AppColors.badyTextGreyColor
        fieldLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        fieldLabel.textAlignment = .left
        fieldLabel.text = "PHONE NUMBER"
        
        NSLayoutConstraint.activate([
            fieldLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                            constant: -1),
            fieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fieldLabel.widthAnchor.constraint(equalToConstant: 148),
            fieldLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func setupFlagImage() {
        addSubview(flagImage)
        
        flagImage.translatesAutoresizingMaskIntoConstraints = false
        flagImage.image = UIImage(resource: .RU)
        
        NSLayoutConstraint.activate([
            flagImage.topAnchor.constraint(equalTo: fieldLabel.bottomAnchor, constant: 7),
            flagImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            flagImage.widthAnchor.constraint(equalToConstant: 32),
            flagImage.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupSelectCountryButton() {
        addSubview(selectCountryButton)
        
        selectCountryButton.translatesAutoresizingMaskIntoConstraints = false
        selectCountryButton.addTarget(self,
                                       action: #selector(buttonPressed),
                                       for: .touchUpInside)
        selectCountryButton.setImage(.path, for: .normal)
        
        NSLayoutConstraint.activate([
            selectCountryButton.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
            selectCountryButton.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 2),
            selectCountryButton.widthAnchor.constraint(equalToConstant: 12),
            selectCountryButton.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    func setupTextField() {
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: selectCountryButton.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: selectCountryButton.trailingAnchor, constant: 12),
            textField.widthAnchor.constraint(equalToConstant: 230),
            textField.heightAnchor.constraint(equalToConstant: 24)
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
// MARK: - Extensions, UITextFieldDelegate
extension FDPhoneNumberTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }

        guard let stringRange = Range(range, in: text) else { return false }
                
        let updatedText = text.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count < countryCode.count { return false }
        if updatedText.count > maxCharacters { return false }
        
        textField.text = text.applyPatternOnNumbers(pattern: "+#(###) ###-####", replacementCharacter: "#")
        
        return true
    }
}
