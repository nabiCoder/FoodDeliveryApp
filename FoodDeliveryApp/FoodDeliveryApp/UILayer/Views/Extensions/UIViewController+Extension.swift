import UIKit.UIViewController

extension UIViewController {
    func setupNavBar() {
        let backImage = UIImage(resource: .back)
        
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
                                            
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.mainBlackColor
    }
}
