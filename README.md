# Bootstrapping GCC from combinatory logic
![Build
Status](https://github.com/siraben/compiler/workflows/Build/badge.svg)

The [stage0](https://github.com/oriansj/stage0),
[mes-m2](https://github.com/oriansj/mes-m2/) and
[mescc-tools](https://savannah.nongnu.org/projects/mescc-tools)
projects combined would make it possible to compile GCC starting from
a minimal trusted binary less than 1 KB in size.  This project
represents a promising alternative approach based on [Ben
Lynn's](https://crypto.stanford.edu/~blynn/)
[compiler](https://crypto.stanford.edu/~blynn/) for a subset of
Haskell.  The entire process starts with a [single C file](./vm.c)
which reads [ION
assembly](https://crypto.stanford.edu/~blynn/compiler/asm.html), then
[a few trusted
compilers](https://crypto.stanford.edu/~blynn/compiler/quest.html)
(which could be compiled manually by a motivated person), until the
[first self-hosting version](./singularity) is reached.

Then a successive chain of compilers ends with a dialect of
Haskell 98.  We can take advantage of this to complete the
bootstrapping to GCC.  The goals in mind are to complete the bootstrap
in as little effort as possible, while still maintaining correctness
and readability.

## Proposed bootstrapping paths
### From a Scheme interpreter in Haskell
Since Ben Lynn's compiler already bootstraps a large subset of Haskell
(layout parsing, monadic I/O, typeclasses, etc.), it would not be
difficult to write a Scheme interpreter (see
[r5rs-denot](https://github.com/siraben/r5rs-denot) for a
semantics-conforming R5RS interpreter).  This Scheme interpreter would
accept Scheme code from stdin and interpret it.

#### Advantages
- Heavy work of implementing many of Haskell's features has been done
  already.
- Can use GHC to aid development of the interpreter (Ben Lynn's
  Haskell dialect with a short preamble can be read by GHC),
  especially with testing, type checking and linting.
- Easier verification of interpreter since written in standard
  Haskell and should be based on denotational semantics.

#### Disadvantages
- Bootstrapping is slower, more resource intensive intermediate
  phases, compared to an alternative approach below.
- Fully understanding and verifying all the passes requires knowledge
  of parser combinators, type inference, semantic bracket abstraction,
  among others.

### From a Scheme compiler in Haskell
See [this folder](./doc/scheme-compiler) for the technical details of
the intermediate languages.

#### Advantages
- More precise bootstrapping path, i.e. implementing type inference,
  parsing fixity declarations are not needed.
- Scheme compiler could be more efficient than interpretation.

#### Disadvantages
- More work to do, and since the intermediate languages are custom and
  typeless we cannot really reuse existing tooling elsewhere to aid us.
- Requires to compile a call-by-value language into one that is
  call-by-name, probably via [CPS
  conversion](https://en.wikipedia.org/wiki/Continuation-passing_style),
  effect on time and space usage unknown.

## Resources
It is recommended to have good knowledge of functional languages,
their theory and implementation.  For more specialized topics the
relevant resources are shown below.

### Parsing
- [Applicative programming with
  effects](https://openaccess.city.ac.uk/id/eprint/13222/1/), [Monadic
  parser
  combinators](https://nottingham-repository.worktribe.com/preview/1024448/monparsing.pdf)
  - After singularity, every compiler uses applicative parser
    combinators.

### Type system
- [Typing Haskell in
  Haskell](https://web.cecs.pdx.edu/~mpj/thih/thih.pdf)
  - The type checking and inference code is taken from this paper.
- [Tackling the Awkward Squad: monadic input/output, concurrency,
  exceptions, and foreign-language calls in
  Haskell](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/07/mark.pdf)
  - The effectively compiler adds IO and FFI.  This paper gives
    relevant background on how it is implemented.

### Compilation
- [Scott
  encoding](https://crypto.stanford.edu/~blynn/compiler/scott.html)
  - Turns out compiling algebraic data types and pattern matching
    isn't hard at all, if you know how to rewrite it to lambda
    calculus.  Scott encoding is one such method.
- [Lambda to SKI,
  Semantically](http://okmij.org/ftp/tagless-final/ski.pdf)
  - Without the results from this paper, compiling to combinators
    would be far more inefficient.  The paper uses a semantic
    translation rather than the usual syntactic translation, thus
    making compositionality and correctness-preservation more
    self-evident.
