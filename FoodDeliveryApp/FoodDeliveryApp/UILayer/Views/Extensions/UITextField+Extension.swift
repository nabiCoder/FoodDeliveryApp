import UIKit.UITextField

extension UITextField {
    func shakeWithColorChange(duration: CFTimeInterval = 0.7,
                              repeatCount: Float = 2,
                              amplitude: CGFloat = 3,
                              color: UIColor = AppColors.badyTextGreyColor) {
            // Анимация потряхивания
            let positionAnimation = CABasicAnimation(keyPath: "position")
            positionAnimation.duration = duration / TimeInterval(repeatCount)
            positionAnimation.repeatCount = repeatCount
            positionAnimation.autoreverses = true
            positionAnimation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - amplitude, y: self.center.y))
            positionAnimation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + amplitude, y: self.center.y))
            
            // Анимация изменения цвета
            let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
            colorAnimation.duration = duration / TimeInterval(repeatCount)
            colorAnimation.repeatCount = repeatCount
            colorAnimation.autoreverses = true
            colorAnimation.fromValue = self.backgroundColor?.cgColor
            colorAnimation.toValue = color.cgColor
            
            // Группа анимаций
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [positionAnimation, colorAnimation]
            animationGroup.duration = duration
            self.layer.add(animationGroup, forKey: "shakeWithColorChange")
        }
}
