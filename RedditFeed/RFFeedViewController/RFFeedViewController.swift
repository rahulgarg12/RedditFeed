//
//  RFFeedViewController.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit
import Combine

final class RFFeedViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.keyboardDismissMode = .onDrag
            
            tableView.register(cellType: RFFeedCell.self)
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.prefetchDataSource = self
        }
    }
    @IBOutlet weak var searchView: RFSearchFooterView!
    @IBOutlet weak var searchFooterBottomConstraint: NSLayoutConstraint!
    
    //MARK: Properties
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 300)
        return spinner
    }()
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = UIViewTitles.Feed.searchPlaceholder
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.delegate = self
//        searchController.hidesNavigationBarDuringPresentation = true
//        searchController.obscuresBackgroundDuringPresentation = false
       return searchController
    }()
    
    private var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    private lazy var cancellables = Set<AnyCancellable>()
    
    var viewModel: RFFeedViewModel!
    
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBindings()
        
        showSpinner()
        fetchData()
        
        setNavigationBar()
        addKeyboardObservers()
    }
    
    
    //MARK: Helper Methods
    private func setNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        title = UIViewTitles.Feed.headingTitle
    }
    
    private func initBindings() {
        viewModel.$feed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] response in
                if let results = response?.data?.children {
                    if !results.isEmpty {
                        let prevResultCount = self?.viewModel.data.count ?? 0
                        for result in results {
                            guard let children = result.data else { continue }
                            
                            self?.viewModel.data.append(children)
                        }
                        let newResultCount = self?.viewModel.data.count ?? 0

                        if newResultCount > prevResultCount {
                            var indexPaths = [IndexPath]()
                            for count in prevResultCount..<newResultCount {
                                indexPaths.append(IndexPath(row: count, section: 0))
                            }

                            self?.tableView.insertRows(at: indexPaths, with: .fade)
                        }
                        
                        self?.viewModel.isLastPageReached = false
                    } else {
                        self?.viewModel.isLastPageReached = true
                    }
                }
            }.store(in: &cancellables)
        
        
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
            .map( { ($0.object as? UITextField)?.text ?? "" } )
            .sink { [weak self] string in
                self?.viewModel.filterContentForSearchText(string)
                self?.tableView.reloadData()
                
                if let filteredData = self?.viewModel.filteredData, filteredData.isEmpty {
                    self?.tableView.setEmptyMessage("Search returns no data")
                } else {
                    self?.tableView.removeEmptyMessage()
                }
            }
            .store(in: &cancellables)
    }
    
    func showSpinner() {
        spinner.startAnimating()
        view.addSubview(spinner)
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    
    //MARK: Network Handlers
    func fetchData(isRemovePrevious: Bool = false) {
        viewModel.isAPIInProgress = true
        
        viewModel.fetchData()
            .receive(on: DispatchQueue.main)
            .mapError { [weak self] error -> Error in
                self?.viewModel.isAPIInProgress = false
                self?.stopSpinner()
                
                let alert = UIAlertController.getAlert(title: error.localizedDescription, message: nil)
                self?.present(alert, animated: true, completion: nil)
                return error
            }
            .sink(receiveCompletion: { _ in }) { [weak self] response in
                if isRemovePrevious {
                    self?.viewModel.data.removeAll()
                    self?.tableView.reloadData()
                }
                
                self?.viewModel.isAPIInProgress = false
                if let after = response.data?.after, !after.isEmpty {
                    self?.viewModel.pageAfter = after
                }
                
                self?.viewModel.feed = response

                self?.stopSpinner()
            }
            .store(in: &cancellables)
    }
}


//MARK:- UITableViewDelegate, UITableViewDataSource
extension RFFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let text = searchBar.text, text.isEmpty {
            searchView.setNotFiltering()
            return viewModel.data.count
        } else {
            searchView.setIsFilteringToShow(filteredItemCount: viewModel.filteredData.count, of: viewModel.data.count)
            return viewModel.filteredData.count
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let text = searchBar.text, text.isEmpty {
            guard viewModel.isFetchMore(at: indexPath) else { return }
            
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: RFFeedCell.self, for: indexPath)
        
        let data: [RFChildrenDataModel]
        if let text = searchBar.text, text.isEmpty {
            data = viewModel.data
        } else {
            data = viewModel.filteredData
        }
        
        if data.count > indexPath.row {
            cell.object = data[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data: [RFChildrenDataModel]
        if let text = searchBar.text, text.isEmpty {
            data = viewModel.data
        } else {
            data = viewModel.filteredData
        }
        
        guard data.count > indexPath.row else { return }
        
        let vc = RFDetailsViewController.loadFromNib()
        vc.viewModel = RFDetailsViewModel(model: data[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- UITableViewDataSourcePrefetching
extension RFFeedViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let data: [RFChildrenDataModel]
        if let text = searchBar.text, text.isEmpty {
            data = viewModel.data
        } else {
            data = viewModel.filteredData
        }
        
        viewModel.prefetchImages(at: indexPaths, data: data)
    }
}


//MARK:- UISearchBarDelegate
extension RFFeedViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filterContentForSearchText("")
        tableView.reloadData()
    }
}


//MARK:- KeyboardHandler
extension RFFeedViewController: KeyboardHandler {
    func keyboardWillShow(withSize size: CGSize) {
        searchFooterBottomConstraint.constant = -(size.height - safeAreaBottom)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: size.height + searchView.bounds.height, right: 0)
    }
    
    func keyboardWillHide() {
        searchFooterBottomConstraint.constant = 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: searchView.bounds.height, right: 0)
    }
}
