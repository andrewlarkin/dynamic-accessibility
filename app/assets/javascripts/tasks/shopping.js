define('tasks/shopping', ['jquery', 'tasks/task'], function($, Task){

  var Shopping = Task.extend(function() {});

  Shopping.define('type', 'shopping');

  Shopping.defineRole('addbutton');

  Shopping.prototype.addToCart = function(button) {
    button.toggleClass('added');

    if (button.is('.added')) {
      if (!button.data('isTarget')) {
        this._errorCount += 1;
      }
      
      button.text('Remove from Cart');
    } else {
      button.text('Add to Cart');
    }
  };

  Shopping.prototype.checkCorrectness = function() {
    var target = this.addbuttons().filter('[data-is-target="true"]'),
        liked = this.addbuttons().filter('.added').not(target);

    if (target.is('.added')) {
      this._correctness = (1 - (liked.length / this.addbuttons().length)) * 100;
    }
  };

  Shopping.prototype._process_role_addbutton = function(addbuttons) {
    var self = this;

    addbuttons.on('click', function(e){
      self.addToCart($(this));
    });
  };

  return Shopping;

});
