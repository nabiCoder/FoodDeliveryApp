import UIKit

protocol FieldsProtocol: AnyObject {
    func activeNextField(tag: Int)
    func activePreviosField(tag: Int)
}

class FDCodeVerifyTextField: UITextField {
    // MARK: - Views
    private let shadowLineView = UIView()
    
    weak var fieldDelegate: FieldsProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func deleteBackward() {
        fieldDelegate?.activePreviosField(tag: tag)
    }
}
// MARK: - Extensions, private methods
private extension FDCodeVerifyTextField {
    func setupLayout() {
        setupTextField()
        setupShadowLineView()
    }
    
    func setupTextField() {
        backgroundColor = AppColors.backgroundWhiteColor
        tintColor = AppColors.greenColor
        textAlignment = .center
        delegate = self
    }
    
    func setupShadowLineView() {
        addSubview(shadowLineView)
        
        shadowLineView.translatesAutoresizingMaskIntoConstraints = false
        shadowLineView.backgroundColor = AppColors.badyTextGreyColor
        
        NSLayoutConstraint.activate([
            shadowLineView.topAnchor.constraint(equalTo: self.bottomAnchor),
            shadowLineView.widthAnchor.constraint(equalTo: self.widthAnchor),
            shadowLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
extension FDCodeVerifyTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, 
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        text = string
        
        if range.length == 0 {
            fieldDelegate?.activeNextField(tag: tag)
            resignFirstResponder()
        }
        return false
    }
}
