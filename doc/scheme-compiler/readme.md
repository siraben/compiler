## Bootstrapping phase descriptions
This is done so that one can easily diff the languages accepted by
each compiler.  For instance, `git diff --no-index 00* 01*` produces:

```diff
diff --git a/00-semantically.txt b/01-lispy.txt
index 4c96255..4b6c623 100644
--- a/00-semantically.txt
+++ b/01-lispy.txt
@@ -3,7 +3,8 @@ Semantics
 - call-by-need

 Syntax
-- Haskell
+- Lisp
+- strings

 Primitives
 - extended SKI combinators
```
