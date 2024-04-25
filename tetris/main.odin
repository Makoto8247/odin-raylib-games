package tetris

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(300, 600, "raylib Tetris")
    rl.SetWindowPosition(30, 60)
    rl.SetTargetFPS(60)

    // Check maked grid
    GridPrint()

    for !rl.WindowShouldClose() {
        rl.BeginDrawing()
        rl.ClearBackground(BACKGROUND_COLOR)
        rl.EndDrawing()
    }

    defer rl.CloseWindow()

}