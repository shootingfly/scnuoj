// CodeMirror, copyright (c) by Marijn Haverbeke and others
!function(e){"object"==typeof exports&&"object"==typeof module?e(require("../../lib/codemirror")):"function"==typeof define&&define.amd?define(["../../lib/codemirror"],e):e(CodeMirror)}(function(e){"use strict";function t(e,t,n,r,o,a){this.indented=e,this.column=t,this.type=n,this.info=r,this.align=o,this.prev=a}function n(e,n,r,o){var a=e.indented;return e.context&&"statement"!=e.context.type&&"statement"!=r&&(a=e.context.indented),e.context=new t(a,n,r,o,null,e.context)}function r(e){var t=e.context.type;return")"!=t&&"]"!=t&&"}"!=t||(e.indented=e.context.indented),e.context=e.context.prev}function o(e,t,n){return"variable"==t.prevToken||"variable-3"==t.prevToken?!0:/\S(?:[^- ]>|[*\]])\s*$|\*$/.test(e.string.slice(0,n))?!0:t.typeAtEndOfLine&&e.column()==e.indentation()?!0:void 0}function a(e){for(;;){if(!e||"top"==e.type)return!0;if("}"==e.type&&"namespace"!=e.prev.info)return!1;e=e.prev}}function i(e){for(var t={},n=e.split(" "),r=0;r<n.length;++r)t[n[r]]=!0;return t}function l(e,t){return"function"==typeof e?e(t):e.propertyIsEnumerable(t)}function s(e,t){if(!t.startOfLine)return!1;for(var n,r=null;n=e.peek();){if("\\"==n&&e.match(/^.$/)){r=s;break}if("/"==n&&e.match(/^\/[\/\*]/,!1))break;e.next()}return t.tokenize=r,"meta"}function c(e,t){return"variable-3"==t.prevToken?"variable-3":!1}function u(e){return e.eatWhile(/[\w\.']/),"number"}function d(e,t){if(e.backUp(1),e.match(/(R|u8R|uR|UR|LR)/)){var n=e.match(/"([^\s\\()]{0,16})\(/);return n?(t.cpp11RawStringDelim=n[1],t.tokenize=m,m(e,t)):!1}return e.match(/(u8|u|U|L)/)?e.match(/["']/,!1)?"string":!1:(e.next(),!1)}function f(e){var t=/(\w+)::(\w+)$/.exec(e);return t&&t[1]==t[2]}function p(e,t){for(var n;null!=(n=e.next());)if('"'==n&&!e.eat('"')){t.tokenize=null;break}return"string"}function m(e,t){var n=t.cpp11RawStringDelim.replace(/[^\w\s]/g,"\\$&"),r=e.match(new RegExp(".*?\\)"+n+'"'));return r?t.tokenize=null:e.skipToEnd(),"string"}function h(t,n){function r(e){if(e)for(var t in e)e.hasOwnProperty(t)&&o.push(t)}"string"==typeof t&&(t=[t]);var o=[];r(n.keywords),r(n.types),r(n.builtin),r(n.atoms),o.length&&(n.helperType=t[0],e.registerHelper("hintWords",t[0],o));for(var a=0;a<t.length;++a)e.defineMIME(t[a],n)}function g(e,t){for(var n=!1;!e.eol();){if(!n&&e.match('"""')){t.tokenize=null;break}n="\\"==e.next()&&!n}return"string"}function y(e){return function(t,n){for(var r,o=!1,a=!1;!t.eol();){if(!e&&!o&&t.match('"')){a=!0;break}if(e&&t.match('"""')){a=!0;break}r=t.next(),!o&&"$"==r&&t.match("{")&&t.skipTo("}"),o=!o&&"\\"==r&&!e}return!a&&e||(n.tokenize=null),"string"}}function x(e){return function(t,n){for(var r,o=!1,a=!1;!t.eol();){if(!o&&t.match('"')&&("single"==e||t.match('""'))){a=!0;break}if(!o&&t.match("``")){w=x(e),a=!0;break}r=t.next(),o="single"==e&&!o&&"\\"==r}return a&&(n.tokenize=null),"string"}}e.defineMode("clike",function(i,s){function c(e,t){var n=e.next();if(S[n]){var r=S[n](e,t);if(r!==!1)return r}if('"'==n||"'"==n)return t.tokenize=u(n),t.tokenize(e,t);if(D.test(n))return p=n,null;if(L.test(n)){if(e.backUp(1),e.match(I))return"number";e.next()}if("/"==n){if(e.eat("*"))return t.tokenize=d,d(e,t);if(e.eat("/"))return e.skipToEnd(),"comment"}if(F.test(n)){for(;!e.match(/^\/[\/*]/,!1)&&e.eat(F););return"operator"}if(e.eatWhile(/[\w\$_\xa1-\uffff]/),P)for(;e.match(P);)e.eatWhile(/[\w\$_\xa1-\uffff]/);var o=e.current();return l(x,o)?(l(w,o)&&(p="newstatement"),l(v,o)&&(m=!0),"keyword"):l(b,o)?"variable-3":l(k,o)?(l(w,o)&&(p="newstatement"),"builtin"):l(_,o)?"atom":"variable"}function u(e){return function(t,n){for(var r,o=!1,a=!1;null!=(r=t.next());){if(r==e&&!o){a=!0;break}o=!o&&"\\"==r}return(a||!o&&!C)&&(n.tokenize=null),"string"}}function d(e,t){for(var n,r=!1;n=e.next();){if("/"==n&&r){t.tokenize=null;break}r="*"==n}return"comment"}function f(e,t){s.typeFirstDefinitions&&e.eol()&&a(t.context)&&(t.typeAtEndOfLine=o(e,t,e.pos))}var p,m,h=i.indentUnit,g=s.statementIndentUnit||h,y=s.dontAlignCalls,x=s.keywords||{},b=s.types||{},k=s.builtin||{},w=s.blockKeywords||{},v=s.defKeywords||{},_=s.atoms||{},S=s.hooks||{},C=s.multiLineStrings,T=s.indentStatements!==!1,M=s.indentSwitch!==!1,P=s.namespaceSeparator,D=s.isPunctuationChar||/[\[\]{}\(\),;\:\.]/,L=s.numberStart||/[\d\.]/,I=s.number||/^(?:0x[a-f\d]+|0b[01]+|(?:\d+\.?\d*|\.\d+)(?:e[-+]?\d+)?)(u|ll?|l|f)?/i,F=s.isOperatorChar||/[+\-*&%=<>!?|\/]/,z=s.endStatement||/^[;:,]$/;return{startState:function(e){return{tokenize:null,context:new t((e||0)-h,0,"top",null,!1),indented:0,startOfLine:!0,prevToken:null}},token:function(e,t){var i=t.context;if(e.sol()&&(null==i.align&&(i.align=!1),t.indented=e.indentation(),t.startOfLine=!0),e.eatSpace())return f(e,t),null;p=m=null;var l=(t.tokenize||c)(e,t);if("comment"==l||"meta"==l)return l;if(null==i.align&&(i.align=!0),z.test(p))for(;"statement"==t.context.type;)r(t);else if("{"==p)n(t,e.column(),"}");else if("["==p)n(t,e.column(),"]");else if("("==p)n(t,e.column(),")");else if("}"==p){for(;"statement"==i.type;)i=r(t);for("}"==i.type&&(i=r(t));"statement"==i.type;)i=r(t)}else p==i.type?r(t):T&&(("}"==i.type||"top"==i.type)&&";"!=p||"statement"==i.type&&"newstatement"==p)&&n(t,e.column(),"statement",e.current());if("variable"==l&&("def"==t.prevToken||s.typeFirstDefinitions&&o(e,t,e.start)&&a(t.context)&&e.match(/^\s*\(/,!1))&&(l="def"),S.token){var u=S.token(e,t,l);void 0!==u&&(l=u)}return"def"==l&&s.styleDefs===!1&&(l="variable"),t.startOfLine=!1,t.prevToken=m?"def":l||p,f(e,t),l},indent:function(t,n){if(t.tokenize!=c&&null!=t.tokenize||t.typeAtEndOfLine)return e.Pass;var r=t.context,o=n&&n.charAt(0);if("statement"==r.type&&"}"==o&&(r=r.prev),s.dontIndentStatements)for(;"statement"==r.type&&s.dontIndentStatements.test(r.info);)r=r.prev;if(S.indent){var a=S.indent(t,r,n);if("number"==typeof a)return a}var i=o==r.type,l=r.prev&&"switch"==r.prev.info;if(s.allmanIndentation&&/[{(]/.test(o)){for(;"top"!=r.type&&"}"!=r.type;)r=r.prev;return r.indented}return"statement"==r.type?r.indented+("{"==o?0:g):!r.align||y&&")"==r.type?")"!=r.type||i?r.indented+(i?0:h)+(i||!l||/^(?:case|default)\b/.test(n)?0:h):r.indented+g:r.column+(i?0:1)},electricInput:M?/^\s*(?:case .*?:|default:|\{\}?|\})$/:/^\s*[{}]$/,blockCommentStart:"/*",blockCommentEnd:"*/",lineComment:"//",fold:"brace"}});var b="auto if break case register continue return default do sizeof static else struct switch extern typedef union for goto while enum const volatile",k="int long char short double float unsigned signed void size_t ptrdiff_t";h(["text/x-csrc","text/x-c","text/x-chdr"],{name:"clike",keywords:i(b),types:i(k+" bool _Complex _Bool float_t double_t intptr_t intmax_t int8_t int16_t int32_t int64_t uintptr_t uintmax_t uint8_t uint16_t uint32_t uint64_t"),blockKeywords:i("case do else for if switch while struct"),defKeywords:i("struct"),typeFirstDefinitions:!0,atoms:i("null true false"),hooks:{"#":s,"*":c},modeProps:{fold:["brace","include"]}}),h(["text/x-cpp"],{name:"clike",keywords:i(b+" asm dynamic_cast namespace reinterpret_cast try explicit new static_cast typeid catch operator template typename class friend private this using const_cast inline public throw virtual delete mutable protected alignas alignof constexpr decltype nullptr noexcept thread_local final static_assert override"),types:i(k+" bool wchar_t"),blockKeywords:i("catch class do else finally for if struct switch try while"),defKeywords:i("class namespace struct enum union"),typeFirstDefinitions:!0,atoms:i("true false null"),dontIndentStatements:/^template$/,hooks:{"#":s,"*":c,u:d,U:d,L:d,R:d,0:u,1:u,2:u,3:u,4:u,5:u,6:u,7:u,8:u,9:u,token:function(e,t,n){return"variable"!=n||"("!=e.peek()||";"!=t.prevToken&&null!=t.prevToken&&"}"!=t.prevToken||!f(e.current())?void 0:"def"}},namespaceSeparator:"::",modeProps:{fold:["brace","include"]}}),h("text/x-java",{name:"clike",keywords:i("abstract assert break case catch class const continue default do else enum extends final finally float for goto if implements import instanceof interface native new package private protected public return static strictfp super switch synchronized this throw throws transient try volatile while"),types:i("byte short int long float double boolean char void Boolean Byte Character Double Float Integer Long Number Object Short String StringBuffer StringBuilder Void"),blockKeywords:i("catch class do else finally for if switch try while"),defKeywords:i("class interface package enum"),typeFirstDefinitions:!0,atoms:i("true false null"),endStatement:/^[;:]$/,number:/^(?:0x[a-f\d_]+|0b[01_]+|(?:[\d_]+\.?\d*|\.\d+)(?:e[-+]?[\d_]+)?)(u|ll?|l|f)?/i,hooks:{"@":function(e){return e.eatWhile(/[\w\$_]/),"meta"}},modeProps:{fold:["brace","import"]}}),h("text/x-csharp",{name:"clike",keywords:i("abstract as async await base break case catch checked class const continue default delegate do else enum event explicit extern finally fixed for foreach goto if implicit in interface internal is lock namespace new operator out override params private protected public readonly ref return sealed sizeof stackalloc static struct switch this throw try typeof unchecked unsafe using virtual void volatile while add alias ascending descending dynamic from get global group into join let orderby partial remove select set value var yield"),types:i("Action Boolean Byte Char DateTime DateTimeOffset Decimal Double Func Guid Int16 Int32 Int64 Object SByte Single String Task TimeSpan UInt16 UInt32 UInt64 bool byte char decimal double short int long object sbyte float string ushort uint ulong"),blockKeywords:i("catch class do else finally for foreach if struct switch try while"),defKeywords:i("class interface namespace struct var"),typeFirstDefinitions:!0,atoms:i("true false null"),hooks:{"@":function(e,t){return e.eat('"')?(t.tokenize=p,p(e,t)):(e.eatWhile(/[\w\$_]/),"meta")}}}),h("text/x-scala",{name:"clike",keywords:i("abstract case catch class def do else extends final finally for forSome if implicit import lazy match new null object override package private protected return sealed super this throw trait try type val var while with yield _ : = => <- <: <% >: # @ assert assume require print println printf readLine readBoolean readByte readShort readChar readInt readLong readFloat readDouble :: #:: "),types:i("AnyVal App Application Array BufferedIterator BigDecimal BigInt Char Console Either Enumeration Equiv Error Exception Fractional Function IndexedSeq Int Integral Iterable Iterator List Map Numeric Nil NotNull Option Ordered Ordering PartialFunction PartialOrdering Product Proxy Range Responder Seq Serializable Set Specializable Stream StringBuilder StringContext Symbol Throwable Traversable TraversableOnce Tuple Unit Vector Boolean Byte Character CharSequence Class ClassLoader Cloneable Comparable Compiler Double Exception Float Integer Long Math Number Object Package Pair Process Runtime Runnable SecurityManager Short StackTraceElement StrictMath String StringBuffer System Thread ThreadGroup ThreadLocal Throwable Triple Void"),multiLineStrings:!0,blockKeywords:i("catch class do else finally for forSome if match switch try while"),defKeywords:i("class def object package trait type val var"),atoms:i("true false null"),indentStatements:!1,indentSwitch:!1,hooks:{"@":function(e){return e.eatWhile(/[\w\$_]/),"meta"},'"':function(e,t){return e.match('""')?(t.tokenize=g,t.tokenize(e,t)):!1},"'":function(e){return e.eatWhile(/[\w\$_\xa1-\uffff]/),"atom"},"=":function(e,n){var r=n.context;return"}"==r.type&&r.align&&e.eat(">")?(n.context=new t(r.indented,r.column,r.type,r.info,null,r.prev),"operator"):!1}},modeProps:{closeBrackets:{triples:'"'}}}),h("text/x-kotlin",{name:"clike",keywords:i("package as typealias class interface this super val var fun for is in This throw return break continue object if else while do try when !in !is as? file import where by get set abstract enum open inner override private public internal protected catch finally out final vararg reified dynamic companion constructor init sealed field property receiver param sparam lateinit data inline noinline tailrec external annotation crossinline const operator infix"),types:i("Boolean Byte Character CharSequence Class ClassLoader Cloneable Comparable Compiler Double Exception Float Integer Long Math Number Object Package Pair Process Runtime Runnable SecurityManager Short StackTraceElement StrictMath String StringBuffer System Thread ThreadGroup ThreadLocal Throwable Triple Void"),intendSwitch:!1,indentStatements:!1,multiLineStrings:!0,blockKeywords:i("catch class do else finally for if where try while enum"),defKeywords:i("class val var object package interface fun"),atoms:i("true false null this"),hooks:{'"':function(e,t){return t.tokenize=y(e.match('""')),t.tokenize(e,t)}},modeProps:{closeBrackets:{triples:'"'}}}),h(["x-shader/x-vertex","x-shader/x-fragment"],{name:"clike",keywords:i("sampler1D sampler2D sampler3D samplerCube sampler1DShadow sampler2DShadow const attribute uniform varying break continue discard return for while do if else struct in out inout"),types:i("float int bool void vec2 vec3 vec4 ivec2 ivec3 ivec4 bvec2 bvec3 bvec4 mat2 mat3 mat4"),blockKeywords:i("for while do if else struct"),builtin:i("radians degrees sin cos tan asin acos atan pow exp log exp2 sqrt inversesqrt abs sign floor ceil fract mod min max clamp mix step smoothstep length distance dot cross normalize ftransform faceforward reflect refract matrixCompMult lessThan lessThanEqual greaterThan greaterThanEqual equal notEqual any all not texture1D texture1DProj texture1DLod texture1DProjLod texture2D texture2DProj texture2DLod texture2DProjLod texture3D texture3DProj texture3DLod texture3DProjLod textureCube textureCubeLod shadow1D shadow2D shadow1DProj shadow2DProj shadow1DLod shadow2DLod shadow1DProjLod shadow2DProjLod dFdx dFdy fwidth noise1 noise2 noise3 noise4"),atoms:i("true false gl_FragColor gl_SecondaryColor gl_Normal gl_Vertex gl_MultiTexCoord0 gl_MultiTexCoord1 gl_MultiTexCoord2 gl_MultiTexCoord3 gl_MultiTexCoord4 gl_MultiTexCoord5 gl_MultiTexCoord6 gl_MultiTexCoord7 gl_FogCoord gl_PointCoord gl_Position gl_PointSize gl_ClipVertex gl_FrontColor gl_BackColor gl_FrontSecondaryColor gl_BackSecondaryColor gl_TexCoord gl_FogFragCoord gl_FragCoord gl_FrontFacing gl_FragData gl_FragDepth gl_ModelViewMatrix gl_ProjectionMatrix gl_ModelViewProjectionMatrix gl_TextureMatrix gl_NormalMatrix gl_ModelViewMatrixInverse gl_ProjectionMatrixInverse gl_ModelViewProjectionMatrixInverse gl_TexureMatrixTranspose gl_ModelViewMatrixInverseTranspose gl_ProjectionMatrixInverseTranspose gl_ModelViewProjectionMatrixInverseTranspose gl_TextureMatrixInverseTranspose gl_NormalScale gl_DepthRange gl_ClipPlane gl_Point gl_FrontMaterial gl_BackMaterial gl_LightSource gl_LightModel gl_FrontLightModelProduct gl_BackLightModelProduct gl_TextureColor gl_EyePlaneS gl_EyePlaneT gl_EyePlaneR gl_EyePlaneQ gl_FogParameters gl_MaxLights gl_MaxClipPlanes gl_MaxTextureUnits gl_MaxTextureCoords gl_MaxVertexAttribs gl_MaxVertexUniformComponents gl_MaxVaryingFloats gl_MaxVertexTextureImageUnits gl_MaxTextureImageUnits gl_MaxFragmentUniformComponents gl_MaxCombineTextureImageUnits gl_MaxDrawBuffers"),indentSwitch:!1,hooks:{"#":s},modeProps:{fold:["brace","include"]}}),h("text/x-nesc",{name:"clike",keywords:i(b+"as atomic async call command component components configuration event generic implementation includes interface module new norace nx_struct nx_union post provides signal task uses abstract extends"),types:i(k),blockKeywords:i("case do else for if switch while struct"),atoms:i("null true false"),hooks:{"#":s},modeProps:{fold:["brace","include"]}}),h("text/x-objectivec",{name:"clike",keywords:i(b+"inline restrict _Bool _Complex _Imaginary BOOL Class bycopy byref id IMP in inout nil oneway out Protocol SEL self super atomic nonatomic retain copy readwrite readonly"),types:i(k),atoms:i("YES NO NULL NILL ON OFF true false"),hooks:{"@":function(e){return e.eatWhile(/[\w\$]/),"keyword"},"#":s,indent:function(e,t,n){return"statement"==t.type&&/^@\w/.test(n)?t.indented:void 0}},modeProps:{fold:"brace"}}),h("text/x-squirrel",{name:"clike",keywords:i("base break clone continue const default delete enum extends function in class foreach local resume return this throw typeof yield constructor instanceof static"),types:i(k),blockKeywords:i("case catch class else for foreach if switch try while"),defKeywords:i("function local class"),typeFirstDefinitions:!0,atoms:i("true false null"),hooks:{"#":s},modeProps:{fold:["brace","include"]}});var w=null;h("text/x-ceylon",{name:"clike",keywords:i("abstracts alias assembly assert assign break case catch class continue dynamic else exists extends finally for function given if import in interface is let module new nonempty object of out outer package return satisfies super switch then this throw try value void while"),types:function(e){var t=e.charAt(0);return t===t.toUpperCase()&&t!==t.toLowerCase()},blockKeywords:i("case catch class dynamic else finally for function if interface module new object switch try while"),defKeywords:i("class dynamic function interface module object package value"),builtin:i("abstract actual aliased annotation by default deprecated doc final formal late license native optional sealed see serializable shared suppressWarnings tagged throws variable"),isPunctuationChar:/[\[\]{}\(\),;\:\.`]/,isOperatorChar:/[+\-*&%=<>!?|^~:\/]/,numberStart:/[\d#$]/,number:/^(?:#[\da-fA-F_]+|\$[01_]+|[\d_]+[kMGTPmunpf]?|[\d_]+\.[\d_]+(?:[eE][-+]?\d+|[kMGTPmunpf]|)|)/i,multiLineStrings:!0,typeFirstDefinitions:!0,atoms:i("true false null larger smaller equal empty finished"),indentSwitch:!1,styleDefs:!1,hooks:{"@":function(e){return e.eatWhile(/[\w\$_]/),"meta"},'"':function(e,t){return t.tokenize=x(e.match('""')?"triple":"single"),t.tokenize(e,t)},"`":function(e,t){return w&&e.match("`")?(t.tokenize=w,w=null,t.tokenize(e,t)):!1},"'":function(e){return e.eatWhile(/[\w\$_\xa1-\uffff]/),"atom"},token:function(e,t,n){return"variable"!=n&&"variable-3"!=n||"."!=t.prevToken?void 0:"variable-2"}},modeProps:{fold:["brace","import"],closeBrackets:{triples:'"'}}})});