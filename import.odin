// I'm not 100% if this import is necessary as assimp definitely have a zlib dependency but that dependency could be build into the lib (which I think would cause it's own issues with redefinition of symbols at compile time).
import "vendor:zlib"

when ODIN_OS == .Windows {
    foreign import lib "libassimp-windows.lib"
}
else when ODIN_OS == .Linux {
    foreign import lib "libassimp-linux.a"
}