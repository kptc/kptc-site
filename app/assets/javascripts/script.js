// Element-specific scripts

$(document).ready(function() {
  
  $('#calendar').fullCalendar({
    eventSources: [
      {
        url: $("#calendar").data("url"),
        color: '#337ab7',
        textColor: 'white'
      }
    ],
    timeFormat: 'LT'
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