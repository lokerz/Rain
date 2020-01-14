//
//  ViewController.swift
//  Rain
//
//  Created by Ridwan Abdurrasyid on 15/05/19.
//  Copyright © 2019 Mentimun Mulus. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController{
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var breathButton: UIButton!
    @IBOutlet weak var triangleButton: UIButton!
    
    let sky = GradientView()
    let fog = GradientView()
    let fog2 = GradientView()
    let rain = ParticleView()
    
    let maximumRaindrop : CGFloat = 400
    let cover = UIView()
    let circle = UIView()
    let breathLabel = UILabel()
    let arrow = UIImageView()
    let hand = UIImageView()
    let handImage = UIImage(named: "hand")

    
    let skyColor = #colorLiteral(red: 0.2823529412, green: 0.7019607843, blue: 0.7490196078, alpha: 1)
    let skyEndColor = #colorLiteral(red: 0.2046394944, green: 0.2492148876, blue: 0.3412051201, alpha: 1)
    let startFogColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0)
    let backFogColor = #colorLiteral(red: 0.5450980392, green: 0.8509803922, blue: 0.7647058824, alpha: 1)
    let frontFogColor = #colorLiteral(red: 0.870849371, green: 0.9477309585, blue: 0.7419791222, alpha: 0.9)
    let rainColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    let lightRainDic = "light"
    let heavyRainDic = "heavy"
    let birdSongDic = "bird"
    var animating = false
    let skyScale: CGFloat = 2
    
    var timer : Timer!
    var triangleIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        triangleButton.alpha = 0
        triangleButton.transform = CGAffineTransform(translationX: 116, y: 0)
        
        helpButton.backgroundColor = backFogColor.withAlphaComponent(0.5)
        helpButton.setTitleColor(frontFogColor, for: .normal)
        helpButton.layer.cornerRadius = 25
        helpButton.alpha = 0
        helpButton.transform = CGAffineTransform(translationX: 400, y: 0)
        
        breathButton.backgroundColor = backFogColor.withAlphaComponent(0.5)
        breathButton.layer.cornerRadius = 25
        breathButton.alpha = 0
        breathButton.transform = CGAffineTransform(translationX: 200, y: 0)
        
        sky.startColor = skyColor
        sky.endColor = skyEndColor
        sky.animated = true
        sky.translatesAutoresizingMaskIntoConstraints = false
        sky.transform = CGAffineTransform(translationX: 0, y: -view.frame.height/2)
        
        fog.startColor = startFogColor
        fog.endColor = backFogColor
        fog.animated = true
        fog.opacityAnimated = true
        fog.translatesAutoresizingMaskIntoConstraints = false
        
        fog2.startColor = startFogColor
        fog2.endColor = frontFogColor
        fog2.animated = true
        fog2.reversed = true
        fog2.opacityAnimated = true
        fog2.translatesAutoresizingMaskIntoConstraints = false
        
        rain.color = rainColor
        rain.particleImage = UIImage(named: "RainDrop")
        rain.particleImage2 = UIImage(named: "RainDropEnd")
        rain.translatesAutoresizingMaskIntoConstraints = false
        
        breathLabel.text = "Breathe in"
        breathLabel.textColor = skyEndColor
        breathLabel.textAlignment = .center
        breathLabel.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        breathLabel.alpha = 0
        breathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        circle.backgroundColor = backFogColor
        circle.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        circle.layer.cornerRadius = 125
        circle.alpha = 1
        circle.translatesAutoresizingMaskIntoConstraints = false
        
        cover.backgroundColor = skyEndColor
        cover.alpha = 1
        cover.translatesAutoresizingMaskIntoConstraints = false
        
        arrow.image = UIImage(named: "arrow")
        arrow.alpha = 0
        arrow.translatesAutoresizingMaskIntoConstraints = false
        
        hand.image = handImage
        hand.alpha = 0
        hand.translatesAutoresizingMaskIntoConstraints = false
        
        //View Hierarchy
        view.addSubview(sky)
        view.addSubview(fog)
        view.addSubview(arrow)
        view.addSubview(rain)
        view.addSubview(hand)
        view.addSubview(fog2)
        view.addSubview(cover)
        view.addSubview(circle)
        view.addSubview(breathLabel)
        
        addGesture()
        animateLabel()
        animateCircle()

        NSLayoutConstraint.activate([
            sky.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sky.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sky.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2),
            sky.topAnchor.constraint(equalTo: view.topAnchor),
            
            cover.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cover.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cover.topAnchor.constraint(equalTo: view.topAnchor),
            cover.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            circle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circle.widthAnchor.constraint(equalToConstant: 250),
            circle.heightAnchor.constraint(equalToConstant: 250),
            
            breathLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breathLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breathLabel.topAnchor.constraint(equalTo: view.topAnchor),
            breathLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fog.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fog.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fog.topAnchor.constraint(equalTo: view.topAnchor),
            fog.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            fog2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fog2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fog2.topAnchor.constraint(equalTo: view.topAnchor),
            fog2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rain.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rain.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rain.topAnchor.constraint(equalTo: view.topAnchor),
            rain.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            arrow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arrow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            arrow.topAnchor.constraint(equalTo: view.topAnchor),
            arrow.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            arrow.widthAnchor.constraint(equalToConstant: view.frame.width/5),
            arrow.heightAnchor.constraint(equalTo: arrow.widthAnchor),
            ])
        
    }
    
    func startMusic(){
        MusicPlayer.shared.addPlayer("Sound/Light_Rain_2", lightRainDic)
        MusicPlayer.shared.addPlayer("Sound/Rain_Heavy_Loud", heavyRainDic)
        MusicPlayer.shared.addPlayer("Sound/Bird", birdSongDic)
        MusicPlayer.shared.fadeInSound(lightRainDic, 0.8)
    }
    
    func animateLabel(){
        UIView.animate(withDuration: 3, delay: 1, options: .curveEaseIn,  animations: {
                self.breathLabel.alpha = 1
            }) { _ in
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                    self.breathLabel.alpha = 0
                }) { _ in
                    self.breathLabel.text = "Breathe out"
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                        self.breathLabel.alpha = 1
                    }){ _ in
                        self.startMusic()
                        self.view.bringSubviewToFront(self.triangleButton)
                        self.view.bringSubviewToFront(self.helpButton)
                        self.view.bringSubviewToFront(self.breathButton)
                        UIView.animate(withDuration: 3, delay: 1, options: .curveEaseOut, animations: {
                            self.breathLabel.alpha = 0
                            self.cover.alpha = 0

                        }){ _ in
                            UIView.animate(withDuration: 0.5, animations: {
                                self.triangleButton.alpha = 0.15
                                self.helpButton.alpha = 0.8
                                self.breathButton.alpha = 0.8
                            })
                        }
                    }
                }
            }
    }
    
    func animateCircle(){
        UIView.animate(withDuration: 4.5, delay: 1, options: .curveEaseIn,  animations: {
            self.circle.alpha = 1
            self.circle.transform = CGAffineTransform(scaleX: 6, y: 6)
        }){ _ in
            UIView.animate(withDuration: 4.5, delay: 0 , options: .curveEaseOut, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.circle.alpha = 0.05
            }){ _ in
                self.circle.alpha = 0.05
                UIView.animate(withDuration: 5, delay: 0, options: [.autoreverse, .repeat], animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.circle.alpha = 0.2
                })
            }
        }
    }
    
    @IBAction func triangleButtonAction(_ sender: UIButton) {
        if triangleIndex == 0 {
            triangleIndex = 1
            UIView.animate(withDuration: 0.2, animations: {
                self.triangleButton.alpha = 0.4
            }) { _ in
                UIView.animate(withDuration: 1, animations: {
                    self.triangleButton.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.helpButton.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.breathButton.transform = CGAffineTransform(translationX: 0, y: 0)
                    }){ _ in
                        UIView.animate(withDuration: 0.5){
                            self.triangleButton.transform = CGAffineTransform(rotationAngle: .pi)
                        }
                }
            }
        }else{
            triangleIndex = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.triangleButton.transform = CGAffineTransform(rotationAngle: 0)
            }){ _ in
                UIView.animate(withDuration: 1, animations: {
                    self.triangleButton.transform = CGAffineTransform(translationX: 116, y: 0)
                    self.helpButton.transform = CGAffineTransform(translationX: 400, y: 0)
                    self.breathButton.transform = CGAffineTransform(translationX: 200, y: 0)
                }){ _ in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.triangleButton.alpha = 0.2
                    })
                }
            }
        }
    }
    
    @IBAction func helpButtonAction(_ sender: UIButton) {
        breathButton.isEnabled = false
        helpButton.isEnabled = false
        triangleButton.isEnabled = false
        circle.isHidden = true
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.2) {
            self.breathButton.alpha = 0.4
            self.helpButton.alpha = 0.4
            self.triangleButton.alpha = 0.2
        }
        animateArrow()
    }
    
    @IBAction func breathButtonAction(_ sender: UIButton) {
            self.circle.isHidden = !self.circle.isHidden
    }
    
    func animateArrow(){
        hand.center.y = view.center.y
        hand.center.x = view.center.x + 40
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.changeAnimateVal), userInfo: nil, repeats: true)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.arrow.alpha = 0.8
            self.hand.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut, animations: {
                self.hand.center.y = 100
            }){ _ in
                self.soundCalculate(0)
                UIView.animate(withDuration: 5, delay: 0.5, options: .curveEaseInOut, animations: {
                    self.hand.center.y = 800
                }){ _ in
                    self.soundCalculate(1)
                    UIView.animate(withDuration: 3, delay: 0.5, options: .curveEaseInOut, animations: {
                        self.hand.center.y = self.view.center.y
                    }){ _ in
                        UIView.animate(withDuration: 1, delay : 0.5, options: .curveEaseInOut, animations:  {
                            self.breathButton.alpha = 0.8
                            self.helpButton.alpha = 0.8
                            self.triangleButton.alpha = 0.4
                            self.arrow.alpha = 0
                            self.hand.alpha = 0
                        }){ _ in
                            self.timer.invalidate()
                            self.soundCalculate(0.4)
                            self.breathButton.isEnabled = true
                            self.helpButton.isEnabled = true
                            self.triangleButton.isEnabled = true
                            self.circle.isHidden = false
                            self.view.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
    }
    
    @objc func changeAnimateVal (){
        let handRect = hand.layer.presentation()
        var percentage = (handRect?.frame.minY)! / view.frame.height
        let intensity = percentage * maximumRaindrop - maximumRaindrop/10
        
        //rain
        rain.rainIntensity = Float(intensity < 0 ? 0 : intensity)
        rain.layoutSubviews()
        
        //sky
        if percentage < 0.2 {
            percentage = 0
        }else if percentage > 0.8 {
            percentage = 1
        }
        
        UIView.animate(withDuration: 1) {
            self.sky.transform = CGAffineTransform(translationX: 0,
                                                   y: -percentage * self.view.frame.height
            )
        }
    }
}







//////////////////////////

extension ViewController : UIGestureRecognizerDelegate {
    
    func addGesture() {
        let panSwipe = UIPanGestureRecognizer(target: self, action: #selector(changeVal))
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeVal))
        
        panSwipe.maximumNumberOfTouches = 1
        panSwipe.minimumNumberOfTouches = 1
        tap.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(panSwipe)
        view.addGestureRecognizer(tap)
    }
    
    @objc func changeVal (_ sender : UIGestureRecognizer){
        var percentage = sender.location(in:view).y/view.frame.height
        let intensity = percentage * maximumRaindrop - maximumRaindrop/10
        
        
        //rain
        rain.rainIntensity = Float(intensity < 0 ? 0 : intensity)
        rain.layoutSubviews()

        //sound
        if sender.state == .ended{
            soundCalculate(percentage)
        }
        
        //sky
        if percentage < 0.2 {
            percentage = 0
        }else if percentage > 0.8 {
            percentage = 1
        }
        
        UIView.animate(withDuration: 1) {
            self.sky.transform = CGAffineTransform(translationX: 0,
                y: -percentage * self.view.frame.height
            )
        }
    }
    
    func soundCalculate(_ percentage : CGFloat){
        if percentage < 0.1{
            MusicPlayer.shared.fadeOutSound(lightRainDic)
            MusicPlayer.shared.fadeOutSound(heavyRainDic)
            MusicPlayer.shared.fadeInSound(birdSongDic, 0.8)
        }else if percentage < 0.65 {
            MusicPlayer.shared.fadeInSound(lightRainDic, 0.8)
            MusicPlayer.shared.fadeOutSound(heavyRainDic)
            MusicPlayer.shared.fadeOutSound(birdSongDic)

        }else{
            MusicPlayer.shared.fadeInSound(heavyRainDic, 0.6)
            MusicPlayer.shared.fadeOutSound(birdSongDic)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


