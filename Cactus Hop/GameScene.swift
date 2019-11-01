//
//  GameScene.swift
//  Cactus Hop
//
//  Created by Jameel Jiwani on 2019-04-21.
//  Copyright © 2019 Jameel Jiwani. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var player = SKSpriteNode()
    var cactus = SKSpriteNode()
    var currentScore = SKLabelNode()
    var score = 0
    var scored = false
    var hit = false;
    
    
    var playerStartPosition = CGFloat()
    var cactiStartPosition = CGFloat()
    
    override func sceneDidLoad() {
        
        physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        cactus = self.childNode(withName: "cacti") as! SKSpriteNode
        currentScore = self.childNode(withName: "ScoreCounter") as! SKLabelNode
        
        //player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.contactTestBitMask = player.physicsBody!.collisionBitMask
        //cactus.physicsBody = SKPhysicsBody(rectangleOf: cactus.size)
        //cactus.physicsBody?.contactTestBitMask = player.physicsBody!.collisionBitMask
        
        player.constraints = [SKConstraint.positionX(SKRange(constantValue: -240))]
    
        cactus.constraints = [SKConstraint.positionY(SKRange(constantValue: cactus.position.y))]
        
        playerStartPosition = player.position.y
        cactiStartPosition = cactus.position.y
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                      with event: UIEvent?) {
        if(!(player.position.y > playerStartPosition)) {
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 600))
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if ( hit == true) {
            cactus.position.x = CGFloat(450)
            cactus.position.y = cactiStartPosition
            hit = false
            player.colorBlendFactor = 0.0
        }
        if(cactus.position.x < player.position.x && scored == false) {
            score += 1
            currentScore.text = "Score: \(score)"
            scored = true
        }
        if(cactus.position.x < CGFloat(-375)) {
            cactus.position.x = CGFloat(450)
            //cactus.position.y = cactiStartPosition
            scored = false
            player.colorBlendFactor = 0.0
        } else {
            cactus.physicsBody?.velocity = CGVector(dx: -250, dy: 0)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA == cactus.physicsBody {
            // Reset game
            print("collision")
            cactus.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            player.color = .red
            player.colorBlendFactor = 0.5
            score = 0
            currentScore.text = "Score: \(score)"
            hit = true;
        }
        
        
    
    }
}
