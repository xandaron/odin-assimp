import zlib "vendor:zlib"

_ :: zlib

when ODIN_OS == .Windows {
    foreign import lib "libassimp.lib"
}
else {
    foreign import lib "libassimp.a"
}