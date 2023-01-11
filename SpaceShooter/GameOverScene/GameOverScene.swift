//
//  GameOverScene.swift
//  SpaceShooter
//
//  Created by beardmikle on 09.01.2023.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var starfield:SKEmitterNode!
    
    var score: Int = 0
    
    var scoreLabel: SKLabelNode!
    var newGameButtonNode: SKSpriteNode!
    var menuButtonNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        starfield = self.childNode(withName: "starfield_anim") as? SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel.text = "\(score)"
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "StartGame")
        
        menuButtonNode = self.childNode(withName: "menuButton") as? SKSpriteNode
        menuButtonNode.texture = SKTexture(imageNamed: "menuButton")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        let node = nodes(at: location)
        if node[0].name == "newGameButton" {
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameScene = GameScene(size: UIScreen.main.bounds.size)
//            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: transition)

        } else  if node[0].name == "menuButton" {
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            let gameOverScene = SKScene(fileNamed: "MainMenu")!
            gameOverScene.scaleMode = .aspectFill
            self.view?.presentScene(gameOverScene, transition: transition)
        }
    }
}
