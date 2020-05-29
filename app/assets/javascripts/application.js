// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require popper
//= require bootstrap-sprockets
//= require jquery.jscroll.min.js

$(document).on("turbolinks:load", function () {
  $(".jscroll").jscroll({
    // 無限に追加する要素
    contentSelector: ".jscroll",
    // 次のページにいくためのリンクの場所
    nextSelector: "a.next",
  });
});

// プロフィール画像プレビュー
$(document).on("turbolinks:load", function () {
  $("#user_img").change(function (e) {
    // ファイルオブジェクトを取得する
    var file = e.target.files[0];
    var reader = new FileReader();
    // 画像でない場合は処理終了
    if (file.type.indexOf("image") < 0) {
      alert("画像ファイルを指定してください。");
      return false;
    }
    // アップロードした画像を設定する
    reader.onload = (function (file) {
      return function (e) {
        $("#user_img_prev").attr("src", e.target.result);
        $("#user_img_prev").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

// 投稿画像プレビュー
$(document).on("turbolinks:load", function () {
  $("#post_img").change(function (e) {
    // ファイルオブジェクトを取得する
    var file = e.target.files[0];
    var reader = new FileReader();
    // 画像でない場合は処理終了
    if (file.type.indexOf("image") < 0) {
      alert("画像ファイルを指定してください。");
      return false;
    }
    // アップロードした画像を設定する
    reader.onload = (function (file) {
      return function (e) {
        $("#img_prev").attr("src", e.target.result);
        $("#img_prev").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

// プロフィール画像プレビュー
$(document).on("turbolinks:load", function () {
  $("#emblem_img").change(function (e) {
    // ファイルオブジェクトを取得する
    var file = e.target.files[0];
    var reader = new FileReader();
    // 画像でない場合は処理終了
    if (file.type.indexOf("image") < 0) {
      alert("画像ファイルを指定してください。");
      return false;
    }
    // アップロードした画像を設定する
    reader.onload = (function (file) {
      return function (e) {
        $("#emblem_img_prev").attr("src", e.target.result);
        $("#emblem_img_prev").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);
  });
});

// 投稿の文字数をカウント
$(document).on("turbolinks:load", function () {
  $("#input-text").on("keydown", function () {
    let countNum = String($(this).val().length);
    $("#counter").text(countNum);
  });
});

// 文字数に応じてテキストエリアを広げる
$(function () {
  $(document).on("change keyup keydown paste cut", "textarea", function () {
    if ($(this).outerHeight() > this.scrollHeight) {
      $(this).height(1);
    }
    while ($(this).outerHeight() < this.scrollHeight) {
      $(this).height($(this).height() + 1);
    }
  });
});

// メッセージ表示後、画面下まで移動
$(document).on("turbolinks:load", function () {
  var targetOffset = $("#main").offset().top;
  $("html, body").animate({ scrollTop: targetOffset });
});

document.addEventListener("turbolinks:load", function () {
  $(function () {
    // #back-to-topを消す
    $("#back-to-top").hide();

    // スクロールが十分された時に#back-to-topを表示。スクロールされたら非表示
    $(window).scroll(function () {
      // this(window要素)がどれだけスクロールしたかをscrollTop()を使って値を取る
      $("#pos").text($(this).scrollTop());
      if ($(this).scrollTop() > 60) {
        $("#back-to-top").fadeIn();
      } else {
        $("#back-to-top").fadeOut();
      }
    });

    //#back-to-topがクリックされたら上に戻る
    // animateメソッドを使用
    $("#back-to-top a").click(function () {
      $("html, body").animate(
        {
          scrollTop: 0,
        },
        800
      );
      return false;
    });
  });
});
