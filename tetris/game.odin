package tetris

import rl "vendor:raylib"


GameInitialize :: proc() {
    currentBlock = GetRandomBlock()
    nextBlock = GetRandomBlock()
    gameOver = false
    score = 0
    lastUpdateTime = 0
    font = rl.LoadFontEx(GetFilePath("/font/monogram.ttf"), 64, runeFont, 0)
    rl.InitAudioDevice()
    music = rl.LoadMusicStream(GetFilePath("/sounds/Sounds_music.mp3"))
    rl.PlayMusicStream(music)
    rotateSound = rl.LoadSound(GetFilePath("/sounds/Sounds_rotate.mp3"))
    clearSound = rl.LoadSound(GetFilePath("/sounds/Sounds_clear.mp3"))
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
    case .DOWN:
        MoveBlockDown(playerBlock)
        UpdateScore(0, 1)
    case .UP:
        RotateBlock(playerBlock)
    }
}

GameReset :: proc() {
    currentBlock = GetRandomBlock()
    nextBlock = GetRandomBlock()
    GridReset()
    score = 0
}

LockBlock :: proc(block: ^Block) {
    tiles := BlockGetCellPositions(block)
    for item in tiles {
        Grid[item.row][item.column] = block.id
    }
    block^ = nextBlock
    if BlockFits(block) == false do gameOver = true
    nextBlock = GetRandomBlock()
    rowsCleared := GridClearFullRows()
    if rowsCleared > 0 {
        rl.PlaySound(clearSound)
        UpdateScore(rowsCleared, 0)
    }
}

UpdateScore :: proc(linesCleared: int, moveDownPoints: u32) {
    switch linesCleared {
    case 1:
        score += 100
    case 2:
        score += 300
    case 3:
        score += 500
    case:
    }
    score += moveDownPoints
}
