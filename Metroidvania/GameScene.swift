//
//  GameScene.swift
//  Metroidvania
//
//  Created by KEVIN KOCH on 2/9/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var explorer : SKSpriteNode!
    let cam = SKCameraNode()
    var jumps = 1
    var down = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        explorer = self.childNode(withName: "explorer") as! SKSpriteNode
        self.camera = cam
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = explorer.position
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ground"{
            jumps = 1
            print(jumps)
        }
    }
    func mRight(){
        if jumps > 0{
            explorer.physicsBody?.velocity = CGVector(dx: 100.0, dy: 0)
        }
    }
    func mLeft(){
        
        explorer.position = CGPoint(x: -100.0, y: 0)
    }
    func mDown(){
        if down == true{
            explorer.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
        }
    }
    func jump(){
        if jumps > 0{
            explorer.physicsBody?.velocity = CGVector(dx: 0, dy: 500.0)
            jumps -= 1
            print(jumps)
        }
    }
}
