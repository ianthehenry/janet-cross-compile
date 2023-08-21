(declare-project
  :name "demo"
  :description "a demo of cross-compilation with jpm")

(declare-executable
  :name "demo"
  :entry "main.janet"
  :no-compile true)

(defmacro make-build [name target &opt extra-cflags]
  (default extra-cflags "")
  ~(task ,name ["build/demo.c"]
    (shell ,(string/format "zig cc -c janet/janet.c -DJANET_BUILD_TYPE=release -std=c99 -target %s -I./janet/ -O2 -o build/janet-%s.o" target name))
    (shell ,(string/format "zig cc -c build/demo.c -DJANET_BUILD_TYPE=release -std=c99 -target %s -I./janet/ -O2 -o build/demo-%s.o" target name))
    (shell ,(string/format "zig cc -std=c99 -target %s -I./janet/ -O2 -o build/demo-%s build/demo-%s.o build/janet-%s.o -lm -ldl -pthread -Wl" target name name name))
    ))

(make-build "linux" "x86_64-linux")
(make-build "macos-intel" "x86_64-macos-none")
(make-build "macos-arm" "aarch64-macos-none")

(task "build" ["linux" "macos-intel" "macos-arm"])
