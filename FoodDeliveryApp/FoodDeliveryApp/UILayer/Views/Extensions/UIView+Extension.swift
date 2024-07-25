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
}
