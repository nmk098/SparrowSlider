//
//  ViewController.swift
//  SparrowSlider
//
//  Created by Никита Курюмов on 07.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var rectangleView: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.frame = CGRect(
            x: view.layoutMargins.left,
            y: 75,
            width: 66,
            height: 66
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var slider: UISlider = {
        var slider = UISlider()
        slider.thumbTintColor = UIColor(named: "AccentColor")
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = UIColor(named: "track")
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    var animator: UIViewPropertyAnimator!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        NSLayoutConstraint.activate([
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.layoutMargins.left),
            slider.widthAnchor.constraint(equalToConstant: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right),
            slider.heightAnchor.constraint(equalToConstant: 20),
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "backColor")
        view.addSubview(rectangleView)
        view.addSubview(slider)

        rectangleView.backgroundColor = UIColor(named: "AccentColor")
        rectangleView.layer.cornerRadius = 10
        
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(sliderActivated), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderNotTouched), for: .touchUpInside)
        
        animator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut) {
            self.rectangleView.center.x = self.view.frame.width
            self.rectangleView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2).scaledBy(x: 1.5, y: 1.5)
            self.rectangleView.frame.origin = CGPoint(
                x: CGFloat(self.view.frame.width - self.rectangleView.frame.width - self.view.layoutMargins.right),
                y: 75)
        }
    }
    
    @objc func sliderActivated() {
        animator.fractionComplete = CGFloat(slider.value)
    }
    @objc func sliderNotTouched() {
        UIView.animate(withDuration: 0.62, delay: 0) {
            self.animator.pausesOnCompletion = true
            self.animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            self.slider.setValue(1, animated: true)
        }
    }
}

