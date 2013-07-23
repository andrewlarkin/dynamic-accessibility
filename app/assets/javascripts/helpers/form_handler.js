define('form_handler', ['jquery'], function($){
  var formHandler = {
    register: function(event){
      console.log(this);

      event.preventDefault();
    }
  };

  return formHandler;
});