// Element-specific scripts

$(document).ready(function() {
  
  $('.datepicker').datetimepicker({
    format: 'Y-m-d',
    timepicker: false
  });  
  
  $('.timepicker').datetimepicker({
    format: 'h:i a',
    datepicker: false,
  });  
  
});

