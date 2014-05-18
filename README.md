zest3d-zesl-fp11
================

ZESL shader compiler

Dependencies
============

* https://github.com/PluginIO/plugin-core-fp11

What is ZESL?
=============

ZESL is an **in development** shader language and compiler for Stage3D. ZESL aims to define a high level shader language, similar to GLSL or Cg, that compiles to AGAL assembly code.

#### WARNING

ZESL is currenlty in development and is **NOT** to be considered stable.

#### Current Usage

```javascript
var parser:Parser = new Parser();
var expr:IExpressionNode = parser.parse( "pi*(6+(3/2))" );
expr.accept( new SetVariable("pi", Math.PI) );
			
trace( "Result: " + expr.value );
```
