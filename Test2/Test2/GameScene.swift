//  GameScene.swift
//  Test2
//
//  Created by Claudia De Luca on 07/12/23.
//

import SpriteKit
import GameplayKit
import AVFoundation
import SwiftUI

class GameScene: SKScene {
    
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
//  var dragInAir = false
    var gameIsEnd = false {
        didSet {
            if gameIsEnd {
                backgroundMusicPlayer?.pause()
            } else {
                backgroundMusicPlayer?.play()
            }
            endGame()
        }
    }
    
    var gameIsPaused = false
    
    var timeInterval: TimeInterval = 4.0
    var fast: TimeInterval = 10.0
    @State var pauseTimeInt: TimeInterval = 4.0
    @State var pauseFast: TimeInterval = 10.0
    
    var musicNode = SKAudioNode()
    var backgroundMusicPlayer: AVAudioPlayer?
//  var jumpCount = 0
    
    var timer = Timer()
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    var currentDragSelected: DragChoice = .bianca
    var dragNodeTexture = SKTexture(imageNamed: "Warrior_Run_1")
    var dragSpriteNode = SKSpriteNode()
    var dragNode = SKNode()
    
    var lacaNodeTexture = SKTexture(imageNamed: "laca3")
    var lacaSpriteNode = SKSpriteNode()
    var lacaNode = SKNode()
    
    var enemyNodeArray = [SKNode]()
    
    var backgroundNode = SKSpriteNode(imageNamed: "background")
    
    var groundSpriteNode = SKSpriteNode()
    var groundNode = SKNode()
    
    var wallSpriteNode = SKSpriteNode()
    var wallNode = SKNode()
    
    var pauseButton = SKSpriteNode(imageNamed: "pauseButton")
    var pauseLabel = SKLabelNode(text: "Game Paused")
    
    var secondWallSpriteNode = SKSpriteNode()
    var secondWallNode = SKNode()
    
    let textures = Textures()
    let drags = Drags()
    
    var lastUpdate: TimeInterval = 0
    
    var dragMask : UInt32 = 1
    var groundMask : UInt32 = 2
    var wallMask : UInt32 = 3
    var enemyMask : UInt32 = 4
    var advantagMask : UInt32 = 5
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        initialSetUp()
        addPlayPauseButton()
    }
    
    func addPlayPauseButton() {
        // Set the desired scale factor (e.g., 0.5 for half the size)
        let scale: CGFloat = 0.1
        
        self.pauseButton.name = "pauseButton"
        self.pauseButton.zPosition = 3
        
        // Adjust the position based on the scale (if needed)CGPoint(x: size.width / 2, y: )
        let scaledWidth = size.width / 2
        let scaledHeight = size.height - 90
        
        self.pauseButton.position = CGPoint(x: scaledWidth,
                                            y: scaledHeight)
        
        // Set the scale
        self.pauseButton.setScale(scale)
        
        self.addChild(pauseButton)
    }
    
    func initialSetUp() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0,
                                        dy: -10 )
        self.gameLogic.setUpGame()
        
        addBackground(zPosOffset: 1)
        addDrag()
        createGround()
        createWall()
        // createAudio()
        startSpawn()
        
        if let musicURL = Bundle.main.url(forResource: "Sissy That Walk",
                                          withExtension: "mp3") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                backgroundMusicPlayer?.numberOfLoops = -1 // Loop indefinitely
                backgroundMusicPlayer?.volume = 0.5 // Adjust the volume as needed
                backgroundMusicPlayer?.play()
            } catch {
                print("Error loading background music: \(error.localizedDescription)")
            }
        }
        
        addChild(dragNode)
        addChild(groundNode)
        addChild(wallNode)
        addChild(secondWallNode)
        addChild(musicNode)
    }
    
    func addBackground(zPosOffset: CGFloat) {
        backgroundNode.position = CGPoint(x: size.width / 2,
                                          y: size.height / 2)
        backgroundNode.size = size
        backgroundNode.zPosition = -zPosOffset - 2
        
        addChild(backgroundNode)
    }
    
    func createGround() {
        groundSpriteNode.position = CGPoint.zero
        groundSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width * 2,
                                                                         height: 130))
        groundSpriteNode.physicsBody?.isDynamic = false
        groundSpriteNode.physicsBody?.categoryBitMask = groundMask
        groundSpriteNode.zPosition = 1
        
        groundNode.addChild(groundSpriteNode)
    }
    
    func createWall() {
        wallSpriteNode.position = CGPoint.zero
        wallSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60,
                                                                       height: size.height * 2))
        wallSpriteNode.physicsBody?.isDynamic = false
        wallSpriteNode.physicsBody?.categoryBitMask = wallMask
        wallSpriteNode.zPosition = 1
        
        secondWallSpriteNode.position = CGPoint(x: size.width + 60, y: 0)
        secondWallSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60,
                                                                             height: size.height * 2))
        secondWallSpriteNode.physicsBody?.isDynamic = false
        secondWallSpriteNode.physicsBody?.categoryBitMask = wallMask
        secondWallSpriteNode.zPosition = 1
        
        secondWallNode.addChild(secondWallSpriteNode)
        wallNode.addChild(wallSpriteNode)
    }
    
    // MARK: - Hero
    func addDrag() {
        var dragSelected: [SKTexture] = textures.biancaWalking
        switch currentDragSelected {
        case .bianca:
            dragSelected = textures.biancaWalking
        case .laganja:
            dragSelected = textures.laganjaWalking
        case .jiggly:
            dragSelected = textures.jigglyWalking
        case .courtney:
            dragSelected = textures.courtney1Walking
        }

        let dragRunAnimation = SKAction.animate(with: dragSelected ,
                                                timePerFrame: 0.1)
        let dragRun = SKAction.repeatForever(dragRunAnimation)
        dragSpriteNode = SKSpriteNode(texture: dragNodeTexture)
        dragSpriteNode.run(dragRun)
        print(groundNode.position)
        
        dragSpriteNode.position = CGPoint(x: size.width/2, y: 135)
        dragSpriteNode.zPosition = 10
        dragSpriteNode.setScale(4)
        
        dragSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: dragNodeTexture.size().width - 30,
                                                                       height: dragNodeTexture.size().height + 10))
       // dragSpriteNode.physicsBody?.mass = 0.3
        dragSpriteNode.physicsBody?.affectedByGravity = false
        dragSpriteNode.physicsBody?.categoryBitMask = dragMask
        dragSpriteNode.physicsBody?.contactTestBitMask = groundMask
        dragSpriteNode.physicsBody?.collisionBitMask = groundMask
        
        
        dragSpriteNode.physicsBody?.isDynamic = true
        dragSpriteNode.physicsBody?.allowsRotation = false
    /*
        let moveLeft = SKAction.moveBy(x: -size.width / 3, y: 0, duration: 10)
        let moveLeftRepeat = SKAction.repeatForever(moveLeft)
        dragSpriteNode.run(moveLeftRepeat)
    */
        dragNode.addChild(dragSpriteNode)
    }
    /*
    func createDeidAudio() {
        guard let musicURL = Bundle.main.url(forResource: "okrrr", withExtension: "mp3") else {
            fatalError()
        }
        musicNode = SKAudioNode(url: musicURL)
        musicNode.autoplayLooped = true
        musicNode.run(SKAction.play())
    }
    */
    
    // MARK: - Hero position
 
    /*
    func createAudio() {
        guard let musicURL = Bundle.main.url(forResource: "makai-symphony-dragon-slayer",
                                             withExtension: "mp3") else {
            fatalError()
        }
        musicNode = SKAudioNode(url: musicURL)
        musicNode.autoplayLooped = true
        musicNode.run(SKAction.play())
    }
     */
    
    // MARK: - Enemy
    func createEnemy(fast: TimeInterval) {
        let enemyNode = SKNode()
        let enemySpriteNode = SKSpriteNode(texture: textures.dragRunTextureArray[0])
        let enemyAnimation = SKAction.animate(with: textures.dragRunTextureArray, 
                                              timePerFrame: 0.1)
        let enemyAnimationRepeat = SKAction.repeatForever(enemyAnimation)
        enemySpriteNode.run(enemyAnimationRepeat)
        
        enemySpriteNode.setScale(1.0)
        
        enemySpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: textures.enemyTexture[0].size().width,
                                                                        height: textures.enemyTexture[0].size().height))
        let direction = Bool.random()
        
        if direction {
            print("derecha")
            enemySpriteNode.position = CGPoint(x: size.width - 40, y: size.height / 4)
            print(enemySpriteNode.position)
            enemySpriteNode.zPosition = 1
            enemySpriteNode.xScale *= -1
            
            // duration till the enemy arrives at -150
            let moveLeft = SKAction.moveBy(x: -size.width - 150, y: 0, duration: fast)
            let moveLeftRepeat = SKAction.repeatForever(moveLeft)
            enemySpriteNode.run(moveLeftRepeat)
            
        } else{
            print("izquierda")
            
            enemySpriteNode.position = CGPoint(x: size.width/8 , y: size.height / 12)
            print(enemySpriteNode.position)
            enemySpriteNode.zPosition = 1
            enemySpriteNode.xScale *= 1
            
            // duration till the enemy arrives at 150
            let moveRight = SKAction.moveBy(x: size.width + 150, y: 0, duration: fast)
            let moveRightRepeat = SKAction.repeatForever(moveRight)
            enemySpriteNode.run(moveRightRepeat)
        }
        
        enemySpriteNode.physicsBody?.categoryBitMask = enemyMask
        enemySpriteNode.physicsBody?.contactTestBitMask = dragMask
        enemySpriteNode.physicsBody?.collisionBitMask = groundMask
        
        enemySpriteNode.physicsBody?.isDynamic = true
        enemySpriteNode.physicsBody?.affectedByGravity = true
        enemySpriteNode.physicsBody?.allowsRotation = false
        
        enemyNodeArray.append(enemyNode)
        enemyNode.addChild(enemySpriteNode)
        addChild(enemyNode)
    }
    
    // MARK: - random num enemies inicialiced
    func startSpawn() {
        if gameIsEnd == false {
            pauseTimeInt = timeInterval
            pauseFast = fast
            
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
                
                self.fast -= 0.2
                self.fast = max(self.fast,2.0)
                
                self.timeInterval -= 0.1
                self.timeInterval = max(self.timeInterval, 0.01)
                
                
                print("Enemy created in time interval \(self.timeInterval), and fast \(self.fast) ")
                
                self.createEnemy(fast: self.fast)
            }
        }
    }
    
    // MARK: - herojump
    /*
     func heroJump(tapPos: CGPoint) {
     heroInAir = true
     jumpCount += 1
     let jumpAnimation = SKAction.animate(with: textures.dragWalking , timePerFrame: 0.1)
     heroSpriteNode.run(jumpAnimation)
     heroSpriteNode.physicsBody?.velocity = CGVector.zero
     
     let xTar = size.width / 2 < tapPos.x ? 1 : -1
     heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 150))
     heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 100 * xTar, dy: 120))
     }
     */
    
    // MARK: - herodied
    func dragDied() {
        let fadeOutAction = SKAction.fadeAlpha(to: 0.0, duration: 0.2)
        dragSpriteNode.run(fadeOutAction) {
            self.gameLogic.lives(points: 1)
            print("lives: \(self.gameLogic.liveScore)")
            
            // Reset the opacity when the drag respawns or when needed
            let fadeInAction = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
            self.dragSpriteNode.run(fadeInAction)
        }
        if gameLogic.liveScore == 0 {
            self.restartGame()
        }
    }
    
    private func restartGame() {
        self.gameLogic.restart_Game()
        timeInterval = 4.0
        fast = 10.0
        gameIsEnd = true
    }
    
    func endGame() {
        if gameIsEnd == true {
            timer.invalidate()
            children.forEach { node in
                node.removeAllActions()
                node.children.forEach { node in
                    node.removeAllActions()
                }
            }
            
            enemyNodeArray.forEach { node in
                node.removeFromParent()
            }
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                let blurView = UIVisualEffectView(frame: self.frame)
                blurView.alpha = 1
                blurView.layer.zPosition = 2

                UIView.animate(withDuration: 3) {
                    blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                }
            }
        }
    }
    
    func pauseGame() {
        // Pause the entire scene
        gameIsPaused.toggle()
        
        if gameIsPaused {
            backgroundMusicPlayer?.pause()
            
            for enemyNode in enemyNodeArray {
                enemyNode.removeFromParent()
            }
            
            dragSpriteNode.removeFromParent()
            
            lacaSpriteNode.removeFromParent()
            
            timer.invalidate()
            
            backgroundNode.alpha = 0.5
            
            //show pause label
            pauseLabel.fontSize = 50
            pauseLabel.fontName = "Atlantis Headline"
            pauseLabel.position = CGPoint(x: size.width / 2, y: size.height / 2)
            addChild(pauseLabel)
        } else {
            backgroundMusicPlayer?.play()
            
            addDrag()
            
            startSpawn()
            
            backgroundNode.alpha = 1
            
            lacaSpriteNode.removeFromParent()
            
            // Remove the pause label
            pauseLabel.removeFromParent()
        }
    }
}

// MARK: - CONTACT ENEMIES
extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == dragMask && 
            contact.bodyB.categoryBitMask == enemyMask ||
            contact.bodyA.categoryBitMask == enemyMask && 
            contact.bodyB.categoryBitMask == dragMask {
//          musicNode.run(SKAction.stop())
            dragDied()
            enemyDied()
        }
    }
    
    func enemyDied() {
        for enemyNode in enemyNodeArray {
            guard let enemySpriteNode = enemyNode.children.first as? SKSpriteNode else { continue }
            
            enemySpriteNode.removeFromParent() // Remove enemy from the scene
        }
    }
}

// MARK: - Handle Player Inputs
extension GameScene {
    enum SideOfTheScreen {
        case right, 
             left
    }
    
    private func sideTouched(for position: CGPoint) -> SideOfTheScreen {
        if position.x < self.frame.width / 2 && position.y < self.frame.height * 2 / 3 {
            return .left
        } else {
            return .right
        }
    }
    
    // MARK: - Hero Atac
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        //for killing
        switch sideTouched(for: touchLocation) {
        case .right:
            self.isMovingToTheRight = true
            //   playOkurrrSound()
            launchAttack(isRightSide: true)
            launch2Attack(isRightSide: true)
            //             print("ℹ️ Touching the RIGHT side.")
        case .left:
            self.isMovingToTheLeft = true
            //   playOkurrrSound()
            launchAttack(isRightSide: false)
            launch2Attack(isRightSide: false)
            //             print("ℹ️ Touching the LEFT side.")
        }
        
        //for put the game in pause
        for touch in touches {
            let location = touch.location(in: self)
            
            if let node = atPoint(location) as? SKSpriteNode, node.name == "pauseButton" {
                pauseGame()
            }
        }
        
    }
    
    func createLaca(space: Int) {
        lacaSpriteNode = SKSpriteNode(texture: lacaNodeTexture)
        lacaSpriteNode.setScale(0.1)
        lacaSpriteNode.position = CGPoint(x: dragSpriteNode.position.x + CGFloat(space),
                                          y: dragSpriteNode.position.y)
        lacaSpriteNode.zPosition = 1
        
        lacaSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: lacaNodeTexture.size().width, 
                                                                       height: lacaNodeTexture.size().height))
        lacaSpriteNode.physicsBody?.isDynamic = false
        lacaSpriteNode.physicsBody?.categoryBitMask = advantagMask
        lacaSpriteNode.physicsBody?.contactTestBitMask = enemyMask
        lacaSpriteNode.physicsBody?.collisionBitMask = 5
        
        dragNode.addChild(lacaSpriteNode)
    }
    
    func launchAttack(isRightSide: Bool) {
            var dragAttackSelected: [SKTexture] = textures.biancaAttack
            switch currentDragSelected {
            case .bianca:
                dragAttackSelected = textures.biancaAttack
            case .laganja:
                dragAttackSelected = textures.laganjaAttack
            case .jiggly:
                dragAttackSelected = textures.jigglyWalking
            case .courtney:
                dragAttackSelected = textures.courtney1Walking
            }

        if lacaSpriteNode.parent != nil {
            // La laca ya está en la escena, puedes reiniciar su posición o realizar otras acciones necesarias
            self.lacaSpriteNode.removeFromParent()
        }
        if isRightSide {
            createLaca(space: 70)
            let deathAnim = SKAction.animate(with: dragAttackSelected,
                                             timePerFrame: 0.1)
            lacaSpriteNode.xScale *= -1
            let lacaAnim = SKAction.animate(with: textures.lacaAttack,
                                            timePerFrame: 0.1)
            
            dragSpriteNode.xScale = 4

            dragSpriteNode.run(deathAnim) {
                self.lacaSpriteNode.run(lacaAnim) {
                    self.lacaSpriteNode.removeFromParent()
                    //                    self.playOkurrrSound()
                }
            }
        } else {
            createLaca(space: -70)
            let deathAnim = SKAction.animate(with: dragAttackSelected,
                                             timePerFrame: 0.1)
            let lacaAnim = SKAction.animate(with: textures.lacaAttack,
                                            timePerFrame: 0.1)
            
            dragSpriteNode.xScale = -4
            dragSpriteNode.run(deathAnim) {
                self.lacaSpriteNode.run(lacaAnim) {
                    self.lacaSpriteNode.removeFromParent()
                    //                    self.playOkurrrSound()
                }
            }
        }
    }
    
    func launch2Attack(isRightSide: Bool) {
        // Iterate over all enemies to check if they are on the attacked side
        for enemyNode in enemyNodeArray {
            guard let enemySpriteNode = enemyNode.children.first as? SKSpriteNode else { continue }
            
            // Calculate the attack range based on drag's position and direction
            let attackRange: CGFloat = 170.0
            let dragPositionX = lacaSpriteNode.position.x
            let enemyPositionX = enemySpriteNode.position.x
            let deathAnim = SKAction.animate(with: textures.deathTextureArray, timePerFrame: 0.2)
            if (isRightSide && dragPositionX < enemyPositionX && 
                enemyPositionX - dragPositionX < attackRange) ||
                (!isRightSide && dragPositionX > enemyPositionX && 
                 dragPositionX - enemyPositionX < attackRange) {
                
                    enemySpriteNode.removeAllActions()
                    enemySpriteNode.run(deathAnim) {
                    
                    enemySpriteNode.removeFromParent()
                    self.gameLogic.score(points: 1)
                }
                print("💥 Attacking on the \(isRightSide ? "RIGHT" : "LEFT") side! Enemy defeated!")
                // Break out of the loop, as we only want to defeat one enemy per attack
                break
            }
        }
    }
    /*
     func playOkurrrSound() {
     guard let okurrrSoundURL = Bundle.main.url(forResource: "okrrr", withExtension: "mp3") else {
     fatalError("Error al obtener la URL del sonido 'okurrr'")
     }
     
     let okurrrAction = SKAction.playSoundFileNamed(okurrrSoundURL.absoluteString, waitForCompletion: false)
     self.run(okurrrAction)
     }*/
}
