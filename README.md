# モデル構造

## Userモデル
| カラム名 | データ型 |
| ------- | ------ | 
| name | string |
| email | string |
| password_digest | string |

## Taskモデル
| カラム名 | データ型 |
| ------- | ------ | 
|  name   |  string |
| content | text |


## Labelモデル
| カラム名 | データ型 |
| ------- | ------ | 
| name | string |

<br>

# Herokuへのデプロイ方法
1.作成したアプリケーションをコミットする
```
$ git add -A
$ git commit -m"コメント"
```

2.Heroku buildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

　　
3．作成したアプリケーションをHerokuへ作成する　　
```
$ heroku create
```

4.Herokuへデプロイする
*masterブランチの場合
```
$ git push heroku master
```

*master以外のブランチの場合
```
git push heroku ブランチ名:master
```

5.Herokuへのデータベースの移行
```
heroku run rails db:migrate
```



