$(function() {
  $(document).on('turbolinks:load', () => {
    $("#customer_postal_code").jpostal({
      postcode: ['#order_postal_code'],
      address: {
        "#order_address": '%3%4%5',
      }
    });
  });
});

$(function() {
  return $('#order_postal_code').jpostal({
    postcode: ['#order_postal_code'],
    address: {
      "#order_address": '%3%4%5',
    },
  });
});