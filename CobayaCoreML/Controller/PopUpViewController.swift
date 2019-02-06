//
//  PopUpViewController.swift
//  UIPageViewController2
//
//  Created by Ivan Riyanto on 10/01/19.
//  Copyright © 2019 Ivan Riyanto. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    //MARK: - Variabel
    let hijau = UIColor(rgb: 0x3D8238)
    let hijauTua = UIColor(rgb: 0x718821)
    let orangeKuning = UIColor(rgb: 0xF0A616)
    let orange = UIColor(rgb: 0xE5711C)
    let merah = UIColor(rgb: 0xD42024)
    let viewAnimationDelegate = AnimationHelper()
    var tips : [String] = ["Check the texture of the fruit again, make sure that it's firm ",
                           "Don't forget to check the smell too.",
                           "A sweet smell from the fruit indicates it has sweet flavour",
                           "If the fruit is starting to tender, it means it's starting to over ripe. Better eat that fast!","If the fruit smells good, time for you to grab the fruit!"]
    var colorDescription : [String] = ["It doesn't looks that fresh and the texture isn't quite                  good",
                                       "It doesn't looks that fresh and the texture isn't quite good ",
                                       "It looks a bit fresh and the texture is quite good",
                                       "It looks quite fresh and the texture is nice",
                                       "It looks deliciously fresh and its dazzlingly clean"]
    
    
    //MARK: - Outlet
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var nilaiOutlet2: UILabel!
    @IBOutlet weak var showMoreOutlet: UIButton!
    @IBOutlet weak var showLessOutlet: UIButton!
    @IBOutlet weak var topGreenView: UIView!
    @IBOutlet weak var warnaAtas: UIImageView!
    @IBOutlet weak var bottomWhiteView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        hasilScan()
        setupView()
        showMoreOutlet.imageEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        showLessOutlet.contentEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
    }
    
    @IBAction func closePopUpButton(_ sender: Any) {
        screenShotMethod()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }) { (finished : Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        }
    }

//    @IBAction func showLessButton(_ sender: Any) {
//        viewAnimationDelegate.hapticMedium()
//        topGreenView.frame = CGRect(x: 16, y: view.frame.height / 2 - 100, width: 343, height: 343)
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.topGreenView.layoutIfNeeded()
//            self.bottomWhiteView.layoutIfNeeded()
//            self.topGreenView.center.y -= self.topGreenView.frame.height/2
//            self.bottomWhiteView.center.y -= self.bottomWhiteView.frame.height/4-60
//         }, completion: nil)
//        showMoreOutlet.isHidden = false
//        showLessOutlet.isHidden = true
//        bottomWhiteView.isHidden = true
//    }
    
    @IBAction func showMoreDetailButton(_ sender: Any) {
        viewAnimationDelegate.hapticMedium()
        topGreenView.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: 68, width: 343, height: 343)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.topGreenView.layoutIfNeeded()
            self.bottomWhiteView.layoutIfNeeded()
            self.topGreenView.center.y += self.topGreenView.frame.height/2
            self.bottomWhiteView.center.y += self.bottomWhiteView.frame.height/4-60
        }, completion: nil)
        bottomWhiteView.isHidden = false
        showLessOutlet.isHidden = false
        showMoreOutlet.isHidden = true
    }
    
    func setupView(){
       // topGreenView.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: view.frame.height / 2 - 80, width: 343, height: 343)
       // bottomWhiteView.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: 224, width: 338, height: 467)
       // warnaAtas.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: view.frame.height / 2 - 80, width: 343, height: 343)
        topGreenView.layer.cornerRadius = 10
        topGreenView.layer.masksToBounds = true
        bottomWhiteView.isHidden = true
        showMoreOutlet.isHidden = false
    }
    
    
    
    //MARK: - Function
    func hasilScan() {
        let nilaiTotal = String(format: "%.1f", NilaiSementara.nilaiSementara)
        self.nilaiOutlet2.text = "\(nilaiTotal)"
        
        if NilaiSementara.nilaiSementara >= 9 && NilaiSementara.nilaiSementara <= 10{
            warnaAtas.backgroundColor = hijau
            qualityLabel.text = "Great Eye!"
            colorLabel.text = "Excellent!"
            descriptionLabel.text = colorDescription[0]
            
            
        }else if NilaiSementara.nilaiSementara >= 8 && NilaiSementara.nilaiSementara < 9 {
            warnaAtas.backgroundColor = hijauTua
            qualityLabel.text = "Sweet"
            colorLabel.text = "Good!"
            descriptionLabel.text = colorDescription[1]
        
        }else if NilaiSementara.nilaiSementara >= 7 && NilaiSementara.nilaiSementara < 8 {
            warnaAtas.backgroundColor = orangeKuning
            qualityLabel.text = "Okay."
            colorLabel.text = "Average"
            descriptionLabel.text = colorDescription[2]
       
        }else if NilaiSementara.nilaiSementara >= 5 && NilaiSementara.nilaiSementara < 7 {
            warnaAtas.backgroundColor = orange
            qualityLabel.text = "Almost There..."
            colorLabel.text = "Not Good"
            descriptionLabel.text = colorDescription[3]
            
        }else {
            warnaAtas.backgroundColor = merah
            qualityLabel.text = "Meh."
            colorLabel.text = "Poor"
            descriptionLabel.text = colorDescription[4]

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        screenShotMethod()
        let touch: UITouch? = touches.first

        if touch?.view != topGreenView || touch?.view != bottomWhiteView{
            UIView.animate(withDuration: 0.25, animations: {
                self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
               
            }) { (finished : Bool) in
                if (finished){
                    self.view.removeFromSuperview()
                }
            }
        }
    }
    
    func screenShotMethod() {
        //Create the UIImage
        guard let layer = UIApplication.shared.keyWindow?.layer else { return }
//        let layerView = topGreenView.layer
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, true, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return}
        UIGraphicsEndImageContext()
        
        NilaiSementara.gambarSS = image
    }
}

