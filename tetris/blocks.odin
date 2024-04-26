package tetris

import rl "vendor:raylib"

Block : struct {
    cellSize : int,
    rotationState : int,
    color : rl.Color,
    rowOffset : int,
    columnOffset : int
}

BlockDrow :: proc(offsetX: int, offsetY: int) {

}
