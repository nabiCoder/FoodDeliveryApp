import UIKit.UIView

extension UIView {
    func toggleVisibility(withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.isHidden.toggle()
        }
    }
    
    func animateTransition(duration: TimeInterval = 0.3,
                           options: UIView.AnimationOptions = .transitionCrossDissolve,
                           animations: @escaping () -> Void,
                           completion: ((Bool) -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: options,
                          animations: animations,
                          completion: completion)
    }
    
    func animateButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        }
        
    }
}
