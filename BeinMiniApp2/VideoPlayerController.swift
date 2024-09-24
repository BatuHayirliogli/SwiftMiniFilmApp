//
//  VideoPlayerController.swift
//  BeinMiniApp2
//
//  Created by Batu Hayırlıoğlu on 19.09.2024.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerController: UIViewController {
    
    var videoUrl: String?
    var videoTitle: String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        overrideUserInterfaceStyle = .dark
            
        if let urlString = videoUrl, let url = URL(string: urlString) {
                
            let player = AVPlayer(url: url)
            let playerController = AVPlayerViewController()
            playerController.player = player
            
            let nameLabel = UILabel()
            nameLabel.text = videoTitle ?? "Unknown Title"
            nameLabel.textColor = .white
            nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            playerController.contentOverlayView?.addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                            nameLabel.topAnchor.constraint(equalTo: playerController.contentOverlayView!.topAnchor, constant: 300),
                            nameLabel.leadingAnchor.constraint(equalTo: playerController.contentOverlayView!.leadingAnchor, constant: 20)
                        ])
            
            player.play()
        
            present(playerController, animated: true, completion: nil)
        }
    }
}
