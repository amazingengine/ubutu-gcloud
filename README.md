# つかいかた

## DockerでContainerまで立ち上げる
カレントディレクトリをここのフォルダにしてください。

`.env.example`を`.env`にリネームしてください。

`.env`の説明は以下のとおりです。変更したい部分があれば好きにしてください。

```
container_name_gcloud=gcloud_ctr #今回作成するdockerのcontainerの名前
image_name_gcloud=gcloud:201809 #今回作成するdockerのimageの名前
container_mount_volume=/point/share/ #[share]と共有するcontainer内のディレクトリ名称
```

`docker-compose up -d`と打ってください。

はじめての起動の場合は色々なログが出てきますが、これは`docker`の`image`と`container`を作成しています。

ターミナル操作ができるようになったら（コマンドプロンプトが戻ってきたら）

`docker exec -it gcloud_ctr /bin/bash`でbashに入ってください。

そしたら、`gcloudの初期化`を実施してください。

## gcloudの初期化

このあたりは`gcloud init`で検索をかけるとわかりやすいかもしれません。

`gcloud init`コマンドを入力します。

`You must log in to continue. Would you like to log in (Y/n)?`　は　`Y`　を押下してください。

以下のような文言が現れます。
```
Go to the following link in your browser:

https://accounts.google.com/o/oauth2/auth?redirect_uri=*******************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************

Enter verification code:
```

上記の様なURLが出てくるのでWebブラウザに貼り付けてください。

Googleアカウントを聞かれるので、`GCPのアカウント`を選択してください。

コードが出るので、それをターミナルの`Enter verification code:`に貼り付けてください。

`You are logged in as: [GMAILのアドレス].`が表示されたら成功です。

次に以下のような文言が現れます。

```
Pick cloud project to use:
 [1] project1
 [2] project2
Please enter numeric choice or text value (must exactly match list
item):
```

好きなプロジェクトを選んでください。（project2を使う場合は`2`を入力します。)

次に以下のような文言が出ます。

```
Do you want to configure a default Compute Region and Zone? (Y/n)?
```

`n`を押します。

これで`gcloud`の初期化が完了しました。

## kubectlと既存のGKEクラスタへの入り方

GoogleCloudPlatformのポータルサイトにアクセスし、画面上部の検索フォームで`kubernetes クラスタ`をクリックしてください。

ページに飛んだら、クラスタの一覧がありますので、右部の`接続`ボタンを押下してください。

下記のようなコマンドが表示されているので、それをターミナルでコピーペーしてください。

`gcloud container clusters get-credentials [クラスタ名] --zone [設定されたゾーン] --project [プロジェクトID]`

なお、上部に書いてある`gcloud init`でアカウント認証をしていないとエラーが出ます。


kubectlを使うと下記Warningが出ますが、後ほど対応します。

```
WARNING: Starting in 1.12, new clusters will have basic authentication disabled by default. Basic authentication can be enabled (or disabled) manually using the `--[no-]enable-basic-auth` flag.
WARNING: Starting in 1.12, new clusters will not have a client certificate issued. You can manually enable (or disable) the issuance of the client certificate using the `--[no-]issue-client-certificate` flag.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
This will enable the autorepair feature for nodes. Please see
https://cloud.google.com/kubernetes-engine/docs/node-auto-repair for more
information on node autorepairs.

WARNING: Starting in Kubernetes v1.10, new clusters will no longer get compute-rw and storage-ro scopes added to what is specified in --scopes (though the latter will remain included in the default --scopes). To use these scopes, add them explicitly to --scopes. To use the new behavior, set container/new_scopes_behavior property (gcloud config set container/new_scopes_behavior true).
```
