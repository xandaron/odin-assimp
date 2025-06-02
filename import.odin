import zlib "vendor:zlib"

_ :: zlib

// I need to figue out this linker flag out as the compiler will complain that libz is missing
// @(extra_linker_flags="")
when ODIN_OS == .Windows {
    when ODIN_DEBUG {
        foreign import lib "libassimp_debug.lib"
    }
    else {
        foreign import lib "libassimp_release.lib"
    }
}
else {
    foreign import lib "system:libassimp.so"
}