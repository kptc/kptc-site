// Element-specific scripts

$(document).ready(function() {
  
  //sets the variable "url" to the pathname of the current window
  var url = window.location.pathname;
  var activePage = url.substring(url.lastIndexOf('/') + 1);
  $('.nav-item a').each(function () {
    var linkPage = this.href.substring(this.href.lastIndexOf('/') + 1);
    if (activePage == linkPage) {
      $(this).parent().addClass('active');
    } else if (activePage == 'profile') {
      $('.profile-nav').addClass('active');
    }
  });

  $('#calendar').fullCalendar({
    eventSources: [
      {
        url: $("#calendar").data("url"),
        color: '#488530',
        textColor: 'white'
      }
    ],
    timeFormat: 'LT',
    eventRender: function(event, element) {
      element.closest("a").attr({
        "data-method": "patch",
        "data-toggle": "tooltip",
        "data-placement": "top",
        "data-title": "Request Sub"
      });
    },
    eventAfterRender: function(event, element) {
      element.closest("a").tooltip();
    }
  });
  
  $('.best_in_place').best_in_place();
  
  $('.datetimepicker').datetimepicker({
    format: 'Y-m-d h:i a'
  });  
  
  $('.datepicker').datetimepicker({
    format: 'Y-m-d',
    timepicker: false
  });  
  
  $('.timepicker').datetimepicker({
    format: 'h:i a',
    datepicker: false,
  });  
  
  function icheck(){
    if($(".icheck").length > 0){
      $(".icheck").each(function(){
        var $el = $(this);
        var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
        color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
        var opt = {
          checkboxClass: 'icheckbox' + skin + color,
          radioClass: 'iradio' + skin + color,
        }
        $el.iCheck(opt);
      });
    }
  }
  $(function(){
    icheck();
  });
  
});