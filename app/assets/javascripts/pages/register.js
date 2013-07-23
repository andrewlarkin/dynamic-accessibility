require(['jquery', 'form_handler'], function($, formHandler){

  $('#register_form').on('submit', formHandler.register);

}); 