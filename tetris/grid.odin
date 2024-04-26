//+private
package tetris

import "core:fmt"
import rl "vendor:raylib"

grid : [20][10]int

@(private="file")
numRows : int = 20

@(private="file")
numCols : int = 10

@(private="file")
cellSize : int = 30

GridPrint :: proc() {
    for row := 0; row < numRows; row += 1 {
        for column := 0; column < numCols; column += 1 {
            fmt.printf("{} ", grid[row][column])
        }
        fmt.println()
    }
}

GridDraw :: proc() {
    for row := 0; row < numRows; row += 1 {
        for column := 0; column < numCols; column += 1 {
            cellValue := grid[row][column]
            rl.DrawRectangle(
                i32(column * cellSize + 1),
                i32(row * cellSize + 1),
                i32(cellSize - 1),
                i32(cellSize - 1),
                colors[cellValue]
            )
        }
    }
}

/*
GridIsCellOutside :: proc(row: int, column: int) -> bool {

}

GridIsCellEmpty :: proc(row: int, column: int) -> bool {

}

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
