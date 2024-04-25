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

@(private="file")
colors : #soa[dynamic]rl.Color

GridPrint :: proc() {
    for row := 0; row < numRows; row += 1 {
        for column := 0; column < numCols; column += 1 {
            fmt.printf("{} ", grid[row][column])
        }
        fmt.println()
    }
}

