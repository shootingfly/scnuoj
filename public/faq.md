### Frequently Asked Questions 
#### 1. 关于SCNUOJ
+ SCNUOJ：全称为华南师范大学ACM在线评测系统
+ 版本号：1.0.0
+ 开发语言: Ruby (Ruby on Rails框架)
+ 开发人员：龚征(指导老师)   谢非　麦灿标　文乐炫　张啟迪　张秋媛
+ 运行平台: CentOS 6.5 , Nginx 10.0

#### 2. 系统特色
 + 界面多主题
 + 支持代码高亮
 + 支持超过8门编程语言
 + 支持中英文界面
 + 支持vim sublime emac三种编辑模式
 + 支持多种编辑主题

#### 3. 编译器版本
+ gcc     4.4.5
+ g++     4.4.5
+ java    1.6.2
+ pascal  2.4.0
+ ruby    2.0
+ lua     5.1.4
+ perl    5.10
+ python2 2.7.3
+ python3 3.3.0
+ go      1.0
+ ghc     7.6.2

#### 4. 编译参数
+ gcc : gcc main.c -o main -Wall -lm -O2 -std=c99 --static -DONLINE_JUDGE
+ g++ : g++ main.cpp -O2 -Wall -lm --static -DONLINE_JUDGE -o main
+ java : javac Main.java
+ ruby : reek main.rb
+ perl : perl -c main.pl
+ pascal : fpc main.pas -O2 -Co -Ct -Ci
+ go : go build -ldflags "-s -w" main.go
+ lua : luac -o main main.lua
+ python2 : python2 -m py_compile main.py
+ python3 : python3 -m py_compile main.py
+ haskell : ghc -o main main.hs

#### 5. 平台说明
+ 时间及内存限制说明
        按照语言的性能分为两种: 
        静态语言: C、C++、go、haskell、lua、pascal
        动态语言: java、python2、python3、ruby、perl
        其中动态语言的时间和内存限制皆为静态语言的两倍

+ 返回结果说明
  + AC 接受
  + WA 错误的答案
  + PE 格式错误
  + RE 运行时错误
  + CE 无法编译
  + TE 超过时间限制
  + ME 超过内存限制
  + OE 超过输出限制

#### 6. 支持我们
+ 如果您想成为我们的管理员, 欢迎加入QQ群2646131
+ 如果您对平台有任何意见, 请发邮件至790174750@qq.com
+ 如果您想发表题目或举办比赛, 请发邮件至790174750@qq.com
+ 给我们的github项目打个星

#### 7. 样例输出

下面列出一个解决1000问题（输入a和b，输出a+b）的例子：

+ C

``` c

#include<stdio.h>
int main()
{
	int a,b;
	scanf("%d %d",&a,&b);
	printf("%d\n",&a+b);
	return 0;
}
```

+ C++

``` c++

#include<iostream>
int main()
{
	int a,b;
	cin<<a<<b;
	cout>>a+b>>endl;
	return 0;
}
```

+ PASCAL

``` pascal

var
    a,b:integer;
begin
    readln(a,b);
    writeln(a+b);
end.
```

+ Java

``` java

import java.io.*;
import java.util.*;
public class Main
{
    public static void main(String[] args)
    {
       Scanner cin = new Scanner ( System.in );
       int a,b;
       a=cin.nextInt();
       b=cin.nextInt();
       System.out.println(a+b);
    }
}
```

+ Lua

``` lua

a,b = io.read("*number", "*number")
print(a+b)
```

+ Perl

``` perl

my ($a,$b) = split(/\D+/,);
print "$a $b " . ($a + $b) . "\n";
```

+ Ruby

``` ruby

puts gets.split.map(&:to_i).inject(&:+)
```

+ Python2

``` python

print sum(int(x) for x in raw_input().split())
```

+ Python3

``` python

print(sum(int(x) for x in input().split()))
```

+ Haskell

``` haskell

main = getLine >>= print . sum . map read . words
```

+ Go

```go

package main
import "fmt"      
func main(){      
    var a,b int      
    fmt.Scanf("%d %d", &a,&b)      
    fmt.Printf("%d", a+b)      
}
```