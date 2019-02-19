//
//  ViewController.swift
//  cobaCoreMLRealTime
//
//  Created by Keenan Warouw on 03/09/18.
//  Copyright © 2018 Keenan Warouw. All rights reserved.
//

import UIKit
import AVKit
import Vision
import AVFoundation
import NVActivityIndicatorView
import SwiftySound

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // MARK: Variables
    var nilaiCounter = 0
    var buahCounter = 0
    var nilaiSementara : Float = 5
    var namaNamaBuah = ["","","Fuji Apple","Mandarin Orange", "Tomato","",""]
    var jumlahBuah = ["","","apel","jeruk","tomato","",""]
    var results = ["result1", "result2", "result3", "result4", "result5"]
    var backgroundWarna = ["","","viginetteApel","viginetteJeruk","viginetteTomato","",""]
    var hasShownResult = false
    var isFirstFrame : Bool = true
    var isChecking : Bool = false
    var checkBuah = false
    var hasSpinned = false
    var hasScanned = false
    var hasLoaded = false
    var timer = Timer()
    let generator = UINotificationFeedbackGenerator()
    var dummyImage : UIImageView = UIImageView()
    var namaBuah : UILabel = UILabel()
    var backgroundViginette: UIImageView = UIImageView()
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var checkBuahCounter = 0
    var scanningText : UILabel = UILabel()
    var loadingLabel : UILabel = UILabel()
    var checkingLabel : UILabel = UILabel()
    var scanningLabel : UILabel = UILabel()
    var imageViewTransform = CGAffineTransform.identity
    let helperDelegate = AnimationHelper()
    let hijau = UIColor(rgb: 0x3D8238)
    let hijauTua = UIColor(rgb: 0x718821)
    let orangeKuning = UIColor(rgb: 0xF0A616)
    let orange = UIColor(rgb: 0xE5711C)
    let merah = UIColor(rgb: 0xD42024)
    
    // MARK: IBOutlet
    @IBOutlet weak var buttonReview: UIButton!
    @IBOutlet weak var silhouetteImage: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var fruitTypeCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tutorialButton: UIButton!
    @IBOutlet weak var scanningIcon: NVActivityIndicatorView!
    @IBOutlet weak var reviewNumber: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var scanView: UIView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingComplete")
        userDefaults.synchronize()

        fruitTypeCollectionView.delegate = self
        fruitTypeCollectionView.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        
        checkingResult()
        helperDelegate.addLoading()
        setupView()
        hasLoaded = true
        if NilaiSementara.nilaiSementara == 0 {
            viewReview.isHidden = true
            buttonReview.isHidden = true
            reviewNumber.isHidden = true
            reviewLabel.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 2, section: 0)
        self.fruitTypeCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        self.fruitTypeCollectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        animateSilhouette()
        setBackground()
    }

    // MARK: Setup the View
    func setupView(){
        setupDummyImage()
        pasangNamaBuah()
        CameraControl()
        checking()
        scanning()
        gantiKeScan()
        setupCollectionView()
        setupIcon()
        setupViewReview()
        setupColor()
        setScanningText()
        setBackground()
        view.addSubview(backgroundViginette)
        view.addSubview(fruitTypeCollectionView)
        view.addSubview(startButton)
        view.addSubview(silhouetteImage)
        view.addSubview(dummyImage)
        view.addSubview(namaBuah)
        view.addSubview(checkingLabel)
        view.addSubview(scanningLabel)
        view.addSubview(scanningIcon)
        view.addSubview(cancelButton)
        view.addSubview(tutorialButton)
        view.addSubview(activityIndicator)
        view.addSubview(viewReview)
        view.addSubview(scanningText)
        view.addSubview(scanView)
//        view.addSubview(buttonReview)
//        view.addSubview(reviewNumber)
//        view.addSubview(reviewLabel)
    }
    
    /// Setup the CollectionView
    func setupCollectionView(){
        fruitTypeCollectionView.center = CGPoint(x: view.frame.width / 2 - 0.5, y: view.frame.height - 100 )
        silhouetteImage.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - 30)
        fruitTypeCollectionView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(recordButtonDidTap))
        silhouetteImage.addGestureRecognizer(tap)
        silhouetteImage.isUserInteractionEnabled = true
    }
    
    func setupViewReview(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                viewReview.frame = CGRect(x: view.frame.width - 150, y: 109, width: 150, height: 60)
                tutorialButton.frame = CGRect(x: view.frame.width - 59, y: 53, width: 25 , height: 25)
            case 2688:
                viewReview.frame = CGRect(x: view.frame.width - 150, y: 109, width: 150, height: 60)
                tutorialButton.frame = CGRect(x: view.frame.width - 59, y: 53, width: 25 , height: 25)
            case 1792:
                viewReview.frame = CGRect(x: view.frame.width - 150, y: 109, width: 150, height: 60)
                tutorialButton.frame = CGRect(x: view.frame.width - 59, y: 53, width: 25 , height: 25)
            default:
                viewReview.frame = CGRect(x: view.frame.width - 150, y: 79, width: 150, height: 60)
                tutorialButton.frame = CGRect(x: view.frame.width - 59, y: 33, width: 25 , height: 25)
            }
        }
        buttonReview.layer.masksToBounds = true
        reviewLabel.textAlignment = .left
        reviewLabel.numberOfLines = 2
        reviewLabel.frame = CGRect(x: 80, y: 15, width: 80, height: 36)
        reviewLabel.layer.masksToBounds = true
        reviewLabel.textColor = .white
        reviewLabel.text = "Fuji Apple"
        reviewNumber.textAlignment = .center
        reviewNumber.layer.masksToBounds = true
        reviewNumber.frame = CGRect(x: 20, y: 16, width: 35, height: 36)
        reviewNumber.font = UIFont(name: "Biko-Bold", size: 17)
    }
    
    /// Setup the Label in the middle of the silhouette
    func setScanningText(){
        let x = view.frame.width / 2
        let y = view.frame.height / 2
        scanningText.frame = CGRect(x: x - 75, y: y - 125, width: 150, height: 125)
        scanningText.font = UIFont.boldSystemFont(ofSize: 20)
        scanningText.textAlignment = .center
        scanningText.layer.masksToBounds = true
        scanningText.textColor = .white
        scanningText.layer.shadowColor = UIColor.black.cgColor
        scanningText.layer.shadowRadius = 2.0
        scanningText.layer.shadowOpacity = 0.5
        scanningText.layer.shadowOffset = CGSize(width: 1, height: 2)
        scanningText.layer.masksToBounds = false
        scanningText.numberOfLines = 2
        scanningText.text = "Tap the fruit to scan"
        scanView.frame = CGRect(x: x - 120, y: y - 200, width: 240, height: 400)
        let tap = UITapGestureRecognizer(target: self, action: #selector(recordButtonDidTap))
        scanView.addGestureRecognizer(tap)
        scanView.isUserInteractionEnabled = true
    }

    @objc func recordButtonDidTap(_ sender: UITapGestureRecognizer){
        activityIndicator.startAnimating()
        startScanning()
    }
    
    /// Setup the Label containing fruit names
    func pasangNamaBuah(){
        let x = view.frame.width / 2
        let y = view.frame.height
        namaBuah.frame = CGRect(x: x - 100, y: y - 225, width: 200, height: 125)
        namaBuah.textAlignment = .center
        namaBuah.textColor = .white
        namaBuah.layer.shadowColor = UIColor.black.cgColor
        namaBuah.layer.shadowRadius = 2.0
        namaBuah.layer.shadowOpacity = 0.5
        namaBuah.layer.shadowOffset = CGSize(width: 1, height: 2)
        namaBuah.layer.masksToBounds = false
        namaBuah.text = "\(namaNamaBuah[2])"
    }
    
    func setupIcon(){
        let x = view.frame.width / 2
        let y = view.frame.height
        scanningIcon.frame = CGRect(x: x - 25, y: y / 2 - 25 , width: 50 , height: 50)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
    }
    
    /// Setup the Cancel button, dummy image, and white circle in the middle s
    func setupDummyImage(){
        let x = view.frame.width / 2
        let y = view.frame.height
        startButton.isUserInteractionEnabled = false
        startButton.frame = CGRect(x: x - 49.5, y: y - 144 , width: 96, height: 96)
        dummyImage.frame = CGRect(x: x - 49.5, y: y - 144, width: 96, height: 96)
        cancelButton.frame = CGRect(x: 28, y: 53, width: 30, height: 30)
        cancelButton.isHidden = true
        cancelButton.layer.masksToBounds = true
        dummyImage.layer.masksToBounds = true
        dummyImage.image = UIImage(named: "\(jumlahBuah[2])Scan")
        dummyImage.isHidden = true
    }
    
    /// Setup the text that appears when scanning
    func checking(){
        checkingLabel.isHidden = true
        checkingLabel.font = UIFont.boldSystemFont(ofSize: 20)
        checkingLabel.text = "Detecting Fruit ."
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            var string: String {
                switch self.checkingLabel.text {
                case "Detecting Fruit .":       return "Detecting Fruit .."
                case "Detecting Fruit ..":      return "Detecting Fruit ..."
                case "Detecting Fruit ...":     return "Detecting Fruit ."
                default:                      return "Detecting Fruit"
                }
            }
            self.checkingLabel.text = string
        }
        checkingLabel.textColor = .white
        checkingLabel.frame = CGRect(x: view.frame.width / 2 - 65, y: view.frame.height / 2 - 125, width: 130, height: 100)
        checkingLabel.numberOfLines = 2
        checkingLabel.textAlignment = .center
    }
    
    func setupColor(){
        let nilaiTotal = String(format: "%.1f", NilaiSementara.nilaiSementara)
        reviewNumber.text = nilaiTotal
        reviewLabel.text = NilaiSementara.previousFruit
        if NilaiSementara.nilaiSementara >= 9 && NilaiSementara.nilaiSementara <= 10{
            buttonReview.setImage(UIImage(named: "\(results[0])"), for: .normal)
            reviewNumber.textColor = hijau
        }else if NilaiSementara.nilaiSementara >= 8 && NilaiSementara.nilaiSementara < 9 {
            buttonReview.setImage(UIImage(named: "\(results[1])"), for: .normal)
            reviewNumber.textColor = hijauTua
        }else if NilaiSementara.nilaiSementara >= 7 && NilaiSementara.nilaiSementara < 8 {
            buttonReview.setImage(UIImage(named: "\(results[2])"), for: .normal)
            reviewNumber.textColor = orangeKuning
        }else if NilaiSementara.nilaiSementara >= 5 && NilaiSementara.nilaiSementara < 7 {
            buttonReview.setImage(UIImage(named: "\(results[3])"), for: .normal)
            reviewNumber.textColor = orange
        }else {
            buttonReview.setImage(UIImage(named: "\(results[4])"), for: .normal)
            reviewNumber.textColor = merah
        }
    }
    
    func scanning(){
        scanningLabel.isHidden = true
        scanningLabel.font = UIFont.boldSystemFont(ofSize: 20)
        scanningLabel.text = "Hold Still, Scanning the Fruit ."
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            var string: String {
                switch self.scanningLabel.text {
                case "Hold Still, Scanning the Fruit .":       return "Hold Still, Scanning the Fruit .."
                case "Hold Still, Scanning the Fruit ..":      return "Hold Still, Scanning the Fruit ..."
                case "Hold Still, Scanning the Fruit ...":     return "Hold Still, Scanning the Fruit ."
                default:                      return "Hold Still, Scanning the Fruit"
                }
            }
            self.scanningLabel.text = string
        }
        scanningLabel.textColor = .white
        scanningLabel.numberOfLines = 2
        scanningLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 125, width: 200, height: 100)
        scanningLabel.textAlignment = .center
    }
    
    func gantiKeScan(){
        if checkBuah == true{
            scanningLabel.isHidden = false
            checkingLabel.isHidden = true
            if hasSpinned == false{
                helperDelegate.animateCircle()
                hasSpinned = true
            }
        }else{
            scanningLabel.isHidden = true
        }
        if scanningText.isHidden == false{
            scanningLabel.isHidden = true
        }
        if checkBuahCounter == 10{
            isChecking = false
            checkBuahCounter = 0
            checkingAlert()
        }
    }
    
    func checkingAlert(){
        helperDelegate.hapticMedium()
        let alert = UIAlertController(title: "There's No Fruit Detected", message: "Would you like to rescan the fruit?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: { action in
            self.isChecking = true
            print("Yes")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { action in self.resetVariables()
            self.showOutlet()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideOutlet(){
        startButton.isHidden = true
        fruitTypeCollectionView.isHidden = true
        scanningText.isHidden = true
        dummyImage.isHidden = false
        cancelButton.isHidden = false
        viewReview.isHidden = true
        buttonReview.isHidden = true
        reviewNumber.isHidden = true
        reviewLabel.isHidden = true
        tutorialButton.isHidden = true
    }
    
    /// View when not scanning
    func showOutlet(){
//        scanningIcon.stopAnimating()
        activityIndicator.stopAnimating()
        checkingLabel.isHidden = true
        scanningLabel.isHidden = true
        dummyImage.isHidden = true
        cancelButton.isHidden = true
        scanningText.isHidden = false
        fruitTypeCollectionView.isHidden = false
        startButton.isHidden = false
        tutorialButton.isHidden = false
        if NilaiSementara.nilaiSementara != 0 {
            viewReview.isHidden = false
            buttonReview.isHidden = false
            reviewNumber.isHidden = false
            reviewLabel.isHidden = false
        }
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didEnterBackground(){
        imageViewTransform = silhouetteImage.layer.presentation()?.affineTransform() ?? .identity
    }
    
    @objc func willEnterForeground(){
        silhouetteImage.transform = imageViewTransform
        silhouetteImage.alpha = 1.0
        scanningText.alpha = 1.0
        animateSilhouette()
    }
    
    /// Reset the variables to default
    func resetVariables(){
        hasSpinned = false
        if !hasScanned{
            nilaiSementara = 0
        }
        helperDelegate.shapeLayer.removeFromSuperlayer()
        nilaiSementara  = 5
        nilaiCounter = 0
        buahCounter = 0
        checkBuahCounter = 0
        isChecking = false
        checkBuah = false
        hasShownResult = false
        isFirstFrame = true
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        helperDelegate.hapticMedium()
        resetVariables()
        showOutlet()
    }
    
    @IBAction func buttonBackToReview(_ sender: Any) {
        moveController()
        Sound.enabled = false
    }
    
    @IBAction func tutorialButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "tutorial", sender: self)
    }
    
    /// Animating the silhouette
    func animateSilhouette(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse, .beginFromCurrentState], animations: {
                self.scanningText.alpha = 0.5
                self.silhouetteImage.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                self.silhouetteImage.alpha = 0.3
            }, completion: nil)
        }
    }
    
    /// Startup the scan
    func startScanning(){
        DispatchQueue.main.async {
            self.checkingLabel.isHidden = false
            self.resetVariables()
            self.hideOutlet()
            self.isChecking = true
            self.hasShownResult = true
            Sound.enabled = true
            self.generator.notificationOccurred(.success)
        }
    }
    
    func checkingResult(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showResult), userInfo: nil, repeats: true)
    }
    
    /// Show the result if has not shown result
    @objc func showResult(){
        isFirstFrame = true
        gantiKeScan()
        
        if !hasShownResult {return}
        view.layer.addSublayer(helperDelegate.shapeLayer)
        
        if nilaiCounter == 5 {
            hasShownResult = false
            self.isChecking = false
            NilaiSementara.nilaiSementara = self.nilaiSementara

            NilaiSementara.previousFruit = namaBuah.text!
            helperDelegate.hapticMedium()
            hasScanned = true
            setupColor()
            showOutlet()
            moveController()
        }
    }
    
    /// Move view controller
    func moveController(){
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultView") as! ResultViewController
        self.addChildViewController(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParentViewController: self)
    }
}

// MARK: Collection View
extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jumlahBuah.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = fruitTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BuahCell
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 6){
            cell?.isUserInteractionEnabled = false
        }
        cell?.imageBuah.image = UIImage(named: "\(jumlahBuah[indexPath.row])Inactive")
        cell?.imageBuahSelected.image = UIImage(named: "\(jumlahBuah[indexPath.row])Selected")
        return cell!
    }
    
    func setBackground(){
        backgroundViginette.frame = CGRect(x: 0, y: view.frame.height - 204, width: view.frame.width, height: 204)
        backgroundViginette.image = UIImage(named: "\(backgroundWarna[2])")
            UIView.animate(withDuration: 5, animations: {
                self.backgroundViginette.alpha = 0
            })
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        helperDelegate.hapticMedium()
        
        let cell = fruitTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BuahCell
        fruitTypeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        silhouetteImage.image = UIImage(named: "\(jumlahBuah[indexPath.row])Sil2")
        dummyImage.image = UIImage(named: "\(jumlahBuah[indexPath.row])Scan")
        namaBuah.text = "\(namaNamaBuah[indexPath.row])"
        backgroundViginette.image = UIImage(named: "\(backgroundWarna[indexPath.row])")
        
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 8
        cell?.clipsToBounds = true
        if cell?.ditengah == true && NilaiSementara.cellDiTengah == true {
            activityIndicator.startAnimating()
            startScanning()
            cell?.ditengah = false
            NilaiSementara.cellDiTengah = false
        } else {
            UIView.animate(withDuration: 0, animations: {
                self.backgroundViginette.alpha = 1
            }) { (true) in
                UIView.animate(withDuration: 5, animations: {
                    self.backgroundViginette.alpha = 0
                })
            }
        }
    }
}

// MARK: Scroll View
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scanningText.isHidden = false
        namaBuah.isHidden = false
        var savedIndex = fruitTypeCollectionView.indexPathsForVisibleItems
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        savedIndex.sort()
        if translation.x > 0{
            if(savedIndex.count == 6){
                fruitTypeCollectionView.selectItem(at: savedIndex[2], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[2])
                print("kanan 6")
            }else if(savedIndex.count <= 5){
                fruitTypeCollectionView.selectItem(at: savedIndex[2], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[2])
                print("kanan 5")
            }else{
                print("index gajelas")
            }
        }else  {
            if(savedIndex.count == 6){
                fruitTypeCollectionView.selectItem(at: savedIndex[3], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[3])
                print("kiri 6")
            }
            else if(savedIndex.count <= 5){
                fruitTypeCollectionView.selectItem(at: savedIndex[2], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[2])
                print("aneh nih")
            } else{
                print("index gajelas")
            }
        }
        helperDelegate.hapticMedium()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scanningText.isHidden = true
        helperDelegate.hapticMedium()
        if let savedIndex = fruitTypeCollectionView.indexPathsForSelectedItems {
            fruitTypeCollectionView.deselectItem(at: savedIndex[0], animated: true)
        }
        namaBuah.isHidden = true
    }
}

// MARK: AVFoundation
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    // MARK: Camera Control
    func CameraControl(){
        let captureSession = AVCaptureSession()
        
        /// add input dan memulai capture di AV foundationnya
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        
        ///membuat layar avfoundationnya fullscreen
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureSession.addInput(input)
        captureSession.startRunning()

        view.layer.addSublayer(previewLayer)
        previewLayer.frame = self.view.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //assign data output dari capture sessionnya
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: view).y / view.frame.height
            let y = 1.0 - touchPoint.location(in: view).x / view.frame.width
            let focusPoint = CGPoint(x: x, y: y)
            
            if let device = AVCaptureDevice.default(for: .video) {
                do {
                    try device.lockForConfiguration()
                    
                    device.focusPointOfInterest = focusPoint
                    device.focusMode = .autoFocus
                    device.focusMode = .continuousAutoFocus
                    //device.focusMode = .locked
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                }
                catch {
                    // just ignore
                }
            }
        }
    }
    
    // MARK: Camera Output
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //coding yang dilakukan saat avfoundation memunculkan output
        if !self.isFirstFrame {return}
        self.isFirstFrame = false
        if !self.isChecking {return}
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        guard let modelJeruk = try? VNCoreMLModel(for: Jeruk().model) else {return}
        guard let modelApel = try? VNCoreMLModel(for: Apel1().model) else {return}
        guard let modelTomat = try? VNCoreMLModel(for: Tomat().model) else {return}
        
        let requestResnet = VNCoreMLRequest(model: model){ (finishReq2, err) in
            guard let resultsResnet = finishReq2.results as? [VNClassificationObservation] else {return}
            guard let firstObservationResnet = resultsResnet.first else {return}
            DispatchQueue.main.async {
                if (((firstObservationResnet.identifier == "orange") && (self.silhouetteImage.image == UIImage(named: "jerukSil2"))) || (((self.silhouetteImage.image == UIImage(named: "tomatoSil2")) || (self.silhouetteImage.image == UIImage(named: "apelSil2"))) && ((firstObservationResnet.identifier == "pomegranate") || (firstObservationResnet.identifier == "Granny Smith") || (firstObservationResnet.identifier == "hip, rose hip, rosehip") || (firstObservationResnet.identifier == "bell pepper")))) && self.buahCounter < 3{
                    self.buahCounter += 1
                    print(firstObservationResnet.identifier, firstObservationResnet.confidence)
                    print(self.buahCounter)
                } else if self.buahCounter >= 3 {
                    self.checkBuah = true
                    print(NilaiSementara.nilaiSementara)
                } else {
                    print(firstObservationResnet.identifier, firstObservationResnet.confidence)
                    self.checkBuahCounter += 1
                }
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([requestResnet])
        
        if !self.checkBuah{return }
        // MARK: modelnya
        DispatchQueue.main.async {
            if self.silhouetteImage.image == UIImage(named: "jerukSil2"){
                let request = VNCoreMLRequest(model: modelJeruk){(finishedReq, err) in
                    guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
                    guard let firstObservation = results.first else { return}
                    print(firstObservation.identifier,firstObservation.confidence)
                    
                    //setelah membuat property resultnya, lakukan scanning
                    if (firstObservation.identifier == "Jeruk Bagus"){
                        self.nilaiSementara += firstObservation.confidence
                    }else if (firstObservation.identifier == "Jeruk Jelek") {
                        self.nilaiSementara -= (firstObservation.confidence * 0.5)
                    }
                    self.nilaiCounter += 1
                }
                try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
                
            }else if self.silhouetteImage.image == UIImage(named: "apelSil2"){
                let requestApel = VNCoreMLRequest(model: modelApel){(finishedReq3, err) in
                    guard let resultApel = finishedReq3.results as? [VNClassificationObservation] else {return}
                    guard let firstObservationApel = resultApel.first else {return}
                    print(firstObservationApel.identifier, firstObservationApel.confidence)
                    
                    if (firstObservationApel.identifier == "Apel Bagus") {
                        self.nilaiSementara += firstObservationApel.confidence
                    }else if (firstObservationApel.identifier == "Apel Jelek"){
                        self.nilaiSementara -= (firstObservationApel.confidence * 0.5)
                    }
                    self.nilaiCounter += 1
                        
                }
                try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([requestApel])
            }else if self.silhouetteImage.image == UIImage(named: "tomatoSil2"){
                let requestTomat = VNCoreMLRequest(model: modelTomat){(finishedReq3, err) in
                    guard let resultTomat = finishedReq3.results as? [VNClassificationObservation] else {return}
                    guard let firstObservationTomat = resultTomat.first else {return}
                    print(firstObservationTomat.identifier, firstObservationTomat.confidence)
                    
                    if (firstObservationTomat.identifier == "Tomat Bagus") {
                        self.nilaiSementara += firstObservationTomat.confidence
                    }else if (firstObservationTomat.identifier == "Tomat Jelek"){
                        self.nilaiSementara -= (firstObservationTomat.confidence * 0.5)
                    }
                    self.nilaiCounter += 1
                }
                try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([requestTomat])
            }
        }
    }
}
