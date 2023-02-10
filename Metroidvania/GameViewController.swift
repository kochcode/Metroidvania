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
    var play : GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                play = scene as? GameScene
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
    }
    @IBAction func leftMoveLetGo(_ sender: UIButton) {
    }
    
    
    @IBAction func rightButton(_ sender: UIButton) {
        play.mRight()
    }
    
    @IBAction func downButton(_ sender: UIButton) {
        play.mDown()
    }
    
    @IBAction func jumpButton(_ sender: UIButton) {
        play.jump()
    }
    
}
