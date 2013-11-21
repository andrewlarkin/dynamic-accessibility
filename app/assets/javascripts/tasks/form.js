define('tasks/form', ['jquery', 'tasks/task', 'xooie/helpers'], function($, Task, helpers){

  var Form = Task.extend(function() {});

  function checkInput (input) {
    var value = input.val().toString().toLowerCase(),
        target = input.data('targetValue');

    if (typeof target !== 'undefined') {
      target = target.toString().toLowerCase();
    }

    if (value !== "" && target !== value) {
      return 1;
    } else {
      return 0;
    }
  }

  Form.define('type', 'form');

  Form.defineRole('forminput');

  Form.prototype.errorCheck = function(input) {
    this._errorCount += checkInput(input);
  };

  Form.prototype.checkCorrectness = function() {
    var incorrect = 0;

    this.forminputs().each(function(){
      incorrect += checkInput($(this));
    });

    this._correctness = (1 - incorrect / this.forminputs().length) * 100;
  };

  Form.prototype._process_role_forminput = function(forminputs) {
    var self = this;

    forminputs.on('blur', function(event) {
      self.errorCheck($(this));
    });
  };

  return Form;

});
