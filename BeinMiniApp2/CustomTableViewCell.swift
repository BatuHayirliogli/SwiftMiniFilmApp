//
//  CustomTableViewCell.swift
//  BeinMiniApp2
//
//  Created by Batu Hayırlıoğlu on 10.09.2024.
//

import UIKit


protocol CustomTableViewCellDelegate: AnyObject {
    func didTapVideo(with film: Film)
}



class CustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    weak var delegate: CustomTableViewCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    
    var films : [Film] = []
    var str : String = ""
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    
    func configure(with genreName: String, films: [Film]) {
        self.genreLabel.text = genreName
        self.films = films
        collectionView.reloadData() // Reload collection view with new films
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CustomCollectionViewCell
        let film = films[indexPath.row]
        if let url = URL(string: "http://image.tmdb.org/t/p/w185/" + film.posterPath!) {
            cell.imageView.loadImage(from: url)
        }
        cell.backgroundColor = .blue
        cell.nameLabel.text = film.title
        cell.layer.cornerRadius = 14.0
        cell.nameLabel.layer.cornerRadius = 200
        
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFilm = films[indexPath.row]
        delegate?.didTapVideo(with: selectedFilm)

        }
        
    
    
    
}
