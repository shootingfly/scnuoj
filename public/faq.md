# Frequently Asked Questions
### 关于SCNUOJ
SCNUOJ是华南师范大学在线ACM测评系统。

### 怎样正确输入和输出？
> 提交的程序应该从stdin(“Standard Input”，标准输入)读取输入，
写入输出到stdout(“Standard Output”，标准输出)。
例如，在C语言中使用"scanf"或者C++语言中使用"cin"从stdin中读取输入，
在C语言中使用"printf"或者C++语言中使用"cout"从stdout中写入输出。

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

``` go

package main
import "fmt"      
func main(){      
    var a,b int      
    fmt.Scanf("%d %d", &a,&b)      
    fmt.Printf("%d", a+b)      
}
```
### 三、题目信息表的返回结果是什么意思？

> 
+	AC
接受
+	WA
错误的答案
+	PE
格式错误
+	RE
运行时错误
+	CE
无法编译
+	TE
超过时间限制
+	ME
超过内存限制
+	OE
超过输出限制