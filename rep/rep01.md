# 2020年度プログラム言語論 1日目(01/12)レポート

201811528 春名航亨(知識情報・図書館学類3年次)

## 1日目前半: 関数プログラミングの紹介

>関数型プログラム言語は、C言語などにおける「文」に相当するものがなくて、「式」しかない世界だということもできる。つまり、手続き型プログラム言語より、関数型プログラム言語の方が「世界が狹い」ようにも見えてしまい、すでに、手続き型プログラム言語を1つ以上知っている皆さんにとっては、「なぜ、関数型プログラム言語を今さら学ぶのか」という疑問がわいてきただろう。なぜ、そのような言語が成立するのだろうか(そのような言語の方が「良い」ことが1つでもあるのだろうか)？これについて、自分の考えを5行程度以上、書きなさい。

関数型プログラミングでは, (少なくとも純粋な関数については)実行結果が同じ入力に対して常に同じ結果を得られるような関数を定義することで, よきせぬ結果となるバグの少ないプログラミングを行うことが出来る. またそのパラダイムを持つ関数型言語ではそのようなプログラミングを強制して行うように矯正してくれるため, 手続き型より堅牢なプログラミングを行うことが出来ると言える. また再帰関数の定義や, 関数を引数に取る高階関数などを用いて, 柔軟で抽象的なプログラムを書くことが出来る. パターンマッチによるリスト操作も, 少ない記述量でたくさんのデータの分岐が行えるのも手続き型にはない特徴であると思う.

## 1日目後半: ラムダ計算

### 1

```math
\begin{aligned}
(D~L) (L~3)
&\rightarrow \left\{ \lambda x. L\left(L~x\right)\right\}(L~3) \\
&\rightarrow \left\{ \lambda x. L\left(x + 1\right)\right\}(L~3) \\
&\rightarrow \left\{ \lambda x. \left(x+1\right)+1\right\}(L~3) \\
&\rightarrow \left\{ \lambda x. \left(x+1\right)+1\right\}(3+1) \\
&\rightarrow 3+1+1+1
\end{aligned}
```

### 2

```math
\begin{aligned}
\left\{D \left(D~L\right)\right\} 3 &\rightarrow \left\{\lambda x. D~L\left(D~L x\right)\right\} 3 \\
&\rightarrow D~L \left(D~L~3\right) \\
&\rightarrow D~L\left\{L \left(L~3\right)\right\} \\
&\rightarrow^\ast D~L\left\{\left(3+1\right)+1\right\} \\
&\rightarrow L~L\left\{(3+1)+1\right\} \\
&\rightarrow^\ast 3+1+1+1+1
\end{aligned}
```

### 3

```math
\begin{aligned}
(C~L)(D~L) &\rightarrow^\ast \{(\lambda g.\lambda xL(g~x)\}(\lambda x.L~L~x) \\
&\rightarrow^\ast \{\lambda g. \lambda x. L(g~x)\}(\lambda x.x+1+1) \\
&\rightarrow^\ast \lambda x.L(x+1+1+1) \\
&\rightarrow \lambda x.x+1+1+1+1
\end{aligned}
```

### 発展的な課題

>ラムダ計算では(構文上は)、どのようなラムダ式をどのようなラムダ式に関数適用してもよいので、たとえば$(D~3) 5$のように「おかしな計算」も表現できてしまう。このラムダ式がどのような意味で「おかしい」か説明しなさい。また、そのような「おかしい」計算を表現するラムダ式はどうやったら排除できるか考えなさい。

```math
(D~3) 5
```

は, 簡約すると

```math
\lambda x . 5(5~x)
```

となり, 関数でなく数値が関数が期待される位置に入ってしまう. これは, `D`の引数`x`に関数と数値の両方が許容されているからである. これを避けるには, 「`D`の引数`x`は数値でなければならない」という制約をつける必要がある.

## 1日目後半: 型付きラムダ計算

### 1

```math
\frac{\Gamma \vdash y: Int \rightarrow Int}{\Gamma \vdash M_1: T_1}
```

### 2

```math
\frac{\Gamma \vdash x: Int}{\Gamma \vdash M_2 : T_2}
```

### 3

```math
\frac{\Gamma \vdash y: Int \rightarrow Int}{\Gamma \vdash M_3 : T_3}
```

### 4

```math
\frac{\dfrac{\dfrac{}{\Gamma \vdash y: Int \rightarrow Int}~\dfrac{}{\Gamma \vdash x: Int}}{\Gamma \vdash y~x: Int}}{\Gamma \vdash M_4: T_4}
```

### 5

```math
\frac{\dfrac{\dfrac{}{\Gamma \vdash y: Int \rightarrow Int}~\dfrac{\dfrac{}{\Gamma \vdash y: Int \rightarrow Int}~\dfrac{}{\Gamma \vdash x: Int}}{\Gamma \vdash y~x: Int}}{\Gamma \vdash y(y~x): Int}}{\Gamma \vdash M_5 : T_5}
```

### 6

```math
\frac{z: Int
 \vdash z: Int}{\Gamma \vdash M_6: T_6}
```

### 7

```math
\frac{\dfrac{\dfrac{}{z: Int \rightarrow Int \vdash z: Int \rightarrow Int}~\dfrac{}{\Gamma \vdash x: Int}}{z: Int \rightarrow Int, \Gamma \vdash z~x: Int}}{\Gamma \vdash \lambda z . z~x: (Int\rightarrow Int)\rightarrow Int}
```
