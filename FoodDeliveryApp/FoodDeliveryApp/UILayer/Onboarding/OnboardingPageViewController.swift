import UIKit

// MARK: - OnboardingViewController
class OnboardingPageViewController: UIViewController {
    // MARK: - Properties
    weak var onboardingViewOutput: OnboardingViewOutput?
    let getStartedButton = UIButton()
    private var pages = [UIViewController]()
    private var currentPageIndex: Int = 0 {
        didSet { pageControl.currentPage = currentPageIndex - 1 }
    }
    private var isPageControlHidden: Bool = true {
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
        setupLayout()
    }
    
    private func nextViewController() {
        let vcs = self.pages
        let currentPage = self.currentPageIndex
        let nextPage = currentPage + 1
        
        if nextPage < vcs.count {
            let nextVC = vcs[nextPage]
            pageViewController.setViewControllers([nextVC],
                                                  direction: .forward,
                                                  animated: true)
            currentPageIndex += 1
        }
    }
    
    private func setPageControlHidden(isHidden: Bool) {
            pageControl.isHidden = isHidden
    }
}

// MARK: - Actions
private extension OnboardingPageViewController {
    @objc func getStartedButtonPressed() {
        setPageControlHidden(isHidden: false)
        nextViewController()
    }
}
// MARK: - Layout
private extension OnboardingPageViewController {
    func setupLayout() {
        setupPageViewController()
        setupPageControl()
        setupGetStartedButton()
    }
    
    func setupPageViewController() {
        guard let firstPagesVC = pages.first else { return }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.setViewControllers([firstPagesVC],
                                              direction: .forward,
                                              animated: true)
        pageViewController.view.backgroundColor = AppColors.backgroundWhiteColor
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setupPageControl() {
        pageControl.isHidden = true
        pageControl.numberOfPages = pages.count - 1
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = AppColors.greenColor
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.isUserInteractionEnabled = false
        
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -148)
        ])
    }
    
    func setupGetStartedButton() {
        view.addSubview(getStartedButton)
        
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.backgroundColor = AppColors.activeOrangeColor
        getStartedButton.layer.cornerRadius = 8
        getStartedButton.setTitle("GET STARTED", for: .normal)
        getStartedButton.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 14)
        getStartedButton.setTitleColor(AppColors.backgroundWhiteColor, for: .normal)
        getStartedButton.addTarget(self,
                                   action: #selector(getStartedButtonPressed),
                                   for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                     constant: -80),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.widthAnchor.constraint(equalToConstant: 335),
            getStartedButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
// MARK: - Extension OnboardingViewController
extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController), currentIndex < pages.count - 1 else { return nil }
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first,
              let index = pages.firstIndex(of: currentViewController) else {
            return
        }
        if completed && index >= 1 {
            currentPageIndex = index
            setPageControlHidden(isHidden: false)
        } else if index == 1 {
            setPageControlHidden(isHidden: true)
        }
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let pendingFirst = pendingViewControllers.first else { return }
        if let index = pages.firstIndex(of: pendingFirst) {
            if index == 0 {
                setPageControlHidden(isHidden: true)
            }
        }
    }
}
