SVNサーバー

adminユーザーを作成
htpasswd -c svn-auth-file admin

svnサーバーコンテナの起動
docker run -d -p 80:80 --name my-svn-server -v $(pwd)/svn-auth-file:/etc/svn-auth-file svn-server

SVNレポジトリの動作確認
-ブラウザからアクセス
http://localhost/svn/dev
http://localhost/svn/stg

-SVNクライアントからのチェックアウト
svn checkout http://localhost/svn/dev --username admin
svn checkout http://localhost/svn/stg --username admin
