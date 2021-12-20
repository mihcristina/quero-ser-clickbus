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
    var pages = 1
    var movieFocused: Movie?

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrowView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies(page: 1)
        
        tableView.dataSource = self
        
        
        //chamada da definição da constraint
        tableView.rowHeight = 200
        tableView.estimatedRowHeight = 200
        
        //fundo navigation transparente
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
    }
    
    //chamada da API
    func getMovies(page: Int){
        MovieListWorker().fetchMovieList(
            section: .popular, page: page,
            sucess: { [self] response in
            guard let movieList = response?.results else { return }
            self.movies.append(contentsOf: movieList)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        },
        failure: { error in
            print(error!)
        })
    }
   
    
    
}


// adiciona dados na Tableview
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
    
    //programação da segue para passar valores entre viewcontroller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.movieFocused = movies[indexPath.row]

        performSegue(withIdentifier: "requestFocusedMovie", sender: (Any).self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieFocused {
            let cell = sender as! MovieCell
            vc.movie = cell.movie
            
        }
    }
}



