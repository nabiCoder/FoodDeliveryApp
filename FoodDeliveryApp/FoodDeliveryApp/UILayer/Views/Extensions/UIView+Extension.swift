import UIKit.UIView

extension UIView {
    func toggleVisibility(withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.isHidden.toggle()
        }
    }
}
