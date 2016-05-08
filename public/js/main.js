$(document).ready(function() {
  $('#parse').click(function() {
    try {
        console.log("en accion parse");
      var result = pl0.parse($('#input').val());
      console.log(result);
      $('#output').html(JSON.stringify(result,undefined,2));
    } catch (e) {
      $('#output').html('<div class="error"><pre>\n' + String(e) + '\n</pre></div>');
    }
  });

});