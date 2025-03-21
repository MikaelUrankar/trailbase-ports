--- cargo-crates/sqlite-vec-0.1.6/sqlite-vec.c.orig	2025-03-21 15:17:25.745830000 +0100
+++ cargo-crates/sqlite-vec-0.1.6/sqlite-vec.c	2025-03-21 15:17:35.922879000 +0100
@@ -10,6 +10,7 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/types.h>
 
 #ifndef SQLITE_VEC_OMIT_FS
 #include <stdio.h>
