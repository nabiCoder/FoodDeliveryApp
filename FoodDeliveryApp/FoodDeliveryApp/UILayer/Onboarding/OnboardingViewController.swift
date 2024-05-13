import UIKit

// MARK: - OnboardingViewController
class OnboardingViewController: UIViewController {
    // MARK: - Properties
    weak var onboardingViewOutput: OnboardingViewOutput?
    private var pages = [UIViewController]()
    private var currentPageIndex: Int = 0 {
        didSet { pageControl.currentPage = currentPageIndex }
    }
    var isPageControlHidden: Bool = true {
        didSet { pageControl.isHidden = isPageControlHidden }
    }
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
        pageControl.isHidden = true
        pageControl.numberOfPages = pages.count - 1
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
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: currentViewController) else {
            pageControl.isHidden = true
            return
        }
        if completed && index >= 1 {
            currentPageIndex = index - 1
            pageControl.isHidden = false
        } else if index == 1 {
            pageControl.isHidden = false
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pendingFirst = pendingViewControllers.first else { return }
        if let index = pages.firstIndex(of: pendingFirst) {
            if index == 0 {
                pageControl.isHidden = true
            }
        }
    }
}
