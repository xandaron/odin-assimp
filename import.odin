import zlib "vendor:zlib"

_ :: zlib

// I need to figue out this linker flag out as the compiler will complain that libz is missing
// @(extra_linker_flags="")
when ODIN_OS == .Windows {
    foreign import lib "libassimp.lib"
}
else {
    foreign import lib "system:assimp"
}