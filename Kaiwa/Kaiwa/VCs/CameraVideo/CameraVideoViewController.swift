//
//  CameraVideoViewController.swift
//  PupsterSocial
//
//  Created by Tomoki Takasawa on 7/7/18.
//  Copyright © 2018 Tomoki Takasawa. All rights reserved.
//

import Foundation
import UIKit
import SwiftyCam

class CameraVideoViewController: SwiftyCamViewController, SwiftyCamViewControllerDelegate {
    
//    @IBOutlet weak var captureButton    : SwiftyRecordButton!
//    @IBOutlet weak var flipCameraButton : UIButton!
//    @IBOutlet weak var flashButton      : UIButton!
    
//    let captureButton: SwiftyRecordButton = {
//        let b = SwiftyRecordButton()
//        //b.translatesAutoresizingMaskIntoConstraints = false
//        return b
//    }()
    
    let flipCameraButton : UIButton = {
        let b = SwiftyRecordButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.blue
        return b
    }()
    let flashButton: UIButton = {
        let b = SwiftyRecordButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.red
        return b
    }()
    
    let exitButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor.white
        return b
    }()
    
    let captureButton = SwiftyRecordButton(frame: CGRect(x: 100, y: 100, width: 75, height: 75))
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.addSubview(captureButton)
        self.view.addSubview(flipCameraButton)
        self.view.addSubview(flashButton)
        self.view.addSubview(exitButton)
        
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        //captureButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        //captureButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //captureButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        //captureButton.autoresizingMask = [UIViewAutoresizing.flexibleLeftMargin, UIViewAutoresizing.flexibleRightMargin, UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin]
        
        captureButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captureButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        captureButton.heightAnchor.constraint(equalToConstant: 75).isActive = true
        captureButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        flipCameraButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        flipCameraButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        flipCameraButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flipCameraButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        flashButton.rightAnchor.constraint(equalTo: self.flipCameraButton.leftAnchor, constant: -20).isActive = true
        flashButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        flashButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flashButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        exitButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        exitButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        exitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        exitButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        flipCameraButton.addTarget(self, action: #selector(cameraSwitchTapped), for: .touchUpInside)
        flashButton.addTarget(self, action: #selector(toggleFlashTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        
        captureButton.addTarget(self, action: #selector(self.centerButtonPressed), for: .touchUpInside)
        captureButton.isSelected = false
        captureButton.isUserInteractionEnabled = true
        //captureButton.buttonEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        shouldPrompToAppSettings = true
        cameraDelegate = self
        maximumVideoDuration = 10.0
        shouldUseDeviceOrientation = true
        allowAutoRotate = true
        audioEnabled = true
        
        // disable capture button until session starts
        //captureButton.buttonEnabled = false
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func centerButtonPressed(){
        print("pressed")
        if (captureButton.isSelected == false) {
            captureButton.growButton()
            captureButton.isSelected = true
            displayOverlayView()
        }else{
            captureButton.shrinkButton()
            captureButton.isSelected = false
            removeLayer()
        }
    }
    let coverLayer = CALayer()
    func displayOverlayView(){
        
        coverLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        coverLayer.frame = view.layer.bounds
        view.layer.insertSublayer(coverLayer, at: 1)
        
        let testLabel = UILabel()
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(testLabel)
        testLabel.bringSubview(toFront: testLabel)
        
        testLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        testLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        testLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        testLabel.text = "Hello world"
        testLabel.textColor = .white
    }
    func removeLayer(){
        self.coverLayer.removeFromSuperlayer()
    }
    
    @objc func exitTapped(){
        if let navigator = self.navigationController {
            navigator.popViewController(animated: true)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //captureButton.delegate = self
    }
    
    func swiftyCam(_ swiftyCam: SwiftyCamViewController, didFocusAtPoint point: CGPoint) {
        print("Did focus at point: \(point)")
        focusAnimationAt(point)
    }
    
    func swiftyCamDidFailToConfigure(_ swiftyCam: SwiftyCamViewController) {
        let message = NSLocalizedString("Unable to capture media", comment: "Alert message when something goes wrong during capture session configuration")
        let alertController = UIAlertController(title: "AVCam", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert OK button"), style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    
//    @IBAction func cameraSwitchTapped(_ sender: Any) {
//        switchCamera()
//    }
    
    @objc func cameraSwitchTapped(_ sender: Any) {
        switchCamera()
    }
    
//    @IBAction func toggleFlashTapped(_ sender: Any) {
//        flashEnabled = !flashEnabled
//        toggleFlashAnimation()
//    }
    
    @objc func toggleFlashTapped(_ sender: Any) {
        flashEnabled = !flashEnabled
        toggleFlashAnimation()
    }
}

extension CameraVideoViewController {
    
    fileprivate func hideButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 0.0
            self.flipCameraButton.alpha = 0.0
        }
    }
    
    fileprivate func showButtons() {
        UIView.animate(withDuration: 0.25) {
            self.flashButton.alpha = 1.0
            self.flipCameraButton.alpha = 1.0
        }
    }
    
    fileprivate func focusAnimationAt(_ point: CGPoint) {
        let focusView = UIImageView(image: #imageLiteral(resourceName: "recordButton"))
        focusView.center = point
        focusView.alpha = 0.0
        view.addSubview(focusView)

        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
            focusView.alpha = 1.0
            focusView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (success) in
            UIView.animate(withDuration: 0.15, delay: 0.5, options: .curveEaseInOut, animations: {
                focusView.alpha = 0.0
                focusView.transform = CGAffineTransform(translationX: 0.6, y: 0.6)
            }) { (success) in
                focusView.removeFromSuperview()
            }
        }
    }
    
    fileprivate func toggleFlashAnimation() {
//        if flashEnabled == true {
//            flashButton.setImage(#imageLiteral(resourceName: "flash"), for: UIControlState())
//        } else {
//            flashButton.setImage(#imageLiteral(resourceName: "flashOutline"), for: UIControlState())
//        }
    }
}
