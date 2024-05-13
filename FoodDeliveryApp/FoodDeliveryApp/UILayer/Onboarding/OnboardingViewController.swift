import UIKit

// MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
    // MARK: - Properties
    private var pages = [UIViewController]()
    weak var onboardingViewOutput: OnboardingViewOutput?
    // MARK: - Views
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                               navigationOrientation: .horizontal)
    private lazy var pageControl = UIPageControl()
    
    init(pages: [UIViewController] = [UIViewController](), 
         onboardingViewOutput: OnboardingViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.pages = pages
        self.onboardingViewOutput = onboardingViewOutput
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupPageControl()
    }
}
// MARK: - Layout
private extension OnboardingViewController {
    func setupPageViewController() {
        guard let firstPagesVC = pages.first else { return }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.setViewControllers([firstPagesVC], direction: .forward, animated: true)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}
// MARK: - Extension OnboardingViewController
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController),
                currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController),
                currentIndex < pages.count - 1 else { return nil }
        return pages[currentIndex + 1]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, 
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pendingFirst = pendingViewControllers.first else { return }
        if let index = pages.firstIndex(of: pendingFirst) {
            pageControl.currentPage = index
        }
    }
}
