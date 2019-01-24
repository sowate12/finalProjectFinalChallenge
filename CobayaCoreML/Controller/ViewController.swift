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
import CountdownView

class ViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate,UIGestureRecognizerDelegate {

    var loadingLabel : UILabel = UILabel()
    var jumlahBuah = ["","apel","jeruk","tomato",""]
    var timer = Timer()
    var isFirstFrame : Bool = true
    var nilaiSementara : Float = 5
    var totalNilai : Float = 0
    var isChecking : Bool = false
    var checkBuah = false
    var nilaiCounter = 0
    var buahCounter = 0
    var filterCounter = 1
    var hasShownResult = false
    let generator = UINotificationFeedbackGenerator()
    let helperDelegate = AnimationHelper()

    // MARK: IBOutlet
    @IBOutlet weak var silhouetteImage: UIImageView!
    @IBOutlet weak var fruitTypeCollectionView: UICollectionView!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: Life Cycle
    //biar awal awal udah bisa pilih yang kiri, indexnya awalnya langsung diubah ke 5
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = IndexPath(item: 1, section: 0)
        self.fruitTypeCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        silhouetteImage.image = UIImage(named: "apelSil2")
        self.fruitTypeCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fruitTypeCollectionView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        silhouetteImage.image = UIImage(named: "\(jumlahBuah)Sil2")
        fruitTypeCollectionView.delegate = self
        fruitTypeCollectionView.dataSource = self

        // Possible to refactor
        CameraControl()
        timerInterval()
        scanningLabel()
        
        // OK
        checkingResult()
        helperDelegate.addLoading()
        taroView()
  }
    

    func taroView(){
        view.addSubview(fruitTypeCollectionView)
        view.addSubview(startButton)
        view.addSubview(silhouetteImage)
        view.layer.addSublayer(helperDelegate.shapeLayer)
    }
        
    //taro label scanning yang titik titiknya gerak tiap detiknya
    func scanningLabel(){
        loadingLabel.isHidden = true
        loadingLabel.text = "Scanning ."
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { (timer) in
            var string: String {
                switch self.loadingLabel.text {
                case "Scanning .":       return "Scanning .."
                case "Scanning ..":      return "Scanning ..."
                case "Scanning ...":     return "Scanning ."
                default:                return "Scanning"
                }
            }
            self.loadingLabel.text = string
        }
        loadingLabel.textColor = .white
        loadingLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.width - 200, width: 100, height: 100)
//        view.addSubview(loadingLabel)
    }
    
    func hideOutlet(){
        startButton.isHidden = true
        fruitTypeCollectionView.isHidden = true
//        silhouetteImage.isHidden = true
    }
    
    func showOutlet(){
        startButton.isHidden = false
        fruitTypeCollectionView.isHidden = false
        silhouetteImage.isHidden = false
    }
    
    // MARK: Button Start
    @IBAction func buttonStart(_ sender: UIButton) {
        helperDelegate.hapticMedium()
        //reset semua counter untuk scan menjadi 0
        NilaiSementara.nilaiSementara = 0
        self.nilaiSementara = 5
        self.nilaiCounter = 0
        self.buahCounter = 0
        self.checkBuah = false
        let animation1 = CountdownView.Animation.fadeIn
        hideOutlet()
        CountdownView.show(countdownFrom: 2.5  , spin: true, animation: animation1, autoHide: true, completion:  {
            DispatchQueue.main.async {
                self.loadingLabel.isHidden = false
                self.helperDelegate.animateCircle()
                self.helperDelegate.shapeLayer.frame = CGRect(x: self.view.frame.width/2-187.5, y: self.view.frame.height/2-50, width: 100, height: 100)
                
                self.generator.notificationOccurred(.success)
                
                //function setelah countdown selesai, buat bool jadi true untuk menunjukan scan dan result
                self.isChecking = true
                self.hasShownResult = true
            }
            })
      }
    
    // MARK: Camera Control
    func CameraControl(){
        let captureSession = AVCaptureSession()
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        captureSession.startRunning()
        //add input dan memulai capture di AV foundationnya
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = self.view.layer.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //membuat layar avfoundationnya fullscreen
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        //assign data output dari capture sessionnya
    }
    
    func timerInterval(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(handleTimerTick), userInfo: nil, repeats: true)
    }
    
    func checkingResult(){
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showResult), userInfo: nil, repeats: true)
    }
    
    @objc func showResult(){
        
        if !hasShownResult {return}
        NilaiSementara.nilaiSementara = self.nilaiSementara
        print(NilaiSementara.nilaiSementara)
        //tunjukin result setelah beberapa boolean menjadi true, dan scan masing masing objek x kali
        
        if nilaiCounter == 5 {
            
            hasShownResult = false
            self.isChecking = false
            //membuat boolean false untuk scan ulang nanti
            
            showOutlet()
            let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpView") as! PopUpViewController
            self.addChildViewController(popUpVC)
            popUpVC.view.frame = self.view.frame
            self.view.addSubview(popUpVC.view)
            
            //memunculkan viewcontroller lain
            popUpVC.didMove(toParentViewController: self)
        }
    }
    
    @objc func handleTimerTick() {
        isFirstFrame = true
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //coding yang dilakukan saat avfoundation memunculkan output
        if !self.isFirstFrame {return}
        self.isFirstFrame = false
        if !self.isChecking {return}
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        guard let modelJeruk = try? VNCoreMLModel(for: Jeruk100().model) else {return}
        guard let modelApel = try? VNCoreMLModel(for: AppleBagusAppleJelek().model) else {return}

        //assign modelnya
        
        let requestResnet = VNCoreMLRequest(model: model){ (finishReq2, err) in
            guard let resultsResnet = finishReq2.results as? [VNClassificationObservation] else {return}
            guard let firstObservationResnet = resultsResnet.first else {return}
            print(firstObservationResnet.identifier, firstObservationResnet.confidence)
            
            if ((firstObservationResnet.identifier == "orange") || (firstObservationResnet.identifier == "pomegranate") || (firstObservationResnet.identifier == "Granny Smith") || (firstObservationResnet.identifier == "bell pepper")) && self.buahCounter < 3{
                self.buahCounter += 1
                print(self.buahCounter)
            } else if self.buahCounter >= 3 {
                self.checkBuah = true
            }
            
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([requestResnet])
        
        if !self.checkBuah{return }
        // MARK: modelnya
        DispatchQueue.main.async {
            if self.silhouetteImage.image == UIImage(named: "jerukSil2"){
                let request = VNCoreMLRequest(model: modelJeruk)
                {(finishedReq, err) in
                    
                    guard let results = finishedReq.results as? [VNClassificationObservation] else {return}
                    guard let firstObservation = results.first else { return}
                    print(firstObservation.identifier,firstObservation.confidence)
                    
                    //setelah membuat property resultnya, lakukan scanning
                    if (firstObservation.identifier == "Jeruk Bagus"){
                        self.nilaiSementara += firstObservation.confidence
                    }else if (firstObservation.identifier == "Jeruk Jelek") {
                        self.nilaiSementara -= firstObservation.confidence
                    }
                    self.nilaiCounter += 1
                    //lakukan scanningnya, tambah counter, scanning dilakukan tiap detik
                }
                try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
                
            }else if self.silhouetteImage.image == UIImage(named: "apelSil2"){
                let requestApel = VNCoreMLRequest(model: modelApel){(finishedReq3, err) in
                    guard let resultApel = finishedReq3.results as? [VNClassificationObservation] else {return}
                    guard let firstObservationApel = resultApel.first else {return}
                    print(firstObservationApel.identifier, firstObservationApel.confidence)
                    
                    if (firstObservationApel.identifier == "Warna Bagus") {
                        self.nilaiSementara += firstObservationApel.confidence
                    }else if (firstObservationApel.identifier == "Warna Jelek"){
                        self.nilaiSementara -= firstObservationApel.confidence
                    }
                    self.nilaiCounter += 1
                }
                try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([requestApel])
            }
        }
    }
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jumlahBuah.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = fruitTypeCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BuahCell
        cell?.imageBuah.image = UIImage(named: "\(jumlahBuah[indexPath.row])Inactive")

        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == 0 || indexPath.row == 4){
            return false
        }
        return true
    }
    //kalau dipilih langsung ketengah
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fruitTypeCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        silhouetteImage.image = UIImage(named: "\(jumlahBuah[indexPath.row])Sil2")
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        var savedIndex = fruitTypeCollectionView.indexPathsForVisibleItems
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if translation.x > 0{
            // move right
            print("kanan")
            if(savedIndex.count == 4){
                fruitTypeCollectionView.selectItem(at: savedIndex[1], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[1])
            }
            else if(savedIndex.count == 3){
                fruitTypeCollectionView.selectItem(at: savedIndex[1], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[1])
            }
        }
        else  {
            // move left
            print("kiri")
            if(savedIndex.count == 4){
                fruitTypeCollectionView.selectItem(at: savedIndex[2], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[2])
            }
            else if(savedIndex.count == 3){
                fruitTypeCollectionView.selectItem(at: savedIndex[1], animated: true, scrollPosition: .centeredHorizontally)
                self.collectionView(self.fruitTypeCollectionView, didSelectItemAt: savedIndex[1])
            }
        }
    }
}

//
//required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//
//    let gesture = UIGestureRecognizer()
//    gesture.delegate = self // Set Gesture delegate so that shouldRecognizeSimultaneouslyWithGestureRecognizer can be set to true on initialzing the UICollectionView
//}
//
//func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//    return true
//}
//

//
//@objc func rightSwiped()
//{
//    if filterCounter != 0 {
//        filterCounter -= 1
//    }
//    print("right swiped ")
//}
//
//@objc func leftSwiped()
//{
//    if filterCounter != 2 {
//        filterCounter += 1
//    }
//    print("left swiped ")
//}
//
//func taroGesture(){
//    //------------right  swipe gestures in collectionView--------------//
//    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.rightSwiped))
//    swipeRight.direction = UISwipeGestureRecognizerDirection.right
//
//    //-----------left swipe gestures in collectionView--------------//
//    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwiped))
//    swipeLeft.direction = UISwipeGestureRecognizerDirection.left
//}
//    @IBOutlet weak var pilihBuah: UICollectionView!
//extension ViewController : UIScrollViewDelegate
//{
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
//    {
//        let layout = self.pilihBuah.collectionViewLayout as! UICollectionViewFlowLayout
//
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        print(index)
//        let roundedIndex = round(index)
//
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//
//        let indexPet = self.pilihBuah.indexPathForItem(at: offset)
//        self.pilihBuah.selectItem(at: indexPet, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
//
//    }
//}





//func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return jumlahBuah.count
//    //objek dalam collection view
//}
//
//func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = pilihBuah.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BuahCell
//    cell?.imageBuah.image = UIImage(named: "\(jumlahBuah[indexPath.row])")
//    cell?.contentView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
//    cell?.contentView.layer.cornerRadius = 38
//    cell?.contentView.layer.masksToBounds = true
//    //assign image ke dalam cell di collection view dan ubah ubah ukurannya
//    return cell!
//} kasksaksaks
//
//func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//    return true
//}
//
//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//}
//            self.viewScore.isHidden = false
//            self.dismissButton.isHidden = false
//            self.isChecking = false
//            self.dismissButton.frame = CGRect(x: 30, y: 70, width: 50, height: 50)
//            self.dismissButton.backgroundColor = .white
//            self.dismissButton.layer.cornerRadius = 10
//            self.dismissButton.layer.masksToBounds = true
//            self.view.addSubview(self.dismissButton)
//
//            let dismissButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissButtonDidTap))
//            self.dismissButton.addGestureRecognizer(dismissButtonRecognizer)
//
//            let previewLayer = self.viewScore
//            let x = self.view.frame.width / 2 - 75
//            let y = self.view.frame.height - 500
//            previewLayer?.frame = CGRect(x: x, y: y, width: 150, height: 150)
//            previewLayer?.backgroundColor = .white
//            previewLayer?.layer.cornerRadius = 10
//            previewLayer?.layer.masksToBounds = true
//            self.view.addSubview(previewLayer!)
//
//            self.scoreLabel.text = String(format: "%.2f", self.nilaiSementara*10/self.timerTick)
//
//            self.nilaiSementara = 0
//a aa a aa aa
