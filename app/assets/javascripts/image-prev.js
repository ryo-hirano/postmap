$(document).on('turbolinks:load', function(){
  $(function(){
    //プレビューのhtmlを定義
    function buildHTML(count) {
      var html = `<div class="preview-box" id="preview-box__${count}">
                    <div class="upper-box">
                      <img src="" alt="preview">
                    </div>
                    <div class="lower-box">
                      <div class="delete-box" id="delete_btn_${count}">
                        <span>削除</span>
                      </div>
                    </div>
                  </div>`
      return html;
    }

    // 投稿編集時
    //products/:i/editページへリンクした際のアクション=======================================
    if (window.location.href.match(/\/products\/\d+\/edit/)){
      //登録済み画像のプレビュー表示欄の要素を取得する
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
      //プレビューにidを追加
      $('.preview-box').each(function(index, box){
        $(box).attr('id', `preview-box__${index}`);
      })
      //削除ボタンにidを追加
      $('.delete-box').each(function(index, box){
        $(box).attr('id', `delete_btn_${index}`);
      })
      var count = $('.preview-box').length;
      //プレビューが4あるときは、投稿ボックスを消しておく
      if (count == 4) {
        $('.label-content').hide();
      }
    }
    // ラベルのwidth操作
    function setLabel() {
      //プレビューボックスのwidthを取得し、maxから引くことでラベルのwidthを決定
      var prevContent = $('.label-content').prev();
      labelWidth = (620 - $(prevContent).css('width').replace(/[^0-9]/g, ''));
      $('.label-content').css('width', labelWidth);
    }

    // プレビューの追加
    $(document).on('change', '.hidden-field', function() {
      setLabel();
      //hidden-fieldのidの数値のみ取得
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //labelボックスのidとforを更新
      $('.label-box').attr({id: `label-box--${id}`,for: `post_images_attributes_${id}_src`});
      //選択したfileのオブジェクトを取得
      var file = this.files[0];
      var reader = new FileReader();
      //readAsDataURLで指定したFileオブジェクトを読み込む
      reader.readAsDataURL(file);
      //読み込み時に発火するイベント
      reader.onload = function() {
        var src = this.result;
        //プレビューが元々なかった場合はhtmlを追加
        if ($(`#preview-box__${id}`).length == 0) {
          var count = $('.preview-box').length;
          var html = buildHTML(id);
          //ラベルの直前のプレビュー群にプレビューを追加
          var prevContent = $('.label-content').prev();
          $(prevContent).append(html);
        }
        //イメージを追加
        $(`#preview-box__${id} img`).attr('src', `${src}`);
        var count = $('.preview-box').length;
        //プレビューが4個あったらラベルを隠す 
        if (count == 4) { 
          $('.label-content').hide();
        }

        //プレビュー削除したフィールドにdestroy用のチェックボックスがあった場合、チェックを外す=============
        if ($(`#post_images_attributes_${id}__destroy`)){
          $(`#post_images_attributes_${id}__destroy`).prop('checked',false);
        } 
        //ラベルのwidth操作
        setLabel();

        //チェックボックスの有無を確認し、チェックが入っているチェックボックスのvalueを取得する
        var check = [];
        var checkbox = document.getElementsByClassName("hidden-checkbox");

        //チェックボックスの数だけループを回す
        for (let i = 0; i < checkbox.length; i++){
          if(checkbox[i].checked){
            check.push(checkbox[i].value);
          }
        }

        //チェックが入っているチェックボックスの内、先頭の値を取得
        var value = check[0];

        // //ラベルのidとforの値を変更
        if (value != null){
          //チェックボックスにチェックが入っている場合、ラベルのオプションをチェックボックスのvalueの値に更新する
          $('.label-box').attr({id: `label-box--${value}`,for: `post_images_attributes_${value}_src`});
        } else if(count < 4){
          //プレビューの数でラベルのオプションを更新する
          $('.label-box').attr({id: `label-box--${count}`,for: `post_images_attributes_${count}_src`});
        }
      }
    });

    // 画像の削除
    $(document).on('click', '.delete-box', function() {
      var count = $('.preview-box').length;
      setLabel(count);
      //product_images_attributes_${id}_src から${id}に入った数字のみを抽出
      var id = $(this).attr('id').replace(/[^0-9]/g, '');
      //取得したidに該当するプレビューを削除
      $(`#preview-box__${id}`).remove();

      //新規登録時と編集時の場合分け==========================================================

      //新規投稿時
      //削除用チェックボックスの有無で判定
      if ($(`#post_images_attributes_${id}__destroy`).length == 0) {
        //フォームの中身を削除 
        $(`#post_images_attributes_${id}_src`).val("");
        var count = $('.preview-box').length;
        //4個めが消されたらラベルを表示
        if (count == 3) {
          $('.label-content').show();
        }
        setLabel(count);
        if(id < 4){
          $('.label-box').attr({id: `label-box--${id}`,for: `post_images_attributes_${id}_src`});
        }
      } else {

        //投稿編集時
        $(`#post_images_attributes_${id}__destroy`).prop('checked',true);
        //4個めが消されたらラベルを表示
        if (count == 3) {
          $('.label-content').show();
        }

        //ラベルのwidth操作
        setLabel();
        //ラベルのidとforの値を変更
        //削除したプレビューのidによって、ラベルのidを変更する
        if(id < 4){
          $('.label-box').attr({id: `label-box--${count}`,for: `post_images_attributes_${count}_src`});
        }
      }
      //フォームの中身を削除 
      $(`#post_images_attributes_${id}_src`).val("");

      //削除時のラベル操作
      var count = $('.preview-box').length;
      //4個めが消されたらラベルを表示
      if (count == 3) {
        $('.label-content').show();
      }
      setLabel(count);

      if(id < 4){
        //削除された際に、空っぽになったfile_fieldをもう一度入力可能にする
        $('.label-box').attr({id: `label-box--${id}`,for: `post_images_attributes_${id}_src`});
      }
    });
  });
});