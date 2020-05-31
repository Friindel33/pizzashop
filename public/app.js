function something()
  {
      var x = window.localStorage.getItem('bbb'); // x = hh['bbb']

      x = x * 1 + 1; //x = x + 1, *1 because x comes as a string, so we make it integer

      window.localStorage.setItem('bbb', x); // hh['bbb'] = x

      alert(x);
  }

function add_to_card(id)
{
  var key = 'product_' + id; //extract variable
  
  var x = window.localStorage.getItem(key);
  x = x * 1 + 1;
  window.localStorage.setItem(key, x);
}
