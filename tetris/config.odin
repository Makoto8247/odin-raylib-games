//+private
package tetris

import "core:strings"
import "core:path/slashpath"
import rl "vendor:raylib"

numRows : int : 20
numCols : int : 10

CELL_SIZE : int : 30

FILE_PATH := slashpath.dir(#file)


currentBlock    : Block
nextBlock       : Block
gameOver        : bool
score           : u32
runeFont        : [^]rune
music           : rl.Music
rotateSound     : rl.Sound
clearSound      : rl.Sound
font            : rl.Font
lastUpdateTime  : f64

GetFilePath :: proc(path: string) -> cstring{
    setPath: string
    if path[0] == '/' {
        setPath = strings.join({FILE_PATH, path}, "")
    } else {
        setPath = strings.join({FILE_PATH, path}, "/")
    }

    defer delete(setPath)
    return strings.unsafe_string_to_cstring(setPath)
}

EventTriggered :: proc(interval: f64) -> bool {
    currentTime := rl.GetTime()
    if (currentTime - lastUpdateTime >= interval) {
        lastUpdateTime = currentTime
        return true
    }
    return false
}

