//
//  GameScene.swift
//  AppofApps
//
//  Created by  Nikita Paralkar on 2019-12-06.
//  Copyright © 2019 Vivek Gupta inc. All rights reserved.
//vivek Gupta

// GameScene.swift
// in this class of the code
//Components of the gamscene are declared here



import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    // the ball
    var enemy = SKSpriteNode()
   // the computer/player 2
    var main = SKSpriteNode()
    // the player 1
    var topLbl = SKLabelNode()//score label for computer/player2
    var btmLbl = SKLabelNode()// score label for player 1
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
   
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 100
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 70
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: -10))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0 {
                    
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    
                }
                
            }
            else{
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
            
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.0))
            
            break
        case .player2:
            
            break
        }
        
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
}







