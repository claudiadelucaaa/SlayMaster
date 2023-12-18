//
//  Textures.swift
//  Test2
//
//  Created by Claudia De Luca on 11/12/23.
//

//  Texture.swift
//  DragGame
//
//  Created by Ferdinando Liccardi on 07/12/23.
//

import Foundation
import SpriteKit

class Textures {
    let biancaWalking : [SKTexture] = [SKTexture(imageNamed: "Bianca1"),
                                       SKTexture(imageNamed: "Bianca2"),
                                       SKTexture(imageNamed: "Bianca3"),
                                       SKTexture(imageNamed: "Bianca4"),
                                       SKTexture(imageNamed: "Bianca5")
    ]
    
    let laganjaWalking : [SKTexture] = [SKTexture(imageNamed: "Laganja1"),
                                        SKTexture(imageNamed: "Laganja2"),
                                        SKTexture(imageNamed: "Laganja3")
         ]
    
    let dragRunTextureArray : [SKTexture] = [SKTexture(imageNamed: "man1"),
                                             SKTexture(imageNamed: "man2"),
                                             SKTexture(imageNamed: "man3"),
                                             SKTexture(imageNamed: "man4"),
                                             SKTexture(imageNamed: "man5"),
                                             SKTexture(imageNamed: "man6")
    ]
    
    let dragJumpTextureArray : [SKTexture] = [SKTexture(imageNamed: "Warrior_Jump_1"),
                                             SKTexture(imageNamed: "Warrior_Jump_2"),
                                             SKTexture(imageNamed: "Warrior_Jump_3"),
                                             SKTexture(imageNamed: "Warrior_UptoFall_1"),
                                             SKTexture(imageNamed: "Warrior_UptoFall_2"),
                                             SKTexture(imageNamed: "Warrior_Fall_1"),
    ]

    let bgLayerTextures : [(SKTexture, CGFloat)]  = [(SKTexture(imageNamed: "Layer_0000_9"), 3),
                                                     (SKTexture(imageNamed: "Layer_0001_8"), 3),
                                                     (SKTexture(imageNamed: "Layer_0002_7"), 3),
                                                     (SKTexture(imageNamed: "Layer_0003_6"), 3),
                                                     (SKTexture(imageNamed: "Layer_0004_Lights"), 2.5),
                                                     (SKTexture(imageNamed: "Layer_0005_5"), 4),
                                                     (SKTexture(imageNamed: "Layer_0006_4"), 4),
                                                     (SKTexture(imageNamed: "Layer_0007_Lights"), 3.5),
                                                     (SKTexture(imageNamed: "Layer_0008_3"), 5),
                                                     (SKTexture(imageNamed: "Layer_0009_2"), 5),
                                                     (SKTexture(imageNamed: "Layer_0010_1"), 5)
    ]
    
    let deathTextureArray: [SKTexture] = [SKTexture(imageNamed: "manDie1"),
                                          SKTexture(imageNamed: "manDie2"),
                                          SKTexture(imageNamed: "manDie3"),
                                          SKTexture(imageNamed: "manDie4")
    ]
    
    let enemyTexture: [SKTexture] = [SKTexture(imageNamed: "fly01"),
                                     SKTexture(imageNamed: "fly02"),
                                     SKTexture(imageNamed: "fly03"),
                                     SKTexture(imageNamed: "fly04"),
                                     SKTexture(imageNamed: "fly05"),
                                     SKTexture(imageNamed: "fly06"),
                                     SKTexture(imageNamed: "fly07")
    ]
    
    let biancaAttack: [SKTexture] = [SKTexture(imageNamed: "BiancaAttack1"),
                                     SKTexture(imageNamed: "BiancaAttack2"),
                                     SKTexture(imageNamed: "BiancaAttack3"),
                                     SKTexture(imageNamed: "BiancaAttack4"),
                                     SKTexture(imageNamed: "BiancaAttack5"),
                                     SKTexture(imageNamed: "BiancaAttack6")
    ]
    
    let laganjaAttack : [SKTexture] = [ SKTexture(imageNamed: "Laganja4"),
                                        SKTexture(imageNamed: "Laganja5"),
                                        SKTexture(imageNamed: "Laganja6"),
                                        SKTexture(imageNamed: "Laganja7")
    ]
    let lacaAttack : [SKTexture] = [SKTexture(imageNamed: "laca3"),
                                    SKTexture(imageNamed: "laca2"),
                                    SKTexture(imageNamed: "laca1"),
                                    SKTexture(imageNamed: "laca1")
    ]

}

struct drag {
    var type: DragChoice = .bianca
    var id: UUID = UUID()
    var name: String
    var image: String
    var superPower: String
    var pic: String
}

class Drags {
    let dragS =         [drag(type: .bianca, 
                              name: "Bianca",
                              image: "Bianca1",
                              superPower: "Twist",
                              pic: "Biancapic"),
                         drag(type: .laganja, 
                              name: "Laganja",
                              image: "Laganja1",
                              superPower: "Lacca",
                              pic: "Laganjapic"),
                         drag(type: .jiggly, 
                              name: "Jiggly",
                              image: "Jiggly1",
                              superPower: "Wings",
                              pic: "Jigglypic"),
                         drag(type: .courtney, 
                              name: "Courtney",
                              image: "Courtney1",
                              superPower: "No one",
                              pic: "Courtneypic")
    ]
}
