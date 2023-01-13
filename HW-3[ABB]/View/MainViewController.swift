import UIKit

class MainViewController: UIViewController {
    let queue = OperationQueue()
    var searchResults = [BookSearchResult]()
    var books: [Book] = []
    let searchBar = UISearchBar()
    let searchButton = SearcButton()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let resultTableView = UITableView()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search Book"
        loadBooks()
        setupActivityIndicator()
        setupSearchBar()
        setupSearchButton()
        setupResultTableView()
        setupResultLabel()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func loadBooks() {
    
        for i in 1...10 {
            let bookPath = Bundle.main.path(forResource: "book\(i)", ofType: "txt")!
            if let bookText = try? String(contentsOfFile: bookPath, encoding: .utf8) {
                let book = Book(id: i, name: "Book \(i)", text: bookText)
                self.books.append(book)
            }
        }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    private func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.color = .blue
    }
    
    private func setupResultTableView() {
        resultTableView.dataSource = self
        resultTableView.delegate = self
        view.addSubview(resultTableView)
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupResultLabel() {
        resultLabel.textAlignment = .center
        view.addSubview(resultLabel)
        resultLabel.text = "Search what you want"
    }
    
    @objc private func searchButtonTapped() {
            guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
                return
            }
            searchResults.removeAll()
            activityIndicator.startAnimating()
            for book in books {
                let operation = BookSearchOperation(searchTerm: searchTerm, bookText: book.text)
                operation.completionBlock = {
                    self.searchResults.append(BookSearchResult(name: book.name, occurrences: operation.occurrences))
                    if self.queue.operations.filter({!$0.isFinished}).count == 0{
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            self.updateUI()
                        }
                    }
                }
                queue.addOperation(operation)
            }
        }

    private func updateUI() {
        if searchResults.isEmpty {
            resultLabel.text = "No Results Found"
            resultLabel.isHidden = false
            resultTableView.isHidden = true
            activityIndicator.startAnimating()
        } else {
            resultLabel.isHidden = true
            resultTableView.isHidden = false
            resultTableView.reloadData()
        }
    }
}

    //MARK: - Extension MainViewController: UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchButtonTapped()
    }
}
    //MARK: - Extension MainViewController: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(searchResults[indexPath.row].name) (\(searchResults[indexPath.row].occurrences) occurrences)"
        return cell
    }
}
    //MARK: - Extension MainViewController: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
    }

    }



//MARK: - Extension MainViewController Constraints
extension MainViewController {
override func viewDidLayoutSubviews() {
   
    NSLayoutConstraint.activate([

        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
     
        searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
        searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        searchButton.heightAnchor.constraint(equalToConstant: 48),
        
        resultTableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 8),
        resultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        resultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        resultTableView.heightAnchor.constraint(equalToConstant: 400),
                
        activityIndicator.topAnchor.constraint(equalTo: resultTableView.bottomAnchor, constant: 20),
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
               
        resultLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8),
        resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
    ])
}
}

