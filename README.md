# 名工大Map (Nitech Map)

## 概要
名古屋工業大学の学生をターゲットとする構内地図スマホアプリ

現在が何コマ目かに応じて、対応する時間割情報を表示し、講義室の場所を赤く強調して示します。

講義ごとにメモを保存できます。持ち物や課題内容、テストの日時など、自由にメモすることができます。

連続するコマで同じ講義名を入力すると、時間割一覧画面では連結して表示されます。

<a href="https://play.google.com/store/apps/details?id=com.c0de.nitechmap_c0de">Google Play Store</a>で公開

## ユーザー数
74人 (2022/4/25)

## リリース
<table>
  <th>日付</th>
  <th>更新内容</th>
  <tr>
    <td>2022/1/19</td>
    <td>最初のリリース(Google Play Store)　地図画面と時間割一覧</td>
  </tr>
  <tr>
    <td>2022/4/5</td>
    <td>UIを変更,切り替えアニメーション追加,時間割の時刻表をドロワーに追加</td>
  </tr>
  <tr>
    <td>2022/4/25</td>
    <td>メモ機能を追加, 連続授業を連結して表示</td>
  </tr>
</table>
 

## 使用言語・フレームワーク・パッケージ
- Flutter
- Dart
- Provider
- photo_view
- sqflite

<table>
  <tr>
    <th>地図画面</th>
    <th>時間割画面</th>
    <th>時間割編集</th>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/74134260/164989017-7ddc7d28-c498-45e9-ad71-0dd301baecd7.png" width="200"></td>
    <td><img src="https://user-images.githubusercontent.com/74134260/164989097-7e00edaa-3190-487c-b1ad-100223cffdc4.png" width="200"></td>
    <td><img src="https://user-images.githubusercontent.com/74134260/161440734-e4e0f261-cd97-47fc-b136-d6550a1287bd.png" width="200"></td>
  </tr>
  <tr>
    <th>メモ</th>
    <th>メモ追加</th>
    <th>ドロワー</th>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/74134260/164989221-674543f6-c104-4297-98c9-919ede08f290.png" width="200"></td>
    <td><img src="https://user-images.githubusercontent.com/74134260/164990064-6dfd7e7d-d442-41b9-a527-938cc40e9023.png" width="200"></td>
    <td><img src="https://user-images.githubusercontent.com/74134260/161440731-4cd18b64-486b-4ddf-b20d-21c967cc254d.png" width="200"></td>
  </tr>
</table>
