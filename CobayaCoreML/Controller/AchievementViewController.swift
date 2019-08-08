//
//  AchievementViewController.swift
//  CobayaCoreML
//
//  Created by keenan warouw on 10/06/19.
//  Copyright © 2019 Keenan Warouw. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {
    @IBOutlet weak var achCollectionView: UICollectionView!
    @IBOutlet weak var achImage: UIImageView!
    @IBOutlet weak var achLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var achievementProgress: UIProgressView!
    @IBOutlet weak var AchievementNumbers: UILabel!
    
    var images = [#imageLiteral(resourceName: "apple-3"), #imageLiteral(resourceName: "loupe"), #imageLiteral(resourceName: "sprout"), #imageLiteral(resourceName: "wheat"), #imageLiteral(resourceName: "orange-tree"), #imageLiteral(resourceName: "evil"), #imageLiteral(resourceName: "apelInactive"), #imageLiteral(resourceName: "small button jeruk revisi"), #imageLiteral(resourceName: "tomatoInactive"), #imageLiteral(resourceName: "mathematician"), #imageLiteral(resourceName: "gaming-2"), #imageLiteral(resourceName: "open-book")]
    var names = ["An Apple a day",
        "First Scan",
        "Novice Scanner",
        "Frequent Scanner",
        "Master Scanner",
        "Mischievous Scanner",
        "Apple Lover",
        "Orange Lover",
        "Tomato Lover",
        "Fruit Scientist",
        "Lucky Scanner",
        "Still Learning"]
    var statuses = [true,true,false,true,true,true,true,true,true,true,true,true]
    var descs = ["Reward for scanning an apple a day for a week!",
        "Reward for scanning the first time!",
        "Reward for scanning 100 times!",
        "Reward for scanning 1.000 times!",
        "Reward for scanning 10.000 times!",
        "Reward for scanning a non-fruit object 1.000 times!",
        "Reward for scanning 1.000 apples!",
        "Reward for scanning 1.000 oranges!",
        "Reward for scanning 1.000 tomatoes!",
        "Reward for scanning each fruit 1.000 times!",
        "Reward for being lucky!",
        "Reward for continuous learning!"
    ]
    var achStatuses = ["Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed", "Completed",]
    var progressStatuses = [Float]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = lightBlueColor
        achLabel.textColor = grayTextCOlor
        achievementProgress.layer.cornerRadius = 2
        achievementProgress.isHidden = true
        AchievementNumbers.text = ""
        achCollectionView.dataSource = self
        achCollectionView.delegate = self
        
        progressStatuses = [1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,]
        let ud = UserDefaults.standard
        let prog = ud.integer(forKey: "progress1")
        if prog < 100{
            names[2] = "???"
            descs[2] = "???"
            achStatuses[2] = "\(prog) / 100"
            progressStatuses[2] = Float(prog) / 100
        }else{
            statuses[2] = true
            ud.set(true, forKey: "achievementUnlocked")
        }
    }
    
    @IBAction func searchAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func voucherAction(_ sender: Any) {
        performSegue(withIdentifier: "toVouch", sender: self)
    }
}

extension AchievementViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AchievementCollectionViewCell
        
        cell.achLabel.numberOfLines = 2
        cell.achLabel.sizeToFit()
        cell.achLabel.textColor = grayTextCOlor
        cell.achImageView.image = images[indexPath.item]
        if statuses[indexPath.item]{
            cell.isActiveView.isHidden = true
            cell.achLabel.text = names[indexPath.item]
        } else {
            cell.achLabel.text = "???"
        }
        cell.isActiveView.layer.cornerRadius = 15
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        achImage.image = images[indexPath.item]
        achievementProgress.isHidden = false
        achLabel.text = names[indexPath.item]
        AchievementNumbers.text = achStatuses[indexPath.item]
    achievementProgress.setProgress(progressStatuses[indexPath.item], animated: true)
        descLabel.numberOfLines = 0
        descLabel.sizeToFit()
        descLabel.textColor = grayTextCOlor
        descLabel.text = descs[indexPath.item]
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return statuses[indexPath.item]
//    }
}
