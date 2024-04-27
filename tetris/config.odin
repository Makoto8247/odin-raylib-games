//+private
package tetris

import "core:strings"
import "core:path/slashpath"

numRows : int : 20
numCols : int : 10

CELL_SIZE : int : 30

FILE_PATH := slashpath.dir(#file)

GetFilePath :: proc(path: string) -> string{
    setPath: string
    if path[0] == '/' {
        setPath = strings.join({FILE_PATH, path}, "")
    } else {
        setPath = strings.join({FILE_PATH, path}, "/")
    }

    defer delete(setPath)
    return setPath
}