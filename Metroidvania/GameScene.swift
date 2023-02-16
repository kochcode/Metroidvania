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
    var platform : SKSpriteNode!
    var ladder : SKSpriteNode!
    let cam = SKCameraNode()
    var jumps = 0
    var climb = 1
    var climb2 = false
    var down = false
    var up = false
    var key1 = false
    var lives = 3
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        explorer = self.childNode(withName: "explorer") as! SKSpriteNode
        plank = self.childNode(withName: "plank") as! SKSpriteNode
        platform = self.childNode(withName: "platform") as! SKSpriteNode
        ladder = self.childNode(withName: "ladder") as! SKSpriteNode
        self.camera = cam
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = explorer.position
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ground"{
            jumps = 1
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ground"{
            jumps = 1
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "plank"{
            jumps = 1
            
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "plank"{
            jumps = 1
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "platform"{
            climb = 2
            print(climb)
            jumps = 1
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "platform"{
            climb = 2
            print(climb)
            jumps = 1
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ladder"{
            climb2 = true
            print(climb2)
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ladder"{
            climb2 = true
            print(climb2)
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "key"{
            contact.bodyB.node?.removeFromParent()
            key1 = true
            print("key")
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "key"{
            contact.bodyA.node?.removeFromParent()
            key1 = true
            print("key")
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "lock"{
            if key1 == true{
                contact.bodyB.node?.removeFromParent()
                print("lock")
            }
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "lock"{
            if key1 == true{
                contact.bodyA.node?.removeFromParent()
                print("lock")
            }
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "spike"{
            lives -= 1
            print("ouch")
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "spike"{
            lives -= 1
            print("ouch")
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
    func mUp(){
        up = true
        if explorer.position.y < platform.position.y{
            if climb > 1{
                platform.physicsBody?.categoryBitMask = 0
                explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1))
            }
            climb = 1
        }
        if explorer.position.y < ladder.position.y && (explorer.position.x > ladder.position.x - 40 && explorer.position.x < ladder.position.x + 55){
            print("ok")
            if climb2 == true{
                ladder.physicsBody?.categoryBitMask = 0
                explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 80))
            }
        }
       
    }
    func stopUp(){
        up = false
        platform.physicsBody?.categoryBitMask = 1
        ladder.physicsBody?.categoryBitMask = 1
        
        
    }
    
    func jump(){
        if jumps > 0{
            explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 75))
            jumps -= 1
        }
    }
}
