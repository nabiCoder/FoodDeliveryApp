import UIKit

class PopUpView: UIView {
    private let tableView = UITableView()
    private var data = [CountryCodes]()
    
    init(data: [CountryCodes]) {
        super.init(frame: .zero)
        self.data = data
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupTableView() {
        addSubview(tableView)
        
        tableView.register(PopUpCell.self, forCellReuseIdentifier: PopUpCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
extension PopUpView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension PopUpView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PopUpCell.identifier,
                                                       for: indexPath) as? PopUpCell else { return UITableViewCell()}
        cell.configure(with: data[indexPath.row])
        
        return cell
    }
}
