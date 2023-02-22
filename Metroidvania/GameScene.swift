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
    var mover : SKSpriteNode!
    let cam = SKCameraNode()
    var jumps = 0
    var climb = 1
    var climb2 = false
    var down = false
    var up = false
    var key1 = false
    static var lives = 3
    static var powers = 0
    var gs : GameViewController!
    var right = 10
    var powers = [Int:String]()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        explorer = (self.childNode(withName: "explorer") as! SKSpriteNode)
        plank = (self.childNode(withName: "plank") as! SKSpriteNode)
        platform = (self.childNode(withName: "platform") as! SKSpriteNode)
        ladder = (self.childNode(withName: "ladder") as! SKSpriteNode)
        mover = (self.childNode(withName: "mover") as! SKSpriteNode)
        self.camera = cam
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = explorer.position
//        if mover.position.x == 3030{
//            mover.physicsBody?.velocity = CGVector(dx: 20, dy: 0)
//        }
//        else if mover.position.x == 3080{
//            mover.physicsBody?.velocity = CGVector(dx: -20, dy: 0)
//        }
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
            GameScene.lives -= 1
            print("ouch")
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "spike"{
            GameScene.lives -= 1
            print("ouch")
            gs.update()
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "life"{
            contact.bodyB.node?.removeFromParent()
            GameScene.lives += 1
            print("yum")
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "life"{
            contact.bodyA.node?.removeFromParent()
            GameScene.lives += 1
            print("yum")
            gs.update()
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "firepower"{
            contact.bodyB.node?.removeFromParent()
            GameScene.powers += 1
            print("fayuh")
            powers[0] = "Flame"
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "firepower"{
            contact.bodyA.node?.removeFromParent()
            GameScene.powers += 1
            print("fayuh")
            powers[0] = "Flame"
            gs.update()
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "icepower"{
            contact.bodyB.node?.removeFromParent()
            GameScene.powers += 1
            print("ayce")
            powers[1] = "Frost"
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "icepower"{
            contact.bodyA.node?.removeFromParent()
            GameScene.powers += 1
            print("ayce")
            powers[1] = "Frost"
            gs.update()
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "lifepower"{
            contact.bodyB.node?.removeFromParent()
            GameScene.powers += 1
            print("layfe")
            powers[2] = "Growth"
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "lifepower"{
            contact.bodyA.node?.removeFromParent()
            GameScene.powers += 1
            print("layfe")
            powers[2] = "Growth"
            gs.update()
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
