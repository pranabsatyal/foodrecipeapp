//
//  ViewController.swift
//  Food Recipe
//
//  Created by Pranab Raj Satyal on 5/4/21.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {
    
    var recipeURLArray = [Recipe]()
    let searchController = UISearchController()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Find Dish"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        view.addSubview(tableView)
        
    }
    
    override func viewDidLayoutSubviews() {
        addTableViewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func addTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeURLArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = recipeURLArray[indexPath.row].recipe.label
        cell.detailTextLabel?.text = "Source: \(recipeURLArray[indexPath.row].recipe.source)"
        cell.myImageView.load(url: URL(string: recipeURLArray[indexPath.row].recipe.image)!)
        
        let healthLabels: [String] = recipeURLArray[indexPath.row].recipe.healthLabels
        
        var healthFacts = ""
        
        for i in healthLabels {
            healthFacts += i + ", "
        }
        
        cell.healthLabel.text = "Health Facts: \(healthFacts)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlString = recipeURLArray[indexPath.row].recipe.url
        let pageURL = URL(string: urlString)!
        let safariView = SFSafariViewController(url: pageURL)
        present(safariView, animated: true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        APICall.shared.dishName = searchBar.text!
        
        searchBar.text = ""
        
        APICall.shared.apiCalls { (recipe, error) in
            if error != nil {
                self.showAlert()
            }
            
            if let recipe = recipe {
                self.recipeURLArray = recipe
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
        searchController.dismiss(animated: true, completion: nil)
        
    }
  
    func showAlert() {
        let alert = UIAlertController(title: "Recipe Not Found", message: "Please try again with a different recipe name", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
