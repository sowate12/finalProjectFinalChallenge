//
//  TutorialViewController.swift
//  CobayaCoreML
//
//  Created by keenan warouw on 08/02/19.
//  Copyright © 2019 Keenan Warouw. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    var tutorialImages = ["tutorial1", "tutorial2", "tutorial3", "tutorial4", "tutorial5", "tutorial6", "tutorial7", "tutorial8", "tutorial9", ]
    var imageTutorial : UIImageView = UIImageView()
    var tutorialCounter = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(named: "tutorial1") else { return }
        
        let scaledHeight = view.frame.width / image.size.width * image.size.height

        imageTutorial.contentMode = .scaleAspectFill
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                imageTutorial.frame = CGRect(x: 0, y: 0, width: 320, height: 568)

            case 1334:
                print("iPhone 6/6S/7/8")
                imageTutorial.contentMode = .scaleToFill
                imageTutorial.frame = CGRect(x: 19, y: 0, width: 337, height: 667)

            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                imageTutorial.frame = CGRect(x: 21 , y: 0, width: 372, height: 736)

            case 2436:
                imageTutorial.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)

            case 2688:
                imageTutorial.frame = CGRect(x: 0, y: 0, width: 414, height: 896)

            case 1792:
                imageTutorial.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

            default:
                imageTutorial.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            }
        }

        imageTutorial.image = UIImage(named: "\(tutorialImages[0])")
        view.backgroundColor = .black
        view.addSubview(imageTutorial)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tutorialCounter <= 7{
        tutorialCounter += 1
        imageTutorial.image = UIImage(named: "\(tutorialImages[tutorialCounter])")
        } else{
            print("a")
        }
    }
}
