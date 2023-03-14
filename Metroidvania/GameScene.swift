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
    
    var breakablePlatform : SKSpriteNode!
    var spikePlatform : SKSpriteNode!
    var pSpikes = [SKSpriteNode]()
    
    var ladder : SKSpriteNode!
    var mover : SKSpriteNode!
    var projectile : SKSpriteNode!
    var water : SKSpriteNode!
    var ice : SKSpriteNode!
    
    var ghosts = [SKSpriteNode]()
    var skeletons = [SKSpriteNode]()
    var grassSkele = [SKSpriteNode]()
    var shields = [SKSpriteNode]()
    var grassShields = [SKSpriteNode]()
    var phantoms = [SKSpriteNode]()
    
    var peas = [SKSpriteNode]()
    var arrows = [SKSpriteNode]()
    var stones = [SKSpriteNode]()
    
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
    
    var fireCharges = 0
    
    var timer = Timer()
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        explorer = (self.childNode(withName: "explorer") as! SKSpriteNode)
        plank = (self.childNode(withName: "plank") as! SKSpriteNode)
        platform = (self.childNode(withName: "platform") as! SKSpriteNode)
        
        breakablePlatform = (self.childNode(withName: "breakable") as! SKSpriteNode)
        spikePlatform = (self.childNode(withName: "spikePlatform") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike1") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike2") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike3") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike4") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike5") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike6") as! SKSpriteNode)
        pSpikes.append(self.childNode(withName: "pSpike7") as! SKSpriteNode)
        
        ladder = (self.childNode(withName: "ladder") as! SKSpriteNode)
        mover = (self.childNode(withName: "mover") as! SKSpriteNode)
        projectile = (self.childNode(withName: "projectile") as! SKSpriteNode)
        water = (self.childNode(withName: "water") as! SKSpriteNode)
        ice = (self.childNode(withName: "ice") as! SKSpriteNode)
        
        ghosts.append(self.childNode(withName: "ghost") as! SKSpriteNode)
        ghosts.append(self.childNode(withName: "ghost2") as! SKSpriteNode)
        
        skeletons.append(self.childNode(withName: "skelly1") as! SKSpriteNode)
        skeletons.append(self.childNode(withName: "skelly2") as! SKSpriteNode)
        skeletons.append(self.childNode(withName: "skelly3") as! SKSpriteNode)
        
        grassSkele.append(self.childNode(withName: "grassSkelly1") as! SKSpriteNode)
        
        shields.append(self.childNode(withName: "upShield1") as! SKSpriteNode)
        shields.append(self.childNode(withName: "upShield2") as! SKSpriteNode)
        shields.append(self.childNode(withName: "sideShield1") as! SKSpriteNode)
        
        grassShields.append(self.childNode(withName: "growthShield1") as! SKSpriteNode)
        
        phantoms.append(self.childNode(withName: "phantm1") as! SKSpriteNode)
        phantoms.append(self.childNode(withName: "fastPhantm1") as! SKSpriteNode)
        phantoms.append(self.childNode(withName: "superFastPhantm1") as! SKSpriteNode)
        
       
        peas.append(self.childNode(withName: "pea1") as! SKSpriteNode)
        arrows.append(self.childNode(withName: "arrowDown1") as! SKSpriteNode)
        arrows.append(self.childNode(withName: "arrowUp1") as! SKSpriteNode)
        arrows.append(self.childNode(withName: "arrowLeft1") as! SKSpriteNode)
        arrows.append(self.childNode(withName: "arrowRight1") as! SKSpriteNode)
        stones.append(self.childNode(withName: "stoneLeft1") as! SKSpriteNode)
        stones.append(self.childNode(withName: "stoneRight1") as! SKSpriteNode)
        
        explorer.color = UIColor.cyan
        projectile.isHidden = true
        ice.isHidden = true
        
        var expos = explorer.position
        
        for g in ghosts{
            g.isHidden = true
        }
        self.camera = cam
        
        for a in peas{
            let pos = a.position
            let peaMove = SKAction.move(to: expos, duration: 2)
            let peaShoot1 = SKAction.sequence([SKAction.unhide(), peaMove, SKAction.hide(), SKAction.moveTo(x: pos.x, duration: 0.01), SKAction.moveTo(y: pos.y, duration: 0.01)])
            if a.name == "pea1"{
                a.run(peaShoot1)
                gs.update()
            }
        }
        
        //STONE MOVEMENT
        for a in stones{
            let stoneMoveLeft =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: a.position.x - 800, duration: 2), SKAction.hide(), SKAction.moveTo(x: a.position.x + 0, duration: 0.01), SKAction.unhide(), SKAction.wait(forDuration: 2)]))
            let stoneMoveRight =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: a.position.x + 800, duration: 2), SKAction.hide(), SKAction.moveTo(x: a.position.x - 0, duration: 0.01), SKAction.unhide(), SKAction.wait(forDuration: 2)]))
            if a.name == "stoneLeft1"{
                a.run(stoneMoveLeft)
            }
            if a.name == "stoneRight1"{
                a.run(stoneMoveRight)
            }
        }
        //ARROW MOVEMENT
        for a in arrows{
            let arrowMoveDown =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: a.position.y - 400, duration: 1), SKAction.hide(), SKAction.moveTo(y: a.position.y + 0, duration: 0.01), SKAction.unhide(), SKAction.wait(forDuration: 2)]))
            let arrowMoveUp =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: a.position.y + 400, duration: 1), SKAction.hide(), SKAction.moveTo(y: a.position.y - 0, duration: 0.01), SKAction.unhide(), SKAction.wait(forDuration: 2)]))
            let arrowMoveLeft =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: a.position.x - 400, duration: 1), SKAction.hide(), SKAction.moveTo(x: a.position.x + 0, duration: 0.01), SKAction.unhide(), SKAction.wait(forDuration: 2)]))
            let arrowMoveRight =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: a.position.x + 400, duration: 1), SKAction.hide(), SKAction.moveTo(x: a.position.x - 0, duration: 0.01), SKAction.unhide(), SKAction.wait(forDuration: 2)]))
            if a.name == "arrowDown1"{
                a.run(arrowMoveDown)
            }
            if a.name == "arrowUp1"{
                a.run(arrowMoveUp)
            }
            if a.name == "arrowLeft1"{
                a.run(arrowMoveLeft)
            }
            if a.name == "arrowRight1"{
                a.run(arrowMoveRight)
            }
        }
        
        //SPIKE MOVEMENT
        for p in pSpikes{
            let spikeMove =
            SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: p.position.y, duration: 1), SKAction.wait(forDuration: 2), SKAction.moveTo(y: p.position.y + 25, duration: 0.5), SKAction.wait(forDuration: 4)]))
            p.run(spikeMove)
        }
        
        //PHANTOM MOVEMENT
        for e in phantoms{
            let phantmMove1 = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: e.position.x + 200, duration: 3), SKAction.wait(forDuration: 3), SKAction.moveTo(x: e.position.x - 200, duration: 3), SKAction.wait(forDuration: 3)]))
            let phantmMove2 = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(y: e.position.y + 20, duration: 1), SKAction.moveTo(y: e.position.y - 20, duration: 1)]))
            let phantmMove3 = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: e.position.x + 200, duration: 2), SKAction.wait(forDuration: 2), SKAction.moveTo(x: e.position.x - 200, duration: 2), SKAction.wait(forDuration: 2)]))
            let phantmMove4 = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: e.position.x + 200, duration: 1), SKAction.wait(forDuration: 1), SKAction.moveTo(x: e.position.x - 200, duration: 1), SKAction.wait(forDuration: 1)]))
            
            
            if e.name == "phantm1"{
                e.run(phantmMove1)
            }
            if e.name == "fastPhantm1"{
                e.run(phantmMove3)
            }
            if e.name == "superFastPhantm1"{
                e.run(phantmMove4)
            }
                e.run(phantmMove2)
        }
        
        //GRASS SKELETON MOVEMENT
        for e in grassSkele{
            let gskellyMove1 = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: e.position.x + 50, duration: 4), SKAction.wait(forDuration: 2), SKAction.moveTo(x: e.position.x - 50, duration: 4), SKAction.wait(forDuration: 2)]))
            e.run(gskellyMove1)
        }
        
        //SKELETON MOVEMENT
        for e in skeletons{
            let skellyMove1 = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: e.position.x + 100, duration: 3), SKAction.wait(forDuration: 3), SKAction.moveTo(x: e.position.x - 100, duration: 3), SKAction.wait(forDuration: 3)]))
            e.run(skellyMove1)
        }
        
        //PLATFORM MOVEMENT
        let platformAction = SKAction.repeatForever(SKAction.sequence([SKAction.moveTo(x: mover.position.x + 200, duration: 2), SKAction.moveTo(x: mover.position.x - 200, duration: 2)]))
        mover.run(platformAction)
    }
    override func update(_ currentTime: TimeInterval) {
        cam.position = explorer.position
        
        //SHIELDS SETUP
        shields[0].position.y = skeletons[1].position.y + 25
        shields[0].position.x = skeletons[1].position.x
        shields[1].position.y = skeletons[2].position.y + 25
        shields[1].position.x = skeletons[2].position.x
        shields[2].position.y = skeletons[2].position.y
        shields[2].position.x = skeletons[2].position.x + 25
        grassShields[0].position.x = grassSkele[0].position.x
        grassShields[0].position.y = grassSkele[0].position.y + 25
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        //GROWTH SHIELD CONTACT EXPLORER
        for s in grassShields{
            if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == s.name{
                if explorer.color == UIColor.orange{
                    contact.bodyB.node?.removeFromParent()
                    explorer.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
                    explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
                    jumps += 1
                    explorer.color = UIColor.cyan
                }
                else{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
                            GameScene.lives -= 1
                            print("ouchie")
                            explorer.color = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                self.explorer.color = UIColor.cyan
                            }
                        }
                        gs.update()
                    }
                }
            }
            if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == s.name{
                if explorer.color == UIColor.orange{
                    contact.bodyA.node?.removeFromParent()
                    explorer.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
                    explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
                    jumps += 1
                    explorer.color = UIColor.cyan
                }
                else{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
                            GameScene.lives -= 1
                            print("ouchie")
                            explorer.color = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                self.explorer.color = UIColor.cyan
                            }
                        }
                        gs.update()
                    }
                }
            }
            
        }
        //GRASS SKELETONS CONTACT EXPLORER
        for e in grassSkele{
            if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == e.name{
                if explorer.position.y > e.position.y{
                    contact.bodyB.node?.removeFromParent()
                    explorer.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
                    explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
                    jumps += 1
                }
                else{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
                            GameScene.lives -= 1
                            print("ouchie")
                            explorer.color = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                self.explorer.color = UIColor.cyan
                            }
                        }
                        gs.update()
                    }
                }
            }
            if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == e.name{
                if explorer.position.y > e.position.y{
                    contact.bodyA.node?.removeFromParent()
                    explorer.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
                    explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
                    jumps += 1
                }
                else{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
                            GameScene.lives -= 1
                            print("ouchie")
                            explorer.color = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                self.explorer.color = UIColor.cyan
                            }
                        }
                        gs.update()
                    }
                }
            }
        }
        //SKELETONS CONTACT EXPLORER
        for e in skeletons{
            if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == e.name{
                if explorer.position.y > e.position.y{
                    contact.bodyB.node?.removeFromParent()
                    explorer.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
                    explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
                    jumps += 1
                }
                else{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
                            GameScene.lives -= 1
                            print("ouchie")
                            explorer.color = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                self.explorer.color = UIColor.cyan
                            }
                        }
                        gs.update()
                    }
                }
            }
            if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == e.name{
                if explorer.position.y > e.position.y{
                    contact.bodyA.node?.removeFromParent()
                    explorer.physicsBody?.velocity = (CGVector(dx: 0, dy: 0))
                    explorer.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 25))
                    jumps += 1
                }
                else{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
                            GameScene.lives -= 1
                            print("ouchie")
                            explorer.color = UIColor.red
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                self.explorer.color = UIColor.cyan
                            }
                        }
                        gs.update()
                    }
                }
            }
        }
        
        //SPIKES PLATFORM CONTACT EXPLORER
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "spikePlatform"{
            jumps = 1
            onWater = false
            inAir = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "spikePlatform"{
            jumps = 1
            onWater = false
            inAir = false
        }
        //ARROWS CONTACT GROUND
        for a in arrows{
            if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == a.name{
                a.isHidden = true
            }
            if contact.bodyB.node?.name == "ground" && contact.bodyA.node?.name == a.name{
                a.isHidden = true
            }
        }
        //ARROWS CONTACT EXPLORER
        for a in arrows{
            if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == a.name{
                if a.isHidden == false{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
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
            }
            if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == a.name{
                if a.isHidden == false{
                    if hurtable == true{
                        if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
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
            }
        }
        
        //SPIKES ON PLATFORM CONTACT EXPLORER
        for p in pSpikes{
            if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == p.name{
                if hurtable == true{
                    if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
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
            if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == p.name{
                if hurtable == true{
                    if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
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
        }
        
        
        //BREAKABLE PLATFORM CONTACT EXPLORER
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "breakable"{
            jumps = 1
            onWater = false
            inAir = false
            let pos = breakablePlatform.position
            let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 2.0)
             let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.2)
            contact.bodyA.node?.run(fadeOut)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2){
                contact.bodyA.node?.position.x = 1000
                contact.bodyA.node?.position.y = 1000
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.breakablePlatform.position = pos
                    contact.bodyA.node?.run(fadeIn)
                }
            }
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "breakable"{
            jumps = 1
            onWater = false
            inAir = false
            let pos = breakablePlatform.position
            let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 2.0)
             let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.2)
            contact.bodyB.node?.run(fadeOut)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2){
                contact.bodyB.node?.position.x = 1000
                contact.bodyB.node?.position.y = 1000
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.breakablePlatform.position = pos
                    contact.bodyB.node?.run(fadeIn)
                }
            }
        }
        
        //GROUND CONTACT EXPLORER
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
        
        //WATER CONTACT EXPLORER
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "water"{
            jumps = 1
            onWater = true
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "water"{
            jumps = 1
            onWater = true
        }
        
        //ICE CONTACT EXPLORER
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ice"{
            jumps = 1
            onWater = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ice"{
            jumps = 1
            onWater = false
        }
        
        //GHOST CONTACT EXPLORER
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ghost"{
            jumps = 1
            onWater = false
        }
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ghost"{
            jumps = 1
            onWater = false
        }
        
        //PLANK CONTACT EXPLORER
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "plank"{
            jumps = 1
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "plank"{
            jumps = 1
            onWater = false
        }
        
        //MOVER CONTACT EXPLORER
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "mover"{
            jumps = 1
            onWater = false
            
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "mover"{
            jumps = 1
            onWater = false
        }
        
        //PLATFORM CONTACT EXPLORER
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "platform"{
            climb = 2
            jumps = 1
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "platform"{
            climb = 2
            jumps = 1
            onWater = false
        }
        
        //LADDER CONTACT EXPLORER
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "ladder"{
            climb2 = true
            onWater = false
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "ladder"{
            climb2 = true
            onWater = false
        }
        
        //KEY CONTACT EXPLORER
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
        
        //LOCK CONTACT EXPLORER
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
        
        //SPIKE CONTACT EXPLORER
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "spike"{
            if hurtable == true{
                if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
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
                if explorer.color == UIColor.cyan || explorer.color == UIColor.gray{
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
        
        //LIFE CONTACT EXPLORER
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
        
        //FIREPOWER CONTACT EXPLORER
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
        
        //FIREPOWER MINI CONTACT EXPLORER
        if contact.bodyA.node?.name == "explorer" && contact.bodyB.node?.name == "firepowerMini"{
            contact.bodyB.node?.removeFromParent()
            fireCharges += 1
            print("M")
            explorer.color = UIColor.orange
            gs.update()
        }
        if contact.bodyB.node?.name == "explorer" && contact.bodyA.node?.name == "firepowerMini"{
            contact.bodyA.node?.removeFromParent()
            fireCharges += 1
            print("M")
            explorer.color = UIColor.orange
            gs.update()
        }
        
        //ICEPOWER CONTACT EXPLORER
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
        
        //LIFEPOWER CONTACT EXPLORER
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
        
        //SUNPOWER CONTACT EXPLORER
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
        
        //DARKPOWER CONTACT EXPLORER
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
        
        //GROUND CONTACT PROJECTILE
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
        
        //VINES CONTACT PROJECTILE
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
        
        //WATER CONTACT PROJECTILE
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
        
        //MOVER CONTACT PROJECTILE
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
    
    //LEFT
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
    
    //RIGHT
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
    
    //DOWN
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
    
    //UP
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
    
    //JUMP
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
    
    //SHOOT
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
            
        //RED
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
            
        //BLUE
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
        
        //GREEN
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                self.projectile.isHidden = true
                self.shootable = true
                self.projectile.position.x = 1000
                self.projectile.position.y = 1000
            }
        }
        
        //YELLOW
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
        
        //PURPLE
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
        
        //ELSE
        else{
            self.projectile.isHidden = true
            self.shootable = true
            self.projectile.position.x = 1000
            self.projectile.position.y = 1000
        }
    }
}
