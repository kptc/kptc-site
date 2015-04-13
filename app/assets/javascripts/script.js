// Element-specific scripts

$(document).ready(function() {
  
  $('.best_in_place').best_in_place();
  
  $('.datepicker').datetimepicker({
    format: 'Y-m-d',
    timepicker: false
  });  
  
  $('.timepicker').datetimepicker({
    format: 'h:i a',
    datepicker: false,
  });  
  
});