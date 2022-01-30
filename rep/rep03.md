# 2020年度プログラム言語論 3日目(02/02)レポート

201811528 春名航亨(知識情報・図書館学類3年次)

## 3日目: `fold_right`の型がなにか考え理由とともに答えなさい．

2変数関数に対して与えたリストの先頭から順に取り出して適用し(最初はリストの初期値と先頭を与える), その結果を次の適用の第2引数(左側)にとりリストが空になるまでその操作を再帰的に繰り返す関数`fold_left`の型は

$$\forall \alpha.\forall\beta((\alpha\rightarrow\beta\rightarrow\alpha)\rightarrow\alpha\rightarrow\beta~list\rightarrow\alpha)$$

となるが, 引数を3つ「2引数関数, 初期値, リスト」の順にとる.
それぞれの型は,

- 2引数関数: $\alpha\rightarrow\beta\rightarrow\alpha$型
- 初期値: $\alpha$型
- リスト: $\beta~list$型

に対応しており, 返り値は$\alpha$型を持つ.

このことは, 2引数関数が順に「初期値$\alpha$型か2引数関数の返り値, リストの先頭の値$\beta$型」を取り, またリストが空になった時, 最後の2引数関数の適用結果($\alpha$)型がそのまま返されるということより推論出来る.

同様に, 2変数関数に対して与えたリストの先頭から順に取り出して適用し(最初はリストの先頭と初期値を与える), その結果を次の適用の第2引数(右側)にとりリストが空になるまでその操作を再帰的に繰り返す関数`fold_right`の型を考える.

`fold_right`は, 引数を3つ「2引数関数, リスト, 初期値」の順にとる.

引数に型を割り振りたい. まず, 出現順から見て, リストに$\alpha~list$型と初期値に$\beta$型を与える. また, 2引数関数は順に「リストの先頭の値$\alpha$型, 初期値$\beta$型か2引数関数の返り値」を引数にとる. よって返り値は$\beta$でないといけないため, $\alpha\rightarrow\beta\rightarrow\beta$型を与える.

また`fold_right`の返り値は, リストが空になった時, 最後の2引数関数の適用結果がそのまま返されるので$\beta$型である.

よって`fold_right`の型は,

$$\forall \alpha.\forall\beta((\alpha\rightarrow\beta\rightarrow\beta)\rightarrow\alpha~list\rightarrow\beta\rightarrow\beta)$$

と推論出来る.

## 3日目: 静的型付けのプログラム言語を1つ取りあげ，その言語が多相型をもつかどうか，また，もつ場合はどのような多相型をもつか，もたない場合は，多相型があるとどのような利点があると予想されるか．

自分の知っている静的型付けを行う言語の中で, 唯一まともに書けるのがC言語なので, 今回はC言語について考察する.

C言語では, 「任意の型」を表せる多相型がそもそも無いため, 関数の引数や返り値などには特定の型をつけなければならない.

このため生じる問題としては, 「別々の型をもつデータに対しても同一の機能を持つ関数を, わざわざ引数の型ごとに関数宣言から何度も定義する必要がある」ことが挙げられる.

例として, 1引数関数`func`, 配列`arr`, 配列長`arr_len`を引数に取り, `arr`の各要素を, `func`を適用した結果に置き換え, 破壊的な変更を行う`map`関数を考える.

この時, arrの型が`*int`でも, `*double`でも, `*char`でも動くようにしたい.

もしC言語に多相型があれば,

```c
// Tは多相型
void map(T (*func)(T), T *arr, size_t arr_len) {
    for(int i = 0; i < arr_len; i++) {
        arr[i] = func(arr[i]);
    }
}
```

と書けるが, 実際には

```c
void map_int(int (*func)(int), int *arr, size_t arr_len) {
    for(int i = 0; i < arr_len; i++) {
        arr[i] = func(arr[i]);
    }
}
void map_double(double (*func)(double), double *arr, size_t arr_len) {
    for(int i = 0; i < arr_len; i++) {
        arr[i] = func(arr[i]);
    }
}
void map_char(char (*func)(char), char *arr, size_t arr_len) {
    for(int i = 0; i < arr_len; i++) {
        arr[i] = func(arr[i]);
    }
}
```

のように書く必要があるため, コードの記述量は増えるし, 煩雑である.

このことから, 多相型があるとコードがより簡潔に書けるという利点が生まれると言える.
