$(function(){
  let path = location.pathname;
  let pattern_customers = "admin/customers/search";
  let pattern_items = "admin/items/search";

  if(path.match(pattern_customers)){
    history.replaceState(null, null, "/admin/customers");
  } else if(path.match(pattern_items)){
    history.replaceState(null, null, "/admin/items");
  }
});
$(function() {
  $(document).on('turbolinks:load', () => {
  let path = location.pathname;
  let pattern_customers = "admin/customers/search";
  let pattern_items = "admin/items/search";

  if(path.match(pattern_customers)){
    history.replaceState(null, null, "/admin/customers");
  } else if(path.match(pattern_items)){
    history.replaceState(null, null, "/admin/items");
  }
  });
});