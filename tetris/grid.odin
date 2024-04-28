//+private
package tetris

import "core:fmt"
import rl "vendor:raylib"

Grid : [20][10]int

GridPrint :: proc() {
    for row := 0; row < numRows; row += 1 {
        for column := 0; column < numCols; column += 1 {
            fmt.printf("{} ", Grid[row][column])
        }
        fmt.println()
    }
}

GridDraw :: proc() {
    for row := 0; row < numRows; row += 1 {
        for column := 0; column < numCols; column += 1 {
            cellValue := Grid[row][column]
            rl.DrawRectangle(
                i32(column * CELL_SIZE + 1),
                i32(row * CELL_SIZE + 1),
                i32(CELL_SIZE - 1),
                i32(CELL_SIZE - 1),
                colors[cellValue]
            )
        }
    }
}

GridReset :: proc() {
    for row := 0; row < 20; row += 1 {
        for column := 0; column < 10; column += 1 {
            Grid[row][column] = 0
        }
    }
}

GridIsCellOutside :: proc(row: int, column: int) -> bool {
    if (row >= 0 && row < numRows && column >= 0 && column < numCols) {
        return false
    }
    return true
}

GridIsCellEmpty :: proc(row: int, column: int) -> bool {
    if Grid[row][column] == 0 do return true
    return false
}

GridClearFullRows :: proc() -> int {
    completed := 0
    for row := numRows - 1; row >= 0; row -= 1 {
        if IsRowFull(row) {
            ClearRow(row)
            completed += 1
        } else if completed > 0 {
            MoveRowDown(row, completed)
        }
    }
    return completed
}

@(private="file")
IsRowFull :: proc(row: int) -> bool {
    for column := 0; column < numCols; column += 1 {
        if Grid[row][column] == 0 {
            return false
        }
    }
    return true
}

@(private="file")
ClearRow :: proc(row: int) {
    for column := 0; column < numCols; column += 1 {
        Grid[row][column] = 0
    }
}

@(private="file")
MoveRowDown :: proc(row: int, numRows: int) {
    for column := 0; column < numCols; column += 1 {
        Grid[row + numRows][column] = Grid[row][column]
        Grid[row][column] = 0
    }
}
