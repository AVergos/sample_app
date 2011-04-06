jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(function() {
  $("#usersindex .pagination a").live("click", function(){
    $.getScript(this.href);
    return false;
  });

  $("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script")
    return false;
  });
  
  $("#follow_form").submit(function() {
    $.post($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });
});
