//
//  GameScene.swift
//  SpaceShooter
//
//  Created by beardmikle on 05.01.2023.
//

import SpriteKit
import GameplayKit




class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var gameTimer: Timer!
    var aliens = ["alien", "alien2", "alien3"]

    let alienCategory:UInt32 = 0x1 << 1
    let bulletCategory:UInt32 = 0x1 << 0

    
//    @objc func addAlien() {
//        aliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: aliens) as! [String]
//
//        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
//    }
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle")
        player.position = CGPoint(x: 0, y: -400)
        player.setScale(1.4)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = UIColor.green
        scoreLabel.position = CGPoint(x: -150, y: 500)
        score = 0
        
        self.addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
    }
    
        
    @objc func addAlien() {
            aliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: aliens) as! [String]
        
            let alien = SKSpriteNode(imageNamed: aliens[0])
            let randomPos = GKRandomDistribution(lowestValue: -300, highestValue: 300)
            let pos = CGFloat(randomPos.nextInt())
            alien.position = CGPoint(x: pos, y: 800)
            alien.setScale(1.4)
            
            alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
            alien.physicsBody?.isDynamic = true
            
            alien.physicsBody?.categoryBitMask = alienCategory
            alien.physicsBody?.contactTestBitMask = bulletCategory
            alien.physicsBody?.collisionBitMask = 0
            
            self.addChild(alien)
            
            let animDuration:TimeInterval = 6
            
            var actions = [SKAction]()
            actions.append(SKAction.move(to: CGPoint(x: pos, y: -300), duration: animDuration))
            actions.append(SKAction.removeFromParent())
            
            alien.run(SKAction.sequence(actions))
            
        }
    
    override func update(_ currentTime: TimeInterval) {
            // Called before each frame is rendered
        }
    
    }
    
    
    


