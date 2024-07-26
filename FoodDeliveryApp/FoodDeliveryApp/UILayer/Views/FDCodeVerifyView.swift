import UIKit

protocol VerifyProtocol: AnyObject {
    func verify()
}

class FDCodeVerifyView: UIView {
    // MARK: - Views
    private let codeStackView  = UIStackView()
    private var codeTextFields = [FDCodeVerifyTextField]()
    
    weak var verifyDelegate: VerifyProtocol?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCode(_ code: String) {
        let characters = Array(code)
        for (index, textField) in codeTextFields.enumerated() {
            textField.text = index < characters.count ? String(characters[index]) : ""
        }
    }
}
// MARK: - Extensions, private methods
private extension FDCodeVerifyView {
    func setupLayout() {
        codeTextFieldConfiguration()
    }
    
    func codeTextFieldConfiguration() {
        addSubview(codeStackView)
        
        codeStackView.translatesAutoresizingMaskIntoConstraints = false
        codeStackView.spacing = 20
        codeStackView.distribution = .fillEqually
        
        for i in 0...3 {
            let codeTextField = FDCodeVerifyTextField()
            codeTextField.tag = i
            codeTextField.fieldDelegate = self
            codeTextFields.append(codeTextField)
            codeStackView.addArrangedSubview(codeTextField)
        }
        
        codeTextFields[0].becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            codeStackView.topAnchor.constraint(equalTo: self.topAnchor),
            codeStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            codeStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
extension FDCodeVerifyView: FieldsProtocol {
    func activeNextField(tag: Int) {
        if tag != codeTextFields.count - 1 {
            codeTextFields[tag + 1].becomeFirstResponder()
        } else {
            verifyDelegate?.verify()
        }
    }
    
    func activePreviosField(tag: Int) {
        if tag != 0 {
            codeTextFields[tag - 1].text = ""
            codeTextFields[tag - 1].becomeFirstResponder()
        }
    }
}
