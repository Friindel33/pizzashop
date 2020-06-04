function add_to_basket(id)
{
  var key = 'product_' + id; //extract variable

  var x = window.localStorage.getItem(key);
  x = x * 1 + 1;
  window.localStorage.setItem(key, x);

  update_orders_input();
  update_orders_button();
}

function update_orders_input()
{
  var orders = basket_get_orders();
  $('#orders_input').val(orders);
}

function update_orders_button()
{
  var text = 'Basket (' + basket_get_number_of_items() + ')';
  $('#orders_button').val(text);
}

function basket_get_number_of_items()
{
  var cnt = 0;

  for(var i = 0; i < window.localStorage.length; i++)
  {
    var key = window.localStorage.key(i); // get key
    var value = window.localStorage.getItem(key); // get value; in ruby it looks like hh[key] = x

    if (key.indexOf('product_') == 0)
    {
      cnt = cnt + value * 1;
    }
  }
  return cnt;
}

function basket_get_orders()
{
  var orders = '';

  for(var i = 0; i < window.localStorage.length; i++)
  {
    var key = window.localStorage.key(i); // get key
    var value = window.localStorage.getItem(key); // get value; in ruby it looks like hh[key] = x

    if (key.indexOf('product_') == 0)
    {
      orders = orders + key + '=' + value + ',';
    }
  }
  return orders;
}

function cancel_order()
{
  window.localStorage.clear();

    update_orders_input();
    update_orders_button();

  $('#basket').text('Your basket is now empty');

  return false;
}
