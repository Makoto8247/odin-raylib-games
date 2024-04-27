package tetris

import "core:fmt"
import "core:strings"
import rl "vendor:raylib"

currentBlock : Block
nextBlock : Block
gameOver : bool
score : u32
music : rl.Music
rotateSound : rl.Sound
clearSound : rl.Sound

GameInitialize :: proc() {
    currentBlock = GetRandomBlock()
    nextBlock = GetRandomBlock()
    gameOver = false
    score = 0
    rl.InitAudioDevice()
    music = rl.LoadMusicStream(strings.unsafe_string_to_cstring(GetFilePath("/sounds/Sounds_music.mp3")))
    rl.PlayMusicStream(music)
    rotateSound = rl.LoadSound(strings.unsafe_string_to_cstring(GetFilePath("/sounds/Sounds_rotate.mp3")))
    clearSound = rl.LoadSound(strings.unsafe_string_to_cstring(GetFilePath("/sounds/Sounds_clear.mp3")))
}

GameDelete :: proc() {
    rl.UnloadSound(rotateSound)
    rl.UnloadSound(clearSound)
    rl.UnloadMusicStream(music)
    rl.CloseAudioDevice()
}

GameDraw :: proc() {
    GridDraw()
    BlockDraw(&currentBlock, 11, 11)
    switch nextBlock.id {
    case 3:
        BlockDraw(&nextBlock, 255, 290)
    case 4:
        BlockDraw(&nextBlock, 255, 280)
    case:
        BlockDraw(&nextBlock, 270, 270)
    }
}

GameHandleInput :: proc(playerBlock: ^Block) {
    keyPressed := rl.GetKeyPressed()
    if gameOver == true && keyPressed != .KEY_NULL {
        gameOver = false;
        GameReset()
    }

    #partial switch keyPressed {
    case .LEFT:
        MoveBlockLeft(playerBlock)
    case .RIGHT:
        MoveBlockRight(playerBlock)
    }
}

GameReset :: proc() {
    currentBlock = GetRandomBlock()
    nextBlock = GetRandomBlock()
    score = 0
}
