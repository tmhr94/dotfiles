# 図のレシピ

生成するのは単体HTMLなので、**mermaid は自分で読み込む**。

```html
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true, securityLevel: 'loose' });
</script>
```

複雑な位置関係や before/after の並置は、mermaid より素の HTML/CSS/SVG のほうが読みやすいことが多い。

## 使い分け

| 伝えたいこと | 図の型 |
|---|---|
| 誰が誰を呼ぶか / 依存の向き | `flowchart LR` |
| クラスの構造・継承・保持 | `classDiagram` |
| 時系列の処理の道筋 | `sequenceDiagram` |
| 状態が遷移する（ステータス列挙の追加など） | `stateDiagram-v2` |
| テーブル間の関連・schema変更 | `erDiagram` |
| 変更前後の対比 | flowchart を 2 つ並置、または HTML で左右に並べる |
| 数値の増減・件数比較・配分 | 素の HTML/CSS のバー |

## テーマ両対応（mermaid の落とし穴）

ページはライト/ダーク両テーマで見られるが、mermaid の init は**静的に1つ**しか書けない。
既定のままだとダークテーマで「黒文字 on 黒地」になり読めなくなる。対策は2つ。

1. **ノードには必ず explicit な fill と color を置く**（classDef）。ノード内の文字は地の色に依存しなくなる。
2. **ノード外の文字と線は、白地・黒地の両方で読める中間色**にする。`themeVariables` で固定する。

```
%%{init:{'theme':'base','themeVariables':{'lineColor':'#8b9895','textColor':'#6f7d79','fontFamily':'ui-sans-serif, system-ui, sans-serif','fontSize':'13px'}}}%%
```

sequenceDiagram は participant 箱や note も地の色を持つので、追加で固定する。

```
'actorBkg':'#dcf2ed','actorBorder':'#0e8f7d','actorTextColor':'#0a4d43',
'signalColor':'#8b9895','signalTextColor':'#6f7d79',
'noteBkgColor':'#fbeedd','noteBorderColor':'#b45309','noteTextColor':'#7a3806',
'altSectionBkgColor':'#f4f6f5','labelBoxBkgColor':'#eef1f0','labelTextColor':'#2c3634'
```

## 変更箇所の強調（必須）

新規・変更・既存を色で区別し、凡例を置く。

```
flowchart LR
    A[OrdersController<br/>既存] --> B[DiscountCalculator<br/>新規]
    B --> C[(orders<br/>カラム追加)]

    classDef added fill:#dcf2ed,stroke:#0e8f7d,stroke-width:2px,color:#0a4d43
    classDef changed fill:#fbeedd,stroke:#b45309,stroke-width:2px,color:#7a3806
    classDef existing fill:#eef1f0,stroke:#9aa6a2,color:#2c3634
    class B added
    class C changed
    class A existing
```

凡例は mermaid の外に HTML で置くほうが崩れない。

```html
<ul class="legend">
  <li><span class="swatch added"></span>新規追加</li>
  <li><span class="swatch changed"></span>変更あり</li>
  <li><span class="swatch existing"></span>既存（変更なし）</li>
</ul>
```

## 型ごとの書き方

### 関係図（flowchart）

レイヤの順に左→右。永続化は `[(...)]`、外部サービスは `{{...}}`、非同期は点線 `-.->`。

```
flowchart LR
    subgraph 入口
        R[ルーティング] --> C[OrdersController#create]
    end
    subgraph ロジック
        C --> F[OrderForm]
        F --> S[CreateOrderService]
    end
    S --> M[(orders)]
    S -.enqueue.-> W[OrderNotifyWorker]
    W --> X{{外部API}}
```

### 処理フロー（sequenceDiagram）

登場人物は実クラス名。分岐は `alt`、非同期は `-->>`。`Note over` で補足を入れる。

```
sequenceDiagram
    autonumber
    actor U as 利用者
    participant C as OrdersController
    participant S as CreateOrderService
    participant DB as データベース
    U->>C: POST /orders
    C->>S: call(params)
    alt バリデーション成功
        S->>DB: INSERT
        S-->>C: Success
    else 失敗
        S-->>C: Failure(errors)
    end
```

### 変更前 → 変更後

同じ操作が前後でどう変わるかを**並べて**見せる。差分がある部分だけ色を変える。

```
flowchart TB
    subgraph BEFORE["変更前"]
        direction LR
        A1[スコア計算] --> A2[並び替え]
    end
    subgraph AFTER["変更後"]
        direction LR
        B1[スコア計算] --> B2[初期保証分の加算] --> B3[並び替え]
    end
```

### schema変更（erDiagram）

追加カラムはコメントで示す。**ER図は横に広がりやすい**ので、親の `overflow-x: auto` と
`svg { max-width: none }` を必ず確認する（`page-structure.md` の見切れ対策）。

```
erDiagram
    orders ||--o{ order_items : has
    orders {
        bigint id PK
        int discount_point "★今回追加"
    }
```

## 図より表・メーターが効く場合

配分・上限・比率のように「数の関係」が主題なら、mermaid より **HTML/CSS の横棒メーター**のほうが伝わる。
トラックの**幅そのものを上限**にすると、比率が図の構造として現れる（凡例＋数値ラベルを必ず添える）。
チャートを作る前に `dataviz` skill を読む。色は同 skill の `scripts/validate_palette.js` で検証できる。

## やってはいけないこと

- コードに存在しない矢印を描く（想像で線をつながない）
- 1枚に10ノード以上詰め込む。分割するか抽象度を上げる
- ノード名を日本語の説明文にする。**クラス名・メソッド名を残し、説明は改行して添える**（読者が grep できることが重要）
- 色だけで情報を伝える。形・ラベル・凡例を併用する
- 図を置いて終わりにする。**図の直後に「この図で言いたいこと」を1〜2文**書く
- スクロールする箱の中で図を中央寄せする（左側が掴めなくなる）
