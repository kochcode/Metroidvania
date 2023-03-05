//
//  GameViewController.swift
//  Metroidvania
//
//  Created by KEVIN KOCH on 2/9/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var controlOutlet: UISegmentedControl!
    @IBOutlet weak var powerOutlet: UIButton!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    
    var play : GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        //UIWindowScene.requestGeometryUpdate(<#T##self: UIWindowScene##UIWindowScene#>)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                play = scene as? GameScene
                play.gs = self
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func leftMoveHeld(_ sender: UIButton) {
        play.mLeft()
    }
    @IBAction func leftMoveLetGo(_ sender: UIButton) {
        play.stopLeft()
    }
    @IBAction func rightMoveHeld(_ sender: UIButton) {
        play.mRight()
    }
    @IBAction func rightMoveLetGo(_ sender: UIButton) {
        play.stopRight()
    }
    
    @IBAction func downMoveHeld(_ sender: UIButton) {
        play.mDown()
    }
    @IBAction func downMoveLetGo(_ sender: UIButton) {
        play.stopDown()
    }
    
    @IBAction func upMoveHeld(_ sender: UIButton) {
        play.mUp()
        
    }
    @IBAction func upMoveLetGo(_ sender: UIButton) {
        play.stopUp()
    }
    @IBAction func jumpButton(_ sender: UIButton) {
        play.jump()
    }
    @IBAction func shootButton(_ sender: UIButton) {
        if controlOutlet.selectedSegmentIndex == 0{
            play.projectile.color = UIColor.red
        }
        else if controlOutlet.selectedSegmentIndex == 1{
            play.projectile.color = UIColor.blue
        }
        else if controlOutlet.selectedSegmentIndex == 2{
            play.projectile.color = UIColor.green
        }
        else if controlOutlet.selectedSegmentIndex == 3{
            play.projectile.color = UIColor.yellow
        }
        else if controlOutlet.selectedSegmentIndex == 4{
            play.projectile.color = UIColor.purple
        }
        play.shoot()
    }
    
    func update(){
        if GameScene.lives == 3{
            heart1.isHidden = false
            heart2.isHidden = false
            heart3.isHidden = false
        }
        else if GameScene.lives == 2{
            heart1.isHidden = false
            heart2.isHidden = false
            heart3.isHidden = true
        }
        else if GameScene.lives == 1{
            heart1.isHidden = false
            heart2.isHidden = true
            heart3.isHidden = true
        }
        else if GameScene.lives < 1{
            heart1.isHidden = true
            heart2.isHidden = true
            heart3.isHidden = true
        }
        if GameScene.powers < 1{
            powerOutlet.isHidden = true
            controlOutlet.isHidden = true
        }
        else if GameScene.powers == 1{
            powerOutlet.isHidden = false
            controlOutlet.isHidden = true
        }
        else if GameScene.powers >= 2{
            replaceSegments(segments: play.powers)
            controlOutlet.isHidden = false
            for power in play.powers {
                controlOutlet.setTitle("\(power.value)", forSegmentAt: power.key)
            }
        }
    }
    func replaceSegments(segments: [Int:String]) {
            controlOutlet.removeAllSegments()
        for power in play.powers {
            controlOutlet.insertSegment(withTitle: "\(power.value)", at: controlOutlet.numberOfSegments, animated: false)
            }
        }
}
