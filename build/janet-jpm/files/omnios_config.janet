(def prefix "/opt/ooce/janet")

(def config 
  {:ar "ar"
   :auto-shebang true
   :binpath (string prefix "/bin")
   :c++ "g++"
   :c++-link "g++"
   :cc "gcc"
   :cc-link "gcc"
   :cflags @["-std=c99" "-D__EXTENSIONS__" "-DJANET_NO_NANBOX"]
   :cflags-verbose @["-Wall" "-Wextra"]
   :cppflags @["-std=c++11"]
   :curlpath "curl"
   :dynamic-cflags @["-fPIC"]
   :dynamic-lflags @["-shared" "-pthread"]
   :gitpath "git"
   :headerpath (string prefix "/include/janet")
   :is-msvc false
   :janet "janet"
   :janet-cflags @[]
   :janet-lflags @["-lm" "-ldl" "-lrt" "-pthread"]
   :ldflags @[]
   :lflags @[]
   :libpath (string prefix "/lib")
   :local false
   :manpath (string prefix "/share/man/man1")
   :modext ".so"
   :modpath (string prefix "/lib/janet")
   :nocolor false
   :optimize 2
   :pkglist "https://github.com/janet-lang/pkgs.git"
   :silent false
   :statext ".a"
   :tarpath "gtar"
   :test false
   :use-batch-shell false
   :verbose false})
