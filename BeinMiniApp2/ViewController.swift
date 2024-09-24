//
//  ViewController.swift
//  BeinMiniApp2
//
//  Created by Batu Hayırlıoğlu on 10.09.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomTableViewCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var genreNames: [String] = []         // Array of genre names
    var filmsByGenre: [[Film]] = []       // Array of arrays for films categorized by genre
    var serviceManager: Service = Service()
    let videoUrl = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8" // Single video URL
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 350.0
        overrideUserInterfaceStyle = .dark
        tableView.delegate = self
        tableView.dataSource = self
        
        serviceManager.fetchData { [weak self] fetchedGenreNames, fetchedFilmsByGenre in
            guard let self = self else { return }
            
            self.genreNames = fetchedGenreNames
            self.filmsByGenre = fetchedFilmsByGenre
            
            // Reload the tableView after data is fetched
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        print(self.filmsByGenre)
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! CustomTableViewCell
        let genreName = genreNames[indexPath.row]
        let films = filmsByGenre[indexPath.row]
        cell.delegate = self
        
        cell.configure(with: genreName, films: films)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func didTapVideo(with film: Film) {
        performSegue(withIdentifier: "videoSegue", sender: film)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "videoSegue" {
            if let videoVC = segue.destination as? VideoPlayerController, let film = sender as? Film {
                videoVC.videoUrl = videoUrl
                videoVC.videoTitle = film.title
            } else {
                print("Error: videoURL or VideoPlayerController is nil.")
            }
        }
    }
}

    
