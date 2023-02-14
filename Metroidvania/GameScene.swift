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
    var plank : SKSpriteNode!
    let cam = SKCameraNode()
    var jumps = 1
    var down = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        explorer = self.childNode(withName: "explorer") as! SKSpriteNode
        plank = self.childNode(withName: "plank") as! SKSpriteNode
        self.camera = cam
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = explorer.position
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ground"{
            jumps = 1
            print(jumps)
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ground"{
            jumps = 1
            print(jumps)
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "plank"{
            jumps = 1
            print(jumps)
            
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "plank"{
            jumps = 1
            print(jumps)
        }
    }
    func mLeft(){
        explorer.physicsBody?.velocity = CGVector(dx: -450, dy: 0)
    }
    func stopLeft(){
        explorer.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    func mRight(){
        explorer.physicsBody?.velocity = CGVector(dx: 450, dy: 0)
    }
    func stopRight(){
        explorer.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    func mDown(){
        down = true
        plank.physicsBody?.categoryBitMask = 0
        explorer.physicsBody?.velocity = CGVector(dx: 0, dy: -75)
            
    }
    func stopDown(){
        down = false
        plank.physicsBody?.categoryBitMask = 1
        explorer.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
    }
    func jump(){
        if jumps > 0{
            explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
            jumps -= 1
            print(jumps)
        }
    }
}
