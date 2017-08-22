$( document ).ready(function() {

  $(function() {
    $("#search-form").on("ajax:before", function() {
      $(".spinner, #search-button").toggle();
    });
  });

});
