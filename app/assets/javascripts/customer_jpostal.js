$(function() {
  $(document).on('turbolinks:load', () => {
    $("#customer_postal_code").jpostal({
      postcode: ['#customer_postal_code'],
      address: {
        "#customer_address": '%3%4%5',
      }
    });
  });
});

$(function() {
  return $('#customer_postal_code').jpostal({
    postcode: ['#customer_postal_code'],
    address: {
      "#customer_address": '%3%4%5',
    },
  });
});