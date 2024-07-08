import UIKit

class KeyboardHandling: KeyboardDismissViewController {
    var isKeyboardShow = false
    var bottomCTValue: CGFloat = 0.0
    var signUpButtonButtonCT: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
    }

    func setupObservers() {
        startKeyboardListener()
    }

    private func startKeyboardListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }

        let keyboardHeight = keyboardFrame.cgRectValue.height

        if !isKeyboardShow {
            UIView.animate(withDuration: 0.3) {
                self.signUpButtonButtonCT.constant -= keyboardHeight
                self.view.layoutIfNeeded()
                self.isKeyboardShow = true
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShow {
            UIView.animate(withDuration: 0.3) {
                self.signUpButtonButtonCT.constant = self.bottomCTValue
                self.view.layoutIfNeeded()
                self.isKeyboardShow = false
            }
        }
    }
}
