$('.popover_element').popover();
$('.popover_element').on('click', function () {
  $('.popover_element').not(this).popover('hide');
});
