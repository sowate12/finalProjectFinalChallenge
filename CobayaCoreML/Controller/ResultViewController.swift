//
//  ResultViewController.swift
//  CobayaCoreML
//
//  Created by Ivan Riyanto on 03/02/19.
//  Copyright © 2019 Sania Monica. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var index : [Int] = []
    var moreDetailedIsTrue : Bool = false
    let hijau = UIColor(displayP3Red: 61/255, green: 130/255, blue: 56/255, alpha: 1)
    let hijauTua = UIColor(displayP3Red: 113/255, green: 136/255, blue: 33/255, alpha: 1)
    let orangeKuning = UIColor(displayP3Red: 240/255, green: 166/255, blue: 22/255, alpha: 1)
    let orange = UIColor(displayP3Red: 229/255, green: 113/255, blue: 28/255, alpha: 1)
    let merah = UIColor(displayP3Red: 212/255, green: 32/255, blue: 36/255, alpha: 1)
    var tips : [String] = [NSLocalizedString("Check the texture of the fruit again, make sure that it's firm ", comment: ""),NSLocalizedString("Don't forget to check the smell too.", comment: ""),NSLocalizedString("A sweet smell from the fruit indicates it has sweet flavour", comment: ""),NSLocalizedString("A sweet smell from the fruit indicates it has sweet flavour", comment: ""),NSLocalizedString("If the fruit is starting to get tender, it means it's starting to go bad. Better eat that fast!", comment: ""),NSLocalizedString("If the fruit smells good, time for you to grab the fruit!", comment: "")]
    var appleDescription : [String] =
        [NSLocalizedString("We detect that the fruit color is dull, try to choose another apple ", comment: ""),NSLocalizedString("We detect that the fruit color is a bit dull, try to choose another apple", comment: ""),NSLocalizedString("We detect that the fruit is a bit fresh and the color is fine", comment: ""),NSLocalizedString("We detect that the fruit is fresh and color are good", comment: ""),NSLocalizedString("We detect that the fruit is in prime condition, ripe and the color looks good.", comment: "")
         ]
    var orangeDescription : [String] =
        [NSLocalizedString("We detect that the fruit color is dull, try to choose another orange ", comment: ""),NSLocalizedString("We detect that the fruit color is a bit dull, try to choose another orange", comment: ""),NSLocalizedString("We detect that the fruit is a bit fresh and the color is fine", comment: ""),NSLocalizedString("We detect that the fruit is fresh and color are good", comment: ""),NSLocalizedString("We detect that the fruit is in prime condition, ripe and the color looks good.", comment: "")
    ]

    var tomatoDescription : [String] =
        [NSLocalizedString("We detect that the fruit color is dull, try to choose another tomato ", comment: ""),NSLocalizedString("We detect that the fruit color is a bit dull, try to choose another tomato", comment: ""),NSLocalizedString("We detect that the fruit is a bit fresh and the color is fine", comment: ""),NSLocalizedString("We detect that the fruit is fresh and color are good", comment: ""),NSLocalizedString("We detect that the fruit is in prime condition, ripe and the color looks good.", comment: "")
    ]

    
    let topGreenView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = UIColor.green
        return imageView
    }()
    
    let bottomWhiteView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    let yourResultIsText: UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("This side's result :", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Biko", size: 30)
        return textView
    }()
    
    let viewGabungan: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    let nilaiOutlet2: UITextView = {
        let textView = UITextView()
        textView.text = "10.0"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .right
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Biko-Bold", size: 90)
        return textView
    }()
    
    let garisLabel: UITextView = {
        let textView = UITextView()
        textView.text = "/"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Biko-Light", size: 90)
        return textView
    }()
    
    let sepuluhLabel: UITextView = {
        let textView = UITextView()
        textView.text = "10.0"
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Biko-Bold", size: 50)
        return textView
    }()
    
    let qualityLabel: UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("Great Eye!", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Biko", size: 30)
        return textView
    }()
    
    let qualityColorLabel : UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("Color : ", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    let showMoreOrLessButton: UIButton = {
        let button = UIButton()

        var image = UIImage(named: "arrowDown") as UIImage?
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(buttonShowMore), for: .touchUpInside)
        return button
    }()
    
    let showMoreOrLessButton2: UIButton = {
        let button = UIButton()
        
        var image = UIImage(named: "arrowUp") as UIImage?
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(buttonShowLess), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonShowMore(){
        if (moreDetailedIsTrue == false) {

            let xTopGreenView = topGreenView.frame.origin.x
            let yTopGreenView = self.view.center.y
            topGreenView.frame.origin = CGPoint(x: xTopGreenView, y: yTopGreenView - 250 )
            topGreenView.frame.size.height = 205
            print("habis di pasang topview ==== x: \(topGreenView.frame.origin.x), y: \(topGreenView.frame.origin.y)")
            let x = viewGabungan.frame.origin.x
            let y = self.view.center.y
            viewGabungan.frame.origin = CGPoint(x: x, y: y - 250)
            bottomWhiteView.isHidden = false
            showMoreOrLessButton.isHidden = true
            showMoreOrLessButton2.isHidden = false
            let xBottomWhiteView = bottomWhiteView.frame.origin.x
            let yBottomWhiteView = self.view.center.y
            bottomWhiteView.frame.origin = CGPoint(x: xBottomWhiteView, y: yBottomWhiteView - 70)
            print("habis di pasang ==== x: \(bottomWhiteView.frame.origin.x), y: \(bottomWhiteView.frame.origin.y)")
            let xCloseButton = closeButton.frame.origin.x
            let yCloseButton = self.view.center.y
            closeButton.frame.origin = CGPoint(x: xCloseButton, y: yCloseButton - 230)
            topGreenView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            moreDetailedIsTrue = true
        }
    }
    
    @objc func buttonShowLess(){
        if (moreDetailedIsTrue == true){
    
            topGreenView.layer.cornerRadius = 10
            topGreenView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
            topGreenView.frame.size.height = 343
            let xTopGreenView = topGreenView.frame.origin.x
            let yTopGreenView = self.view.center.y - topGreenView.frame.height/2
            topGreenView.frame.origin = CGPoint(x: xTopGreenView, y: yTopGreenView )
            let x = viewGabungan.frame.origin.x
            let y = self.view.center.y - viewGabungan.frame.height/2
            viewGabungan.frame.origin = CGPoint(x: x, y: y - 35)
            let xBottomWhiteView = bottomWhiteView.frame.origin.x
            let yBottomWhiteView = self.view.frame.origin.y
            bottomWhiteView.frame.origin = CGPoint(x: xBottomWhiteView, y: yBottomWhiteView + 150 )
            let xCloseButton = closeButton.frame.origin.x
            let yCloseButton = self.view.center.y - closeButton.frame.height
            closeButton.frame.origin = CGPoint(x: xCloseButton, y: yCloseButton - 120 )
            bottomWhiteView.isHidden = true
            showMoreOrLessButton2.isHidden = true
            showMoreOrLessButton.isHidden = false
            moreDetailedIsTrue = false
        }
    }
    
    let closeButton: UIButton = {
        let button = UIButton()
        var image = UIImage(named: "closeWhite") as UIImage?
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(buttonDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonDismiss(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }) { (finished : Bool) in
            if (finished){
                self.view.removeFromSuperview()
            }
        }
    }
    
    let colorLabel : UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("Color      : Average", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont(name: "Biko-Bold", size: 30)
        return textView
    }()
    
    let descriptionLabel : UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("It looks a bit fresh and the texture is quite good", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    let keteranganTips : UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("Tips", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 15)
        return textView
    }()
    
    let tipsLabel : UITextView = {
        let textView = UITextView()
        textView.text = NSLocalizedString("Check the texture of the fruit again, make sure that it's firm ", comment: "")
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.light)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        hasilScan()
        setupView()
        
        setupLayout()
        bottomWhiteView.isHidden = true
        showMoreOrLessButton2.isHidden = true
    }
    
    func setupView(){
        view.addSubview(bottomWhiteView)
        view.addSubview(topGreenView)
        view.addSubview(viewGabungan)
        viewGabungan.addSubview(yourResultIsText)
        viewGabungan.addSubview(nilaiOutlet2)
        viewGabungan.addSubview(garisLabel)
        viewGabungan.addSubview(sepuluhLabel)
        viewGabungan.addSubview(qualityLabel)
        bottomWhiteView.addSubview(qualityColorLabel)
        bottomWhiteView.addSubview(colorLabel)
        bottomWhiteView.addSubview(descriptionLabel)
        bottomWhiteView.addSubview(tipsLabel)
        bottomWhiteView.addSubview(keteranganTips)
        view.addSubview(showMoreOrLessButton)
        view.addSubview(showMoreOrLessButton2)
        view.addSubview(closeButton)
    }
    
    //LessDetail
    func setupLayout(){
        //Kotak Hijau
        
        topGreenView.centerXAnchor.constraint(equalTo : view.centerXAnchor).isActive = true
        topGreenView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        topGreenView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        topGreenView.heightAnchor.constraint(equalToConstant: 343).isActive = true
        
        //Close Button
        closeButton.topAnchor.constraint(equalTo: topGreenView.topAnchor, constant : 25).isActive = true
        closeButton.leftAnchor.constraint(equalTo: topGreenView.leftAnchor, constant : 25).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //Kotak Putih
        bottomWhiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomWhiteView.widthAnchor.constraint(equalToConstant: 343).isActive = true
        bottomWhiteView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        //bottomWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomWhiteView.topAnchor.constraint(equalTo: topGreenView.bottomAnchor, constant : -20).isActive = true
        bottomWhiteView.layer.cornerRadius = 20
        
        //ViewUnderYourResultIsText
        viewGabungan.topAnchor.constraint(equalTo: topGreenView.topAnchor, constant: 50).isActive = true
        viewGabungan.heightAnchor.constraint(equalToConstant: 160).isActive = true
        viewGabungan.leftAnchor.constraint(equalTo: topGreenView.leftAnchor , constant: 10).isActive = true
        viewGabungan.rightAnchor.constraint(equalTo: topGreenView.rightAnchor, constant: -10).isActive = true
        
        //Your Result Is
        yourResultIsText.topAnchor.constraint(equalTo: viewGabungan.topAnchor, constant: 10).isActive = true
        yourResultIsText.heightAnchor.constraint(equalToConstant: 40).isActive = true
        yourResultIsText.leftAnchor.constraint(equalTo: viewGabungan.leftAnchor).isActive = true
        yourResultIsText.rightAnchor.constraint(equalTo: viewGabungan.rightAnchor).isActive = true
        
        //ShowMoreOrLessButton
        showMoreOrLessButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 130).isActive = true
        showMoreOrLessButton.heightAnchor.constraint(equalToConstant: 30 ).isActive = true
        showMoreOrLessButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showMoreOrLessButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
        showMoreOrLessButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -130).isActive = true
        
        //NilaiOutlet2
        nilaiOutlet2.topAnchor.constraint(equalTo: yourResultIsText.topAnchor, constant: 55).isActive = true
        nilaiOutlet2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        nilaiOutlet2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nilaiOutlet2.rightAnchor.constraint(equalTo:garisLabel.leftAnchor, constant: 17 ).isActive = true
//        nilaiOutlet2.leftAnchor.constraint(equalTo: viewGabungan.leftAnchor, constant: 20).isActive = true
        
        //GarisLabel
        garisLabel.topAnchor.constraint(equalTo: yourResultIsText.topAnchor, constant: 57).isActive = true
        garisLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        garisLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        garisLabel.rightAnchor.constraint(equalTo: sepuluhLabel.leftAnchor, constant: 15).isActive = true
//        garisLabel.leftAnchor.constraint(equalTo: nilaiOutlet2.rightAnchor, constant: -40).isActive = true
        
        //SepuluhLabel
        sepuluhLabel.topAnchor.constraint(equalTo: yourResultIsText.topAnchor, constant: 87).isActive = true
        sepuluhLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sepuluhLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sepuluhLabel.rightAnchor.constraint(equalTo: viewGabungan.rightAnchor, constant: -33).isActive = true
//        sepuluhLabel.leftAnchor.constraint(equalTo: garisLabel.rightAnchor, constant: -20).isActive = true
        
        //QualityLabel
        qualityLabel.topAnchor.constraint(equalTo: viewGabungan.topAnchor, constant: 155).isActive = true
        qualityLabel.heightAnchor.constraint(equalToConstant:100).isActive = true
        qualityLabel.leftAnchor.constraint(equalTo: viewGabungan.leftAnchor).isActive = true
        qualityLabel.rightAnchor.constraint(equalTo: viewGabungan.rightAnchor).isActive = true
        
        //ColorLabel
        
        //QualityLabel
        qualityColorLabel.topAnchor.constraint(equalTo: bottomWhiteView.topAnchor, constant: 55).isActive = true
        qualityColorLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        qualityColorLabel.leftAnchor.constraint(equalTo: bottomWhiteView.leftAnchor, constant : 34).isActive = true
        qualityColorLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        colorLabel.topAnchor.constraint(equalTo: qualityColorLabel.topAnchor).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        colorLabel.rightAnchor.constraint(equalTo: bottomWhiteView.rightAnchor, constant: -10).isActive = true
        colorLabel.leftAnchor.constraint(equalTo: qualityColorLabel.rightAnchor, constant : -30).isActive = true
        
        //DescriptionLabel
        descriptionLabel.topAnchor.constraint(equalTo: colorLabel.bottomAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 110).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: bottomWhiteView.rightAnchor, constant: -34).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: qualityColorLabel.leftAnchor).isActive = true
        
        //TipsLabel
        tipsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        tipsLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        tipsLabel.rightAnchor.constraint(equalTo: bottomWhiteView.rightAnchor, constant: -34).isActive = true
        tipsLabel.leftAnchor.constraint(equalTo: qualityColorLabel.leftAnchor, constant : 5).isActive = true
        
        //KeteranganTips
        keteranganTips.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant : -25).isActive = true
        //keteranganTips.widthAnchor.constraint(equalToConstant: 150).isActive = true
        keteranganTips.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //keteranganTips.centerXAnchor.constraint(equalTo: bottomWhiteView.centerXAnchor).isActive = true
        keteranganTips.rightAnchor.constraint(equalTo: bottomWhiteView.rightAnchor, constant: -34).isActive = true
        keteranganTips.leftAnchor.constraint(equalTo: qualityColorLabel.leftAnchor, constant : 5).isActive = true

        
        //ShowMoreOrLessButton2
        showMoreOrLessButton2.topAnchor.constraint(equalTo: showMoreOrLessButton.bottomAnchor, constant : 90).isActive = true
        showMoreOrLessButton2.heightAnchor.constraint(equalToConstant: 30 ).isActive = true
        showMoreOrLessButton2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        showMoreOrLessButton2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
        showMoreOrLessButton2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -130).isActive = true
    }
    
    func hasilScan() {
        let nilaiTotal = String(format: "%.1f", NilaiSementara.nilaiSementara)
        self.nilaiOutlet2.text = "\(nilaiTotal)"
        
        if NilaiSementara.nilaiSementara >= 9 && NilaiSementara.nilaiSementara <= 10{
            topGreenView.backgroundColor = hijau
            qualityLabel.text = NSLocalizedString("Great Eye!", comment: "")
            colorLabel.text = NSLocalizedString("Excellent!", comment: "")
            colorLabel.textColor = hijau
            if  NilaiSementara.currentFruit == "Fuji Apple" {
               descriptionLabel.text = appleDescription[4]
            } else if  NilaiSementara.currentFruit == "Mandarin Orange" {
                descriptionLabel.text = orangeDescription[4]
            } else {
                descriptionLabel.text = tomatoDescription[4]
            }
            tipsLabel.text = tips.randomElement()
        }else if NilaiSementara.nilaiSementara >= 8 && NilaiSementara.nilaiSementara < 9 {
            topGreenView.backgroundColor = hijauTua
            qualityLabel.text = NSLocalizedString("Sweet", comment: "")
            colorLabel.text = NSLocalizedString("Good!", comment: "")
            colorLabel.textColor = hijauTua
            if  NilaiSementara.currentFruit == "Fuji Apple" {
                descriptionLabel.text = appleDescription[3]
            } else if NilaiSementara.currentFruit == "Mandarin Orange" {
                descriptionLabel.text = orangeDescription[3]
            } else {
                descriptionLabel.text = tomatoDescription[3]
            }
            tipsLabel.text = tips.randomElement()
        }else if NilaiSementara.nilaiSementara >= 7 && NilaiSementara.nilaiSementara < 8 {
            topGreenView.backgroundColor = orangeKuning
            qualityLabel.text = NSLocalizedString("Okay.", comment: "")
            colorLabel.text = NSLocalizedString("Average", comment: "")
            colorLabel.textColor = orangeKuning
            if  NilaiSementara.currentFruit == "Fuji Apple" {
                descriptionLabel.text = appleDescription[2]
            } else if  NilaiSementara.currentFruit == "Mandarin Orange" {
                descriptionLabel.text = orangeDescription[2]
            } else {
                descriptionLabel.text = tomatoDescription[2]
            }
            tipsLabel.text = tips.randomElement()
        }else if NilaiSementara.nilaiSementara >= 5 && NilaiSementara.nilaiSementara < 7 {
            topGreenView.backgroundColor = orange
            qualityLabel.text = NSLocalizedString("Almost There...", comment: "")
            colorLabel.text = NSLocalizedString("Not Good", comment: "")
            colorLabel.textColor = orange
            if  NilaiSementara.currentFruit == "Fuji Apple" {
                descriptionLabel.text = appleDescription[1]
            } else if  NilaiSementara.currentFruit == "Mandarin Orange" {
                descriptionLabel.text = orangeDescription[1]
            } else {
                descriptionLabel.text = tomatoDescription[1]
            }
            tipsLabel.text = tips.randomElement()
        }else {
            topGreenView.backgroundColor = merah
            qualityLabel.text = NSLocalizedString("Meh.", comment: "")
            colorLabel.text = NSLocalizedString("Poor", comment: "")
            colorLabel.textColor = merah
            if NilaiSementara.currentFruit == "Fuji Apple" {
                descriptionLabel.text = appleDescription[0]
            } else if NilaiSementara.currentFruit == "Mandarin Orange" {
                descriptionLabel.text = orangeDescription[0]
            } else {
                descriptionLabel.text = tomatoDescription[0]
            }
            tipsLabel.text = tips.randomElement()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if (self.moreDetailedIsTrue == false && touch?.view != topGreenView) || ((self.moreDetailedIsTrue == true) && (Int((touch?.location(in: bottomWhiteView).x)!) <= 16 || Int((touch?.location(in: bottomWhiteView).y)!) >= 380) && touch?.view != viewGabungan) && touch?.view != nilaiOutlet2{
            UIView.animate(withDuration: 0.25, animations: {
                self.view.transform = CGAffineTransform(translationX: 1.3, y: 1.3)
                self.view.alpha = 0.0;
            }) { (finished : Bool) in
                if (finished){
                    self.view.removeFromSuperview()
                }
            }
        } else {

        }
    }
}
