$.ajaxSetup( {
      beforeSend: function ( xhr ) {
        xhr.setRequestHeader( 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      }
    });

$(function() {
  $("button.favorite-show").click(function(e) {
    e.preventDefault();
    var $this = $(this);
    console.log("poop");

    var $that = $this;
    if ($this.data('action') === 'favorite') {
      $.ajax("/favorites", {
        method: "POST",
        data: {show_id: $this.data('id')},
        success: function() {
          $that.removeClass("btn-success").addClass("btn-danger")
          .text("Unfavorite").data("action", "unfavorite");
        },
        error: function() { alert("Something bad happened"); }
      });

    } else {
      $.ajax("/favorites/" + $this.data('id'), {
        method: "DELETE",
        data: {show_id: $this.data('id')},
        success: function() {
          $that.removeClass("btn-danger").addClass("btn-success")
          .text("Favorite").data("action", "favorite");
        },
        error: function() { alert("Something bad happened"); }
      });
    }
  });
});