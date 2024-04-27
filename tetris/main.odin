package tetris

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(300, 600, "raylib Tetris")
    rl.SetWindowPosition(30, 60)
    rl.SetTargetFPS(60)

    GameInitialize()

    // Check maked grid
    GridPrint()
    playerBlock := TBlock

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(darkBlue)
        GridDraw()
        BlockDraw(&playerBlock)
        rl.EndDrawing()
    }
    
    defer GameDelete()
    defer rl.CloseWindow()

}