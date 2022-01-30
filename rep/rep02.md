# 2020年度プログラム言語論 2日目(01/19)レポート

201811528 春名航亨(知識情報‧図書館学類3年次)

## 1日目前半: 「SとK」, 「BとCとI」, 「BとCとK」の組み合わせは特に有名な体系(コンビネータ論理)になるが, 文献をあたってそれを調査せよ

- SK
  - SK logic[^1]
  - Iを導入してSKI logicとも.I=SKKよりSKのみでも表せる
  - これを用いて行う計算モデルはSKIコンビネータ計算という[^2]
- BCI
  - BCI logic, linear logicとも[^1]
  - I=CKKよりBCK logicでも使用可能[^1]
  - ラムダ項の構成のうちラムダ抽象の規則を「M の中に変数記号 x が自由に現れるならば (λx.M) はラムダ項である」と制限することにより得られる体系.
    - これにより未使用の変数の束縛が禁止される[^3]
- BCK
  - BCK logic, affine logicとも[^1]
  - ラムダ項の構成のうち関数適用の規則を「MとN に共通に現れる自由変数が存在しないならば (MN) はラムダ項である」と制限することにより得られる項書換え系[^3]

[^1]: [combinatory logic in nLab](https://ncatlab.org/nlab/show/combinatory+logic)
[^2]: [SKIコンビネータ計算 - Wikipedia](<https://ja.wikipedia.org/wiki/SKI%E3%82%B3%E3%83%B3%E3%83%93%E3%83%8D%E3%83%BC%E3%82%BF%E8%A8%88%E7%AE%97)
[^3]: [カリー＝ハワード同型対応 - Wikipedia](https://ja.wikipedia.org/wiki/%E3%82%AB%E3%83%AA%E3%83%BC%EF%BC%9D%E3%83%8F%E3%83%AF%E3%83%BC%E3%83%89%E5%90%8C%E5%9E%8B%E5%AF%BE%E5%BF%9C)

## 1日目前半: 以下のラムダ項に対して型推論アルゴリズムを走らせ, 型付けがあるかどうかと, ある場合は主たる型付けを求めなさい

### M1=λf.λx.f(x + 1)

$$
\dfrac{\dfrac{}{f:\tau_2, x:\tau_4\vdash f:\tau_6}\dfrac{\dfrac{}{f:\tau_2, x:\tau_4\vdash x:Int}\dfrac{}{f:\tau_2, x:\tau_4\vdash 1:Int}}{f:\tau_2, x:\tau_4\vdash x+1:\tau_7}}{\dfrac{\dfrac{f:\tau_2, x: \tau_4 \vdash f(x+1): \tau_5}{f:\tau_2, \vdash \lambda x.f(x+1): \tau_3}}{\vdash \lambda f.\lambda x. f(x+1): \tau_1}}
$$

上の証明図より, 等式の集合は:

$$\begin{aligned}
\tau_1&=\tau_2 \rightarrow \tau_3 \\
\tau_3&=\tau_4 \rightarrow \tau_5 \\
\tau_6&=\tau_7 \rightarrow \tau_5 \\
\tau_6&=\tau_2 \\
\tau_4&=I \\
\tau_7&=I
\end{aligned}$$

となり, 単一化を行うと, それぞれの型変数の解は:

$$\begin{aligned}
\tau_1&:= (I\rightarrow I)\rightarrow I \rightarrow I \\
\tau_2&:= I \rightarrow I\\
\tau_3&:= I \rightarrow I\\
\tau_4&:= I\\
\tau_5&:= I\\
\tau_6&:= I \rightarrow I\\
\tau_7&:= I
\end{aligned}$$

となる. よって:

$$
\vdash λf.λx.f(x + 1): (I\rightarrow I)\rightarrow I \rightarrow I
$$

が導けた.

### M2=λf.λx.f(f (x + 1))

$$
\dfrac{\dfrac{}{f:\tau_3, x: \tau_4 \vdash f: \tau_6}\dfrac{\dfrac{}{f:\tau_3, x: \tau_4 \vdash f:\tau_8}\dfrac{\dfrac{}{f:\tau_3, x: \tau_4 \vdash x: Int}\dfrac{}{f:\tau_3, x: \tau_4 \vdash 1:Int}}{f:\tau_3, x: \tau_4 \vdash x+1: \tau_9}}{f:\tau_3, x: \tau_4 \vdash f(x +1): \tau_7}}{\dfrac{\dfrac{f:\tau_2, x: \tau_4 \vdash f(f(x+1)): \tau_5}{f:\tau_2, \vdash \lambda x.f(f(x+1)): \tau_3}}{\vdash \lambda f.\lambda x. f(f(x+1)): \tau_1}}
$$

上の証明図より, 等式の集合は:

$$\begin{aligned}
\tau_1&=\tau_2 \rightarrow \tau_3 \\
\tau_3&=\tau_4 \rightarrow \tau_5 \\
\tau_6&=\tau_7 \rightarrow \tau_5 \\
\tau_3&=\tau_6 \\
\tau_8&=\tau_9 \rightarrow \tau_7 \\
\tau_3&=\tau_8 \\
\tau_4&=I \\
\tau_9&=I
\end{aligned}$$

となり, 単一化を行うと, それぞれの型変数の解は:

$$\begin{aligned}
\tau_1&:= (I\rightarrow I)\rightarrow I \rightarrow I \\
\tau_2&:= I \rightarrow I\\
\tau_3&:= I \rightarrow I \\
\tau_4&:= I\\
\tau_5&:= I\\
\tau_6&:= I \rightarrow I\\
\tau_7&:= I \\
\tau_8&:= I \\
\tau_9&:= I
\end{aligned}$$

となる. よって:

$$
\vdash λf.λx.f(f(x + 1)): (Int \rightarrow Int )\rightarrow Int  \rightarrow Int 
$$

が導けた.

### M3=λf.λx.(f f)(x + 1)

$$
\dfrac{\dfrac{\dfrac{}{f:\tau_2, x: \tau_4 \vdash f: \tau_8}\dfrac{}{f:\tau_2, x: \tau_4 \vdash f: \tau_9}}{f:\tau_2, x: \tau_4 \vdash (f~f): \tau_6}\dfrac{\dfrac{}{f:\tau_2, x: \tau_4 \vdash x: Int}\dfrac{}{f:\tau_2, x: \tau_4 \vdash 1:Int}}{f:\tau_2, x: \tau_4 \vdash x+1: \tau_7}}{\dfrac{\dfrac{f:\tau_2, x: \tau_4 \vdash (f~f)(x+1): \tau_5}{f:\tau_2, \vdash \lambda x.(f~f)(x+1): \tau_3}}{\vdash \lambda f.\lambda x. (f~f)(x+1): \tau_1}}
$$

上の証明図より, 等式の集合は:

$$\begin{aligned}
\tau_1&=\tau_2 \rightarrow \tau_3 \\
\tau_3&=\tau_4 \rightarrow \tau_5 \\
\tau_6&=\tau_7 \rightarrow \tau_5 \\
\tau_8&=\tau_9 \rightarrow \tau_6 \\
\tau_2&=\tau_8 \\
\tau_2&=\tau_9 \\
\tau_4&=I \\
\tau_7&=I
\end{aligned}$$

となる. しかし$\tau_2 = \tau_2\rightarrow \tau_2$となるような解は存在しないので解なし.

## 1日目後半: 静的/動的型付けが有利か不利か、3つ以上の観点で「あなたの意見を」述べなさい

- 小さなプログラムが素早く書きやすいか

例えば, 「あるページから天気を抽出して毎日記録を取る」ようなスクリプトを書く時は, 型などをいちいち記述する必要のない動的型付け言語で書いたほうが素早く終わらせられる. また, コマンドラインから実行する小さな自作コマンドや, シェル上の出力を受け取って加工するような書捨てのスクリプトを書く場合は, 静的型付けより動的型付けのPerlやRubyの方が少ない記述量で素早く直感的に書ける点で有利だと言えよう. またデータ型のサイズの違いに煩わされる静的型付け言語とは違い, 勝手にデータ型のサイズを変えてくれるような機能を持つRubyのような動的型付けの言語の方がより直感的に素早く書けるだろう.

- バグの少ないシステムにしやすいか

静的型付けでは, 関数の引数や返り値に型を定義して, 予期せぬ入力や出力を行ったり, 未定義の動作を行うことによるエラーを実行前のコンパイル時に発見しある程度防ぐことが出来る. また型を見て他人の書いた関数でも動作を把握しやすくなることで, 間違ったプログラムを書きにくくしてくれる. 動的型付けの言語では, 入力や出力のバリデーションを行っても, そこから漏れたものがエラーを引き起こすことが往々にしてある. そのため, 静的型付けの方がバグの少ないプログラムを書きやすいと言えるだろう.

- 実行速度を速くできるか

静的型付けの言語は, 実行前にコンパイルを行うことで, コードの解釈や最適化を行ったオブジェクトコードにしておける. この点で, 実行時逐次解釈を行い, 型付けなどの処理を併せて行う, 動的型付けの言語より高速な実行が見込める.
