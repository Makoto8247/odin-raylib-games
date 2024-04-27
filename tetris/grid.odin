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
/*
GridClearFullRows :: proc() -> int {

}

@(private="file")
GridIsRowFull :: proc(row: int) -> bool {

}

@(private="file")
GridClearRow :: proc(row: int) {

}

@(private="file")
GridMoveRowDown :: proc(row: int, numRows: int) {

}
*/
