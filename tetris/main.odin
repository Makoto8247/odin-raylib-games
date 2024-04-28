package tetris

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(300, 600, "raylib Tetris")
    rl.SetWindowPosition(30, 60)
    rl.SetTargetFPS(60)

    GameInitialize()

    for !rl.WindowShouldClose() {
        rl.UpdateMusicStream(music)
        rl.BeginDrawing()
        rl.ClearBackground(darkBlue)
        GridDraw()
        rl.EndDrawing()
    }
    
    defer GameDelete()
    defer rl.CloseWindow()

}