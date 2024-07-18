import UIKit

class KeyboardDismissViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
    }
    
    deinit {
        stopKeyboardListener()
    }
    
    private func setupObservers() {
        startKeyboardListener()
    }
    
    private func startKeyboardListener() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func stopKeyboardListener() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
