//
//  ViewController.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    
    let movieApi = MovieAPI()
    var movies = [Movie]()
    let pages = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cell: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovies(page: pages)

        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.estimatedRowHeight = 200
    }
    
    func getMovies(page:Int){
        MovieListWorker().fetchMovieList(
            section: .popular, page: 1,
            sucess: { [self] response in
                guard let movie = response?.results else { return }

                self.movies.append(contentsOf: movie)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            failure: { error in
                print(error!)
            })
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        cell.configCell(movie: movies[indexPath.row])

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

