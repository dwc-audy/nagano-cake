$(function(){
  let select = document.querySelector("#column");
  select.onchange = event => {
    if(select.value == "last_name"){
      $("#value").attr("placeholder", "名前(姓)");
    } else if(select.value == "first_name"){
      $("#value").attr("placeholder", "名前(名)");
    };
  };
});
$(function() {
  $(document).on('turbolinks:load', () => {
    let select = document.querySelector("#column");
    select.onchange = event => {
    if(select.value == "last_name"){
      $("#value").attr("placeholder", "名前(姓)");
    } else if(select.value == "first_name"){
      $("#value").attr("placeholder", "名前(名)");
    };
  };
  });
});