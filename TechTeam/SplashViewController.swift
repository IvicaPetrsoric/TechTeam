//
//  ViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 03/02/2021.
//

import UIKit

class SplashViewController: UIViewController, URLSessionDownloadDelegate, CAAnimationDelegate {

    
    let blueColor = UIColor(red: 5/255, green: 140/255, blue: 206/255, alpha: 1)
    let greenColor = UIColor(red: 153/255, green: 191/255, blue: 74/255, alpha: 1)

    
    var shapeLayer = CAShapeLayer()
    
    var puslingLayer: CAShapeLayer!
    
    var trackLayer: CAShapeLayer!
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Tech\nTeam"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 44)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
//    override var preferredStatusBarStyle: UIStatusBarStyle{
//        return .lightContent
//    }
    
    private func setupNotificationObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    // kada se ode u home da se aktivira ponovo anim
    @objc private func handleEnterForeground(){
        animatePuslingLayer()
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor, radius: CGFloat = 100) -> CAShapeLayer{
        let circularPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle:  0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let layer = CAShapeLayer()
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 10
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        layer.position = view.center
        return layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotificationObservers()
        
        view.backgroundColor = .inactiveColor
        
        setupCircleLayers()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        view.addSubview(percentageLabel)
        percentageLabel.anchorCenterSuperview()
        
    }
    
    private func setupPercentageLayer(){
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    private func setupCircleLayers(){
        //        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle:  -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle:  0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        puslingLayer = createCircleShapeLayer(strokeColor: .primaryColorFaded,
                                              fillColor: .primaryColorFaded)
        view.layer.addSublayer(puslingLayer)
        
        let trackLayer = createCircleShapeLayer(strokeColor: .primaryColorFaded, fillColor: .inactiveColor)
        view.layer.addSublayer(trackLayer)
        
        animatePuslingLayer()
        
        //        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle:  -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer = createCircleShapeLayer(strokeColor: .primaryColor, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
//        animateStroke()

    }
    
    private func animatePuslingLayer(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        puslingLayer.add(animation, forKey: "pulsing")
    }
    
    
    
    @objc func handleTap(){
        beginDownloadingFile()
        animateCircle()
//        animateStroke()
        
//        UIView.animate(withDuration: 3) {
//            self.shapeLayer.strokeEnd = 1
//        }
        //        animateCircle()
    }
    
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    private func beginDownloadingFile() {
        return
        print("Attempting to download file")
        
        shapeLayer.strokeEnd = 0
        
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
//            self.percentageLabel.text = "\(Int(percentage * 100))%"
//            self.shapeLayer.strokeEnd = 1
        }
        
//        print(percentage)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.delegate = self
        basicAnimation.setValue("shake", forKey: "animationID")
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationID = anim.value(forKey: "animationID") as? String {
            if animationID == "shake" {
                print("FINISHED ANIATION")
                 
                animateCenter()
//                puslingLayer.removeAllAnimations()
            }
        }
    }
    
    private func animateCenter() {
//        return
        let trackLayer = createCircleShapeLayer(strokeColor: .backgroundColor, fillColor: .backgroundColor, radius: 10)
        view.layer.addSublayer(trackLayer)
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 30
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards


//        animation.autoreverses = true
//        animation.repeatCount = Float.infinity
        
        trackLayer.add(animation, forKey: "pulsing")
    }
    

    
}


