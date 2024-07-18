import UIKit

class FDLoaderView: UIView {
    // MARK: - Properties
    private lazy var loader = UIActivityIndicatorView(style: .medium)
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoader() {
        loader.startAnimating()
    }
    
    func stopLoader() {
        loader.stopAnimating()
    }
}
    // MARK: - Extensions, private methods
private extension FDLoaderView {
    func setupLayout() {
        setupLoaderContainer()
        setupLoader()
    }
    
    func setupLoaderContainer() {
        self.backgroundColor = AppColors.shadowColor.withAlphaComponent(0.4)
    }
    
    func setupLoader() {
        addSubview(loader)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
