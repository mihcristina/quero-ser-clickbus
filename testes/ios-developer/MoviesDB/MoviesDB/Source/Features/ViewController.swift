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
        
    
        // EXEMPLO DE COMO OBTER OS DETALHES DE UM FILME
        
        MovieDetailsWorker().fetchMovieDetails(
            of: 497582, // COLOQUE O ID DO FILME AQUI
            sucess: { details in
                guard let details = details else { return }
                print(details)
            },
            failure: { error in
                print(error!)
            })
        
        
        // EXEMPLO DE COMO OBTER A LISTA GÊNEROS
        
        GenreListWorker().fetchGenreList(
            sucess: { response in
                guard let genres = response?.genres else { return }
                print(genres)
            },
            failure: { error in
                print(error!)
            })
    }
    
    func getMovies(page:Int){
        MovieListWorker().fetchMovieList(
            section: .popular, page: 1,
            sucess: { [self] response in
                guard let movie = response?.results else { return }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as! MovieCell
        cell.configCell(movie: movies[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

