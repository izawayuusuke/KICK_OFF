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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

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
