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
    let hijau = UIColor(displayP3Red: 61, green: 130, blue: 56, alpha: 1)
    let hijauTua = UIColor(displayP3Red: 113, green: 136, blue: 33, alpha: 1)
    let orangeKuning = UIColor(displayP3Red: 240, green: 166, blue: 22, alpha: 1)
    let orange = UIColor(displayP3Red: 229, green: 113, blue: 28, alpha: 1)
    let merah = UIColor(displayP3Red: 212, green: 32, blue: 36, alpha: 1)
    let viewAnimationDelegate = AnimationHelper()
    
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
    @IBOutlet weak var textureLabel: UILabel!
    
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

    @IBAction func showLessButton(_ sender: Any) {
        viewAnimationDelegate.hapticMedium()
        topGreenView.frame = CGRect(x: 16, y: view.frame.height / 2 - 100, width: 343, height: 168)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.topGreenView.layoutIfNeeded()
            self.bottomWhiteView.layoutIfNeeded()
            self.topGreenView.center.y -= self.topGreenView.frame.height/2
            self.bottomWhiteView.center.y -= self.bottomWhiteView.frame.height/4-60
         }, completion: nil)
        showMoreOutlet.isHidden = false
        showLessOutlet.isHidden = true
        bottomWhiteView.isHidden = true
    }
    
    @IBAction func showMoreDetailButton(_ sender: Any) {
        viewAnimationDelegate.hapticMedium()
        topGreenView.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: 68, width: 343, height: 168)
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
        topGreenView.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: view.frame.height / 2 - 100, width: 343, height: 168)
        bottomWhiteView.frame = CGRect(x: view.frame.width - view.frame.width + 16, y: 224, width: 338, height: 467)
        topGreenView.layer.cornerRadius = 10
        topGreenView.layer.masksToBounds = true
        bottomWhiteView.isHidden = true
        showMoreOutlet.isHidden = false
    }
     
    //MARK: - Function
    func hasilScan() {
        let nilaiTotal = String(format: "%.1f", NilaiSementara.nilaiSementara)
        self.nilaiOutlet2.text = "\(nilaiTotal) / "
        
        if NilaiSementara.nilaiSementara >= 9 && NilaiSementara.nilaiSementara <= 10{
            warnaAtas.backgroundColor = hijau
            qualityLabel.text = "Great Eye!"
            colorLabel.text = ""
            textureLabel.text = ""
            
        }else if NilaiSementara.nilaiSementara >= 8 && NilaiSementara.nilaiSementara < 9 {
            warnaAtas.backgroundColor = hijauTua
            qualityLabel.text = "Sweet"
            colorLabel.text = ""
            textureLabel.text = ""
        }else if NilaiSementara.nilaiSementara >= 7 && NilaiSementara.nilaiSementara < 8 {
            warnaAtas.backgroundColor = orangeKuning
            qualityLabel.text = "Okay."
            colorLabel.text = ""
            textureLabel.text = ""
        }else if NilaiSementara.nilaiSementara >= 5 && NilaiSementara.nilaiSementara < 7 {
            warnaAtas.backgroundColor = orange
            qualityLabel.text = "Almost There..."
            colorLabel.text = ""
            textureLabel.text = ""
        }else {
            warnaAtas.backgroundColor = merah
            qualityLabel.text = "Meh."
            colorLabel.text = ""
            textureLabel.text = ""
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        screenShotMethod()
        let touch: UITouch? = touches.first

        if touch?.view != topGreenView && touch?.view != bottomWhiteView{
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

