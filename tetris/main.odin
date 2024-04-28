package tetris

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(500, 620, "raylib Tetris")
    rl.SetWindowPosition(30, 60)
    rl.SetTargetFPS(60)

    GameInitialize()

    for !rl.WindowShouldClose() {
        rl.UpdateMusicStream(music)
        GameHandleInput(&currentBlock)
        if EventTriggered(0.2) {
            MoveBlockDown(&currentBlock)
        }
        rl.BeginDrawing()
        rl.ClearBackground(darkBlue)
        rl.DrawTextEx(font, "Score", {365, 15}, 38, 2, rl.WHITE)
        rl.DrawTextEx(font, "Next", {370, 175}, 38, 2, rl.WHITE)
        if gameOver {
            rl.DrawTextEx(font, "GAME OVER", {340, 450}, 38, 2, rl.WHITE)
        }
        rl.DrawRectangleRounded({320, 55, 170, 60}, 0.3, 6, lightBlue)
        //scoreText : [10]rune
        GridDraw()
        GameDraw()
        rl.EndDrawing()
    }
    
    defer GameDelete()
    defer rl.CloseWindow()

}