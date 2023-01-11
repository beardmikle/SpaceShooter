//
//  MainMenu.swift
//  SpaceShooter
//
//  Created by beardmikle on 06.01.2023.
//

import SpriteKit

class MainMenu: SKScene {
    
    var starfield:SKEmitterNode!
    
    var newGameButtonNode: SKSpriteNode!
    var levelButtonNode: SKSpriteNode!
    var labelLevelNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield_anim") as? SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
        newGameButtonNode.texture = SKTexture(imageNamed: "StartGame")
        
        levelButtonNode = self.childNode(withName: "levelButton") as? SKSpriteNode
        levelButtonNode.texture = SKTexture(imageNamed: "levels")
        
        labelLevelNode = self.childNode(withName: "labelLevelButton") as? SKLabelNode
        
        let userLevel = UserDefaults.standard
        
        if userLevel.bool(forKey: "hard") {
            labelLevelNode.text = "Ultra Hard"
        } else {
            labelLevelNode.text = "Easy"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at:location)
            
            if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.flipVertical(withDuration: 0.5)
                let gameScene = GameScene(size: UIScreen.main.bounds.size)
                self.view?.presentScene(gameScene, transition: transition)
            } else if nodesArray.first?.name == "levelButton" {
                changeLevel()
                
            }
        }
        
    }
    func changeLevel() {
        let userLevel = UserDefaults.standard
        
        if labelLevelNode.text == "Easy" {
            labelLevelNode.text = "Ultra Hard"
            userLevel.set(true, forKey: "hard")
        } else {
            labelLevelNode.text = "Easy"
            userLevel.set(false, forKey: "hard")
        }
        userLevel.synchronize()
            
    }
}
