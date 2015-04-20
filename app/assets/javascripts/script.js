// Element-specific scripts

$(document).ready(function() {
  
  $('#calendar').fullCalendar({
    events: 
    [
      {
        title  : "Game",
        start  : "2015-04-01 19:00:00",
        end    : "2015-04-01 20:00:00",
        allDay : 0
      },
      {
        title  : "Game",
        start  : "2015-04-08 19:00:00",
        end    : "2015-04-08 20:00:00",
        allDay : 0
      },
    ]
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