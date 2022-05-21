//
//  ViewController.swift
//  HomeWork-12_Kiselev_Boris-MobDevFactory
//
//  Created by Борис Киселев on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var secondTimer = Timer()
    var count = 60
    var secondCount = 25
    var redAncor = false
    var greenAncor = false

    
    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = "\(count / 60) : \(count % 60)"
        timeLabel.font = UIFont.systemFont(ofSize: 35)
        timeLabel.textColor = .red
        timeLabel.textAlignment = .center
        
        return timeLabel
    }()
    
    private lazy var secondTimeLabel: UILabel = {
        let secondTimeLabel = UILabel()
        secondTimeLabel.text = "\(secondCount / 60) : \(secondCount % 60)"
        secondTimeLabel.font = UIFont.systemFont(ofSize: 35)
        secondTimeLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        secondTimeLabel.textAlignment = .center
        
        return secondTimeLabel
    }()
    
    private lazy var startWorkButton: UIButton = {
        let startWorkButton = UIButton()
        let startWorkButtonImage = UIImage(named: "redStartButton")
        startWorkButton.setImage(startWorkButtonImage, for: .normal)
        startWorkButton.addTarget(self, action: #selector(startWork), for: .touchUpInside)
        
        
        return startWorkButton
    }()
    
    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        let pauseImage = UIImage(named: "redPauseButton")
        pauseButton.setImage(pauseImage, for: .normal)
        pauseButton.isHidden = true
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        
        
        return pauseButton
    }()
    
    
    private lazy var chillButton: UIButton = {
        let chillButton = UIButton()
        let chillImage = UIImage(named: "greenStartButton")
        chillButton.setImage(chillImage, for: .normal)
        chillButton.addTarget(self, action: #selector(startChill), for: .touchUpInside)
        
        return chillButton
    }()
    
    private lazy var greenPauseButton: UIButton = {
        let greenPauseButton = UIButton()
        let greenPause = UIImage(named: "greenPauseButton")
        greenPauseButton.setImage(greenPause, for: .normal)
        greenPauseButton.isHidden = true
        greenPauseButton.addTarget(self, action: #selector(greenPauseFunc), for: .touchUpInside)
        
        return greenPauseButton
    }()
    
    private lazy var timeLabelStackview: UIStackView = {
        let timeLabelStackview = UIStackView()
        timeLabelStackview.axis = .vertical
        timeLabelStackview.spacing = 30
        timeLabelStackview.alignment = UIStackView.Alignment.center
        
        return timeLabelStackview
    }()
    
    private lazy var secondTimeLabelStackview: UIStackView = {
        let secondTimeLabelStackview = UIStackView()
        secondTimeLabelStackview.axis = .vertical
        secondTimeLabelStackview.spacing = 30
        
        return secondTimeLabelStackview
    }()
    
    let shapeCircle = CAShapeLayer()
    let secondShapeCircle = CAShapeLayer()
    
    
    // MARK: - Timer  function for buttons
    
    @objc func startWork() {
        if redAncor == true {
            resumeAnimation()
            redAncor = false
            startWorkButton.isHidden = true
            pauseButton.isHidden = false
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        } else {
        firstCircleAnimation()
        startWorkButton.isHidden = true
        pauseButton.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(step), userInfo: nil, repeats: true)
    }
}
    
    @objc func step() {
        
        if count > 0 {
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            count -= 1
            timeLabel.text = "\(minutes) : \(seconds)"
        } else if count == 0 {
            timer.invalidate()
            timeLabel.text = "00 : 00"
            startWorkButton.isHidden = false
            pauseButton.isHidden = true
            count = 60
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            timeLabel.text = "\(minutes) : \(seconds)"
            startChill()
            
        }
    }
    
    @objc func pause() {
        timer.invalidate()
        pauseAnimation()
        redAncor = true
        startWorkButton.isHidden = false
        pauseButton.isHidden = true
    }
    
    
    @objc func startChill() {
        if greenAncor == true {
            resumeAnimation()
            greenAncor = false
            chillButton.isHidden = true
            greenPauseButton.isHidden = false
            secondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondStep), userInfo: nil, repeats: true)
        } else {
        secondCircleAnimation()
        chillButton.isHidden = true
        greenPauseButton.isHidden = false
        secondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(secondStep), userInfo: nil, repeats: true)
        
    }
    }
    
    @objc func secondStep() {
        if secondCount > 0 {
            let minutes = String(secondCount / 60)
            let seconds = String(secondCount % 60)
            secondCount -= 1
            secondTimeLabel.text = "\(minutes) : \(seconds)"
        } else if secondCount == 0 {
            secondTimer.invalidate()
            secondTimeLabel.text = "00 : 00"
            greenPauseButton.isHidden = true
            chillButton.isHidden = false
            secondCount = 25
            let minutes = String(secondCount / 60)
            let seconds = String(secondCount % 60)
            secondTimeLabel.text = "\(minutes) : \(seconds)"
            startWork()
            
        }
    }
    
    @objc func greenPauseFunc() {
        greenAncor = true
        secondTimer.invalidate()
        pauseAnimation()
        chillButton.isHidden = false
        greenPauseButton.isHidden = true
    }
    
    
    // MARK: - Animation function
    
    func animationCircular() {
        let center = timeLabelStackview.center
        let circularPath = UIBezierPath(arcCenter: center, radius: 90,startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
        
        shapeCircle.path = circularPath.cgPath
        shapeCircle.lineWidth = 10
        shapeCircle.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        shapeCircle.strokeEnd = 1
        shapeCircle.lineCap = CAShapeLayerLineCap.round
        shapeCircle.strokeColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
        
    }
    
    func secondAnimation() {
        let centerS = secondTimeLabelStackview.center
        
        let circularPathTwo = UIBezierPath(arcCenter: centerS, radius: 90, startAngle: CGFloat(-Double.pi / 2), endAngle: CGFloat(3 * Double.pi / 2), clockwise: true)
        
        secondShapeCircle.path = circularPathTwo.cgPath
        secondShapeCircle.lineWidth = 10
        secondShapeCircle.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        secondShapeCircle.strokeEnd = 1
        secondShapeCircle.lineCap = CAShapeLayerLineCap.round
        secondShapeCircle.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).cgColor
        
    }
    
    func firstCircleAnimation() {
        let firstCircleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        firstCircleAnimation.toValue = 0
        firstCircleAnimation.duration = CFTimeInterval(count)
        firstCircleAnimation.fillMode = CAMediaTimingFillMode.forwards
        firstCircleAnimation.isRemovedOnCompletion = true
        firstCircleAnimation.speed = 0.99
        shapeCircle.add(firstCircleAnimation, forKey: "firstCircleAnimation")
    }
    
    func secondCircleAnimation() {
        let secondCircleAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        secondCircleAnimation.toValue = 0
        secondCircleAnimation.duration = CFTimeInterval(secondCount)
        secondCircleAnimation.fillMode = CAMediaTimingFillMode.forwards
        secondCircleAnimation.isRemovedOnCompletion = true
        secondCircleAnimation.speed = 0.96
        secondShapeCircle.add(secondCircleAnimation, forKey: "secondCircleAnimation")
    }
    
    func pauseAnimation() {
        let pausedTime = view.layer.convertTime(CACurrentMediaTime(), from: nil)
        view.layer.speed = 0
        view.layer.timeOffset = pausedTime
    }

    func resumeAnimation() {
        let pausedTime = view.layer.timeOffset
        view.layer.speed = 1
        view.layer.timeOffset = 0
        view.layer.beginTime = 0
        let timeSincePause = view.layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        view.layer.beginTime = timeSincePause
    }
    // MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.animationCircular()
        self.secondAnimation()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupHierarchy()
        setupLayout()
        setupView()
    
    }
    
    //MARK: - Settings
    
    private func setupHierarchy() {
        view.layer.addSublayer(shapeCircle)
        view.layer.addSublayer(secondShapeCircle)
        view.addSubview(timeLabelStackview)
        view.addSubview(secondTimeLabelStackview)
        timeLabelStackview.addArrangedSubview(timeLabel)
        timeLabelStackview.addArrangedSubview(startWorkButton)
        timeLabelStackview.addArrangedSubview(pauseButton)
        secondTimeLabelStackview.addArrangedSubview(secondTimeLabel)
        secondTimeLabelStackview.addArrangedSubview(chillButton)
        secondTimeLabelStackview.addArrangedSubview(greenPauseButton)
        
    }
    
    private func setupLayout() {

        timeLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        timeLabelStackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        timeLabelStackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        timeLabelStackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        timeLabelStackview.alignment = .center
        
        secondTimeLabelStackview.translatesAutoresizingMaskIntoConstraints = false
        secondTimeLabelStackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140).isActive = true
        secondTimeLabelStackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        secondTimeLabelStackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        secondTimeLabelStackview.alignment = .center
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
    }
}

