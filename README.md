# 基本的なセキュリティトピックに気をつけて設計できるようになる

**【注意】このrailsアプリケーションは本番環境で実行しないでください**

## クロスサイトスクリプティング再現方法
- Blogのtitleに`<script>alert('alert!')</script>`を設定するとアラートが表示される

## SQLインジェクション再現方法
- Commentを登録し、`http://localhost:3000/blogs/null)%20UNION%20select%20id,%20body%20,%20null,%20null%20from%20comments%20where%20status=1%20--%20`にアクセスするとBlogのtitleにコメントの内容が表示される
- **MySQLのみ再現可能（PostgreSQLでは再現出来ない）**

## SQLインジェクションの解説
- 下記のSQLが発行される
```sql
SELECT  `blogs`.* FROM `blogs` WHERE (id = null) UNION select id, body , null, null from comments where status=1 -- ) ORDER BY `blogs`.`id` ASC LIMIT 1
```
- UNIONでcommentsのtableを縦に繋げることによりコメント内容をBlogのtitleとして表示している
- SQLの`--`はコメント表示のため、` ) ORDER BY〜`移行のSQLは無効となる

## Ruby version
2.5.1
