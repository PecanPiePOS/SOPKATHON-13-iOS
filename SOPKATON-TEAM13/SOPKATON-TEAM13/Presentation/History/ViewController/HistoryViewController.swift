//
//  HistoryViewController.swift
//  SOPKATON-TEAM13
//
//  Created by KimMinJoo on 2023/05/20.
//

import UIKit

import Then


import UIKit



final class HistoryViewController: UIViewController {
    
    // MARK: Initializing
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT: \(className)")
    }

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setLayout()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    // MARK: UI
    

    private let tableView = UITableView()
    
    private let dummy = HistoryData.dummy()
    
    func setStyle() {
        
        view.backgroundColor = .white
        
        tableView.do {
            $0.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
            $0.rowHeight = 69
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func setLayout() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Image.backBtn,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let title = "소음 고지서 목록"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: Color.gray8,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = NSAttributedString(string: title, attributes: attributes)
            navigationItem.titleView = titleLabel
        }
    }
    @objc
    func backButtonTapped() {
        let transition = CATransition().then {
            $0.duration = 0.25
            $0.type = .push
            $0.subtype = .fromLeft
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        }
        view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false)
        let mainViewController = MainViewController()
        self.navigationController?.pushViewController(mainViewController, animated: false)
    }
//    @objc
//        func goToNotice() {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
//            lazy var text = cell.dateLabel.text
//            let noticeVC = NoticeViewController()
//            noticeVC.text = text
//            self.navigationController?.pushViewController(noticeVC, animated: true)
//        }
}

extension HistoryViewController: UITableViewDelegate {}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return }
        
//        lazy var text = cell.dateLabel.text
        let noticeVC = NoticeViewController()
        print(indexPath.row)
        noticeVC.text = "\(indexPath.row)"
        self.navigationController?.pushViewController(noticeVC, animated: true)
    
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        
        cell.configureCell(dummy[indexPath.row])
        if indexPath.row == 0 {
            cell.thisweekLabel.isHidden = false
        }
        
        return cell
    }
}
