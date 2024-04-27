package tetris

import rl "vendor:raylib"

Block :: struct {
    id : int,
    cellSize : int,
    rotationState : int,
    rowOffset : int,
    columnOffset : int,
    position : [][4]Position
}

Position :: struct {
    row, column: int
}

LBlock := Block {
    id = 1,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = 0,
    columnOffset = 3,
    position = {
        {{0, 2}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 1}, {1, 1}, {2, 1}, {2, 2}},
        {{1, 0}, {1, 1}, {1, 2}, {2, 0}},
        {{0, 0}, {0, 1}, {1, 1}, {2, 1}}
    }
}

JBlock := Block {
    id = 2,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = 0,
    columnOffset = 3,
    position = {
        {{0, 0}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 1}, {0, 2}, {1, 1}, {2, 1}},
        {{1, 0}, {1, 1}, {1, 2}, {2, 2}},
        {{0, 1}, {1, 1}, {2, 0}, {2, 1}}
    }
}

IBlock := Block {
    id = 3,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = -1,
    columnOffset = 3,
    position = {
        {{1, 0}, {1, 1}, {1, 2}, {1, 3}},
        {{0, 2}, {1, 2}, {2, 2}, {3, 2}},
        {{2, 0}, {2, 1}, {2, 2}, {2, 3}},
        {{0, 1}, {1, 1}, {2, 1}, {3, 1}}
    }
}

OBlock := Block {
    id = 4,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = 0,
    columnOffset = 4,
    position = {
        {{0, 0}, {0,1}, {1,0}, {1, 1}}
    }
}

SBlock := Block {
    id = 5,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = 0,
    columnOffset = 3,
    position = {
        {{0, 1}, {0, 2}, {1, 0}, {1, 1}},
        {{0, 1}, {1, 1}, {1, 2}, {2, 2}},
        {{1, 1}, {1, 2}, {2, 0}, {2, 1}},
        {{0, 0}, {1, 0}, {1, 1}, {2, 1}}
    }
}

TBlock := Block {
    id = 6,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = 0,
    columnOffset = 3,
    position = {
        {{0, 1}, {1, 0}, {1, 1}, {1, 2}},
        {{0, 1}, {1, 1}, {1, 2}, {2, 1}},
        {{1, 0}, {1, 1}, {1, 2}, {2, 1}},
        {{0, 1}, {1, 0}, {1, 1}, {2, 1}}
    }
}

ZBlock := Block {
    id = 7,
    cellSize = CELL_SIZE,
    rotationState = 0,
    rowOffset = 0,
    columnOffset = 3,
    position = {
        {{0, 0}, {0, 1}, {1, 1}, {1, 2}},
        {{0, 2}, {1, 1}, {1, 2}, {2, 1}},
        {{1, 0}, {1, 1}, {2, 1}, {2, 2}},
        {{0, 1}, {1, 0}, {1, 1}, {2, 0}}
    }
}

BlockDraw :: proc(block: ^Block, offsetX: int, offsetY: int) {
    tiles := BlockGetCellPositions(block)
    for item in tiles {
        rl.DrawRectangle(
            i32(item.column * block.cellSize + offsetX),
            i32(item.row * block.cellSize + offsetY),
            i32(block.cellSize - 1),
            i32(block.cellSize -1),
            colors[block.id]
        )
    }
}

BlockMove :: proc(block: ^Block, rows: int, columns: int) {
    block^.rowOffset += rows
    block^.columnOffset += columns
}

BlockGetCellPositions :: proc(block: ^Block) -> [dynamic]Position {
    tiles := block.position[block.rotationState]
    movedTiles : [dynamic]Position
    for item in tiles {
        newPos : Position = {item.row + block.rowOffset, item.column + block.columnOffset}
        append(&movedTiles, newPos)
    }
    return movedTiles
}

BlockRotate :: proc(block: ^Block) {
    block^.rotationState += 1
    if block.rotationState == len(block.position) {
        block^.rotationState = 0
    }
}

BlockUndoRotation :: proc(block: ^Block) {
    block^.rotationState -= 1
    if block.rotationState == -1 {
        block^.rotationState = len(block.position) - 1
    }
}