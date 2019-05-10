//
//  ScannerViewController.swift
//  brcd
//
//  Created by Mac User on 24.04.2019.
//  Copyright © 2019 Mac User. All rights reserved.
//

import AVFoundation
import UIKit


class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "QR Code", image: UIImage(named: "if_shopping"), tag: 2)
    }
    
    
    
    class CameraView: UIView {
        override class var layerClass: AnyClass {
            get {
                return AVCaptureVideoPreviewLayer.self
            }
        }
        
        
        override var layer: AVCaptureVideoPreviewLayer {
            get {
                return super.layer as! AVCaptureVideoPreviewLayer
            }
        }
    }
    
    
    var cameraView: CameraView!
    override func loadView() {
        cameraView = CameraView()
        view = cameraView
        
    }
    let session = AVCaptureSession()
    let sessionQueue = DispatchQueue(label: AVCaptureSession.self.description(), attributes: [], target: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        session.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(for: .video)
        
        if (videoDevice != nil) {
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!)
            
            if (videoDeviceInput != nil) {
                if (session.canAddInput(videoDeviceInput!)) {
                    session.addInput(videoDeviceInput!)
                }
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (session.canAddOutput(metadataOutput)) {
                session.addOutput(metadataOutput)
                
                metadataOutput.metadataObjectTypes = [
                    .ean13,
                    .ean8,
                    .qr,
                    .code128,
                    .upce,
                    .code39,
                    .code39Mod43,
                    .code93,
                    .aztec,
                    .pdf417,
                    .itf14,
                    .interleaved2of5,
                    .dataMatrix
                ]
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            }
        }
        
        
        session.commitConfiguration()
        
        cameraView.layer.session = session
        cameraView.layer.videoGravity = .resizeAspectFill
        let videoOrientation: AVCaptureVideoOrientation
        switch UIApplication.shared.statusBarOrientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeLeft
            
        case .landscapeRight:
            videoOrientation = .landscapeRight
            
        default:
            videoOrientation = .portrait
        }
        
        cameraView.layer.connection?.videoOrientation = videoOrientation
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sessionQueue.async {
            self.session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sessionQueue.async {
            self.session.stopRunning()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Update camera orientation
        let videoOrientation: AVCaptureVideoOrientation
        switch UIDevice.current.orientation {
        case .portrait:
            videoOrientation = .portrait
            
        case .portraitUpsideDown:
            videoOrientation = .portraitUpsideDown
            
        case .landscapeLeft:
            videoOrientation = .landscapeRight
            
        case .landscapeRight:
            videoOrientation = .landscapeLeft
            
        default:
            videoOrientation = .portrait
        }
        
        cameraView.layer.connection?.videoOrientation = videoOrientation
    }
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        if (metadataObjects.count > 0 && metadataObjects.first is AVMetadataMachineReadableCodeObject) {
            
            let scan = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            let alertController = UIAlertController(title: "Barkod Okundu!", message: scan.stringValue, preferredStyle: .alert)
            
            /*let detail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
            
            detail.Barkod = scan.stringValue*/
            
            alertController.addTextField { (textField) in
                textField.text = scan.stringValue
                textField.placeholder = "Enter Text Here"
            }
                        
            alertController.addAction(UIAlertAction(title: "İptal", style: .default, handler: { _ in
            }))
            
            alertController.addAction(UIAlertAction(title: "Detay", style: .default, handler:{ _ in
                
                self.performSegue(withIdentifier: "detail", sender: nil)
            }))
            
            present(alertController, animated: true, completion: nil)

        }
    }
    
    
     /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
             if(segue.identifier == "detail"){
             let detailVC = segue.destination as! DetailViewController
             detailVC.Barkod = scan.stringValue
         }
     }*/
}
