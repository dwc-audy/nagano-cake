$(function() {
  $(document).on('turbolinks:load', () => {
    $("#address_postal_code").jpostal({
      postcode: ["#address_postal_code"],
      address: {
        "#address_address": "%3%4%5",
      }
    });
  });
});

$(function() {
  return $("#address_postal_code").jpostal({
    postcode: ["#address_postal_code"],
    address: {
      "#address_postal_code": '%3%4%5',
    },
  });
});