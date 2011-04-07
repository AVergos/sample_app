$(function() {
  $("#usersindex .pagination a").live("click", function(){
    $.getScript(this.href);
    return false;
  });

  $("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script")
    return false;
  });
  
  $("#microposts_search input").keyup(function() {
    $.get($("#microposts_search").attr("action"), $("#microposts_search").serialize(), null, "script")
    return false;
  });
  
  $("#feed_search input").keyup(function() {
    $.get($("#feed_search").attr("action"), $("#feed_search").serialize(), null, "script")
    return false;
  });
});
