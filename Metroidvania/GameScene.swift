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
    var projectile : SKSpriteNode!
    var water : SKSpriteNode!
    var ice : SKSpriteNode!
    var ghosts = [SKSpriteNode]()
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
    var seconds = 0
    var powers = [Int:String]()
    var shootable = true
    var movable = true
    var seeable = false
    var hurtable = true
    var onWater = false
    var left = false
    var moving = ""
    var inAir = false
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        explorer = (self.childNode(withName: "explorer") as! SKSpriteNode)
        plank = (self.childNode(withName: "plank") as! SKSpriteNode)
        platform = (self.childNode(withName: "platform") as! SKSpriteNode)
        ladder = (self.childNode(withName: "ladder") as! SKSpriteNode)
        mover = (self.childNode(withName: "mover") as! SKSpriteNode)
        projectile = (self.childNode(withName: "projectile") as! SKSpriteNode)
        water = (self.childNode(withName: "water") as! SKSpriteNode)
        ice = (self.childNode(withName: "ice") as! SKSpriteNode)
        ghosts.append(self.childNode(withName: "ghost") as! SKSpriteNode)
        ghosts.append(self.childNode(withName: "ghost2") as! SKSpriteNode)
        explorer.color = UIColor.cyan
        projectile.isHidden = true
        ice.isHidden = true
        for g in ghosts{
            g.isHidden = true
        }
        self.camera = cam
        let movingAction = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: mover.position.x + 200, duration: 2), SKAction.moveTo(x: mover.position.x - 200, duration: 2)]))
        mover.run(movingAction)
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = explorer.position
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ground"{
            jumps = 1
            onWater = false
            inAir = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ground"{
            jumps = 1
            onWater = false
            inAir = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "water"{
            jumps = 1
            onWater = true
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "water"{
            jumps = 1
            onWater = true
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ice"{
            jumps = 1
            onWater = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ice"{
            jumps = 1
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ghost"{
            jumps = 1
            onWater = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ghost"{
            jumps = 1
            onWater = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "plank"{
            jumps = 1
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "plank"{
            jumps = 1
            onWater = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "mover"{
            jumps = 1
            onWater = false
            
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "mover"{
            jumps = 1
            onWater = false
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "platform"{
            climb = 2
            print(climb)
            jumps = 1
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "platform"{
            climb = 2
            print(climb)
            jumps = 1
            onWater = false
        }
        
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ladder"{
            climb2 = true
            print(climb2)
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ladder"{
            climb2 = true
            print(climb2)
            onWater = false
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
            if hurtable == true{
                if explorer.color == UIColor.cyan{
                    GameScene.lives -= 1
                    print("ouch")
                    explorer.color = UIColor.red
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.explorer.color = UIColor.cyan
                    }
                }
                gs.update()
            }
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "spike"{
            if hurtable == true{
                if explorer.color == UIColor.cyan{
                    GameScene.lives -= 1
                    print("ouch")
                    explorer.color = UIColor.red
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        self.explorer.color = UIColor.cyan
                    }
                }
                gs.update()
            }
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
            print("F")
            powers[0] = "Flame"
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "firepower"{
            contact.bodyA.node?.removeFromParent()
            GameScene.powers += 1
            print("F")
            powers[0] = "Flame"
            gs.update()
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "icepower"{
            if GameScene.powers == 1{
                contact.bodyB.node?.removeFromParent()
                GameScene.powers += 1
                print("I")
                powers[1] = "Frost"
                gs.update()
            }
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "icepower"{
            if GameScene.powers == 1{
                contact.bodyA.node?.removeFromParent()
                GameScene.powers += 1
                print("I")
                powers[1] = "Frost"
                gs.update()
            }
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "lifepower"{
            if GameScene.powers == 2{
                contact.bodyB.node?.removeFromParent()
                GameScene.powers += 1
                print("L")
                powers[2] = "Growth"
                gs.update()
            }
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "lifepower"{
            if GameScene.powers == 2{
                contact.bodyA.node?.removeFromParent()
                GameScene.powers += 1
                print("L")
                powers[2] = "Growth"
                gs.update()
            }
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "sunpower"{
            if GameScene.powers == 3{
                contact.bodyB.node?.removeFromParent()
                GameScene.powers += 1
                print("S")
                powers[3] = "Light"
                gs.update()
            }
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "sunpower"{
            if GameScene.powers == 3{
                contact.bodyA.node?.removeFromParent()
                GameScene.powers += 1
                print("S")
                powers[3] = "Light"
                gs.update()
            }
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "darkpower"{
            if GameScene.powers == 4{
                contact.bodyB.node?.removeFromParent()
                GameScene.powers += 1
                print("D")
                powers[4] = "Shadow"
                gs.update()
            }
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "darkpower"{
            if GameScene.powers == 4{
                contact.bodyA.node?.removeFromParent()
                GameScene.powers += 1
                print("D")
                powers[4] = "Shadow"
                gs.update()
            }
        }
        if contact.bodyA.node?.name == "projectile" && contact.bodyB.node?.name == "ground"{
            projectile.isHidden = true
            projectile.position.x = 1000
            projectile.position.y = 1000
        }
        if contact.bodyB.node?.name == "projectile" && contact.bodyA.node?.name == "ground"{
            projectile.isHidden = true
            projectile.position.x = 1000
            projectile.position.y = 1000
        }
        if contact.bodyA.node?.name == "projectile" && contact.bodyB.node?.name == "vines"{
            if projectile.color == UIColor.red{
                contact.bodyB.node?.removeFromParent()
            }
            else{
                projectile.isHidden = true
                projectile.position.x = 1000
                projectile.position.y = 1000
            }
        }
        if contact.bodyB.node?.name == "projectile" && contact.bodyA.node?.name == "vines"{
            if projectile.color == UIColor.red{
                contact.bodyA.node?.removeFromParent()
            }
            else{
                projectile.isHidden = true
                projectile.position.x = 1000
                projectile.position.y = 1000
            }
        }
        if contact.bodyA.node?.name == "projectile" && contact.bodyB.node?.name == "water"{
            if projectile.color == UIColor.blue{
                if explorer.position.y > water.position.y{
                    ice.isHidden = true
                    ice.run(SKAction.moveTo(x: projectile.position.x, duration: 0.2))
                    ice.run(SKAction.moveTo(y: projectile.position.y + 45, duration: 0.2))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        self.ice.isHidden = false
                    }
                }
            }
            else{
                projectile.isHidden = true
            }
        }
        if contact.bodyB.node?.name == "projectile" && contact.bodyA.node?.name == "water"{
            if projectile.color == UIColor.blue{
                if explorer.position.y > water.position.y{
                    ice.isHidden = true
                    ice.run(SKAction.moveTo(x: projectile.position.x, duration: 0.2))
                    ice.run(SKAction.moveTo(y: projectile.position.y + 40, duration: 0.2))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                        self.ice.isHidden = false
                    }
                }
            }
            else{
                projectile.isHidden = true
            }
        }
        if contact.bodyA.node?.name == "projectile" && contact.bodyB.node?.name == "mover"{
            if projectile.color == UIColor.green{
                mover.color = UIColor.green
                mover.isPaused = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    self.mover.color = UIColor.gray
                    self.mover.isPaused = false
                }
            }
            else{
                projectile.isHidden = true
                projectile.position.x = 1000
                projectile.position.y = 1000
            }
        }
        if contact.bodyB.node?.name == "projectile" && contact.bodyA.node?.name == "mover"{
            if projectile.color == UIColor.green{
                print("stopp")
                mover.isPaused = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    self.mover.color = UIColor.gray
                    self.mover.isPaused = false
                }
            }
            else{
                projectile.isHidden = true
                projectile.position.x = 1000
                projectile.position.y = 1000
            }
        }
    }
    
    func mLeft(){
        if inAir == false{
            explorer.physicsBody?.velocity = CGVector(dx: -450, dy: 0)
            left = true
            moving = "left"
        }
    }
    func stopLeft(){
        explorer.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        moving = "no"
    }
    func mRight(){
        if inAir == false{
            explorer.physicsBody?.velocity = CGVector(dx: 450, dy: 0)
            left = false
            moving = "right"
        }
    }
    func stopRight(){
        explorer.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        moving = "no"
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
            inAir = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                self.inAir = false
            }
        }
    }
    func shoot(){
        if shootable == true{
            shootable = false
            if projectile.color != UIColor.yellow{
                if left == true{
                    if moving == "left"{
                        projectile.position.x = explorer.position.x - 30
                    }
                    else if moving == "no"{
                        projectile.position.x = explorer.position.x - 20
                    }
                }
                else if left == false{
                    if moving == "right"{
                        projectile.position.x = explorer.position.x + 30
                    }
                    else if moving == "no"{
                        projectile.position.x = explorer.position.x + 20
                    }
                }
            }
            if projectile.color == UIColor.red{
                projectile.isHidden = false
                projectile.position.y = explorer.position.y
                if left == true{
                    if moving == "left"{
                        print("goingleft")
                        projectile.run(SKAction.moveTo(x: projectile.position.x - 200, duration: 0.2))
                    }
                    else if moving == "no"{
                        projectile.run(SKAction.moveTo(x: projectile.position.x - 100, duration: 0.2))
                    }
                }
                else if left == false{
                    if moving == "right"{
                        print("goingright")
                        projectile.run(SKAction.moveTo(x: projectile.position.x + 200, duration: 0.2))
                    }
                    else if moving == "no"{
                        projectile.run(SKAction.moveTo(x: projectile.position.x + 100, duration: 0.2))
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    self.projectile.isHidden = true
                    self.shootable = true
                    self.projectile.position.x = 1000
                    self.projectile.position.y = 1000
                }
            }
            else if projectile.color == UIColor.blue{
                projectile.isHidden = false
                projectile.position.y = explorer.position.y
                if left == true{
                    if moving == "left"{
                        print("goingleft")
                        projectile.run(SKAction.moveTo(x: projectile.position.x - 200, duration: 0.2))
                    }
                    else if moving == "no"{
                        projectile.run(SKAction.moveTo(x: projectile.position.x - 100, duration: 0.2))
                    }
                }
                else if left == false{
                    if moving == "right"{
                        print("goingright")
                        projectile.run(SKAction.moveTo(x: projectile.position.x + 200, duration: 0.2))
                    }
                    else if moving == "no"{
                        projectile.run(SKAction.moveTo(x: projectile.position.x + 100, duration: 0.2))
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    if self.onWater == true{
                        self.projectile.run(SKAction.moveTo(y: self.projectile.position.y - 50, duration: 0.25))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            self.projectile.isHidden = true
                            self.shootable = true
                            self.projectile.position.x = 1000
                            self.projectile.position.y = 1000
                        }
                    }
                    else{
                        self.projectile.isHidden = true
                        self.shootable = true
                        self.projectile.position.x = 1000
                        self.projectile.position.y = 1000
                    }
                }
            }
        }
        else if projectile.color == UIColor.green{
            projectile.isHidden = false
            projectile.position.y = explorer.position.y
            if left == true{
                if moving == "left"{
                    print("goingleft")
                    projectile.run(SKAction.moveTo(x: projectile.position.x - 300, duration: 0.25))
                }
                else if moving == "no"{
                    projectile.run(SKAction.moveTo(x: projectile.position.x - 200, duration: 0.25))
                }
            }
            else if left == false{
                if moving == "right"{
                    print("goingright")
                    projectile.run(SKAction.moveTo(x: projectile.position.x + 300, duration: 0.25))
                }
                else if moving == "no"{
                    projectile.run(SKAction.moveTo(x: projectile.position.x + 200, duration: 0.25))
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                self.projectile.isHidden = true
                self.shootable = true
                self.projectile.position.x = 1000
                self.projectile.position.y = 1000
            }
        }
        else if projectile.color == UIColor.yellow{
            projectile.isHidden = false
            projectile.position.x = explorer.position.x
            projectile.position.y = explorer.position.y + 20
            projectile.run(SKAction.moveTo(y: self.projectile.position.y + 50, duration: 1.0))
            for g in ghosts{
                g.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.projectile.isHidden = true
                self.shootable = true
                self.projectile.position.x = 1000
                self.projectile.position.y = 1000
                for g in self.ghosts{
                    g.isHidden = true
                }
            }
        }
        else if projectile.color == UIColor.purple{
            explorer.color = UIColor.purple
            hurtable = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                self.explorer.color = UIColor.gray
                self.hurtable = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                    self.explorer.color = UIColor.cyan
                    self.shootable = true
                }
            }
        }
        else{
            self.projectile.isHidden = true
            self.shootable = true
            self.projectile.position.x = 1000
            self.projectile.position.y = 1000
        }
    }
}
