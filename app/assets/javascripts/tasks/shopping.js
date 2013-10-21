define('tasks/shopping', ['jquery', 'tasks/task'], function($, Task){

  var Shopping = Task.extend(function() {});

  Shopping.defineRole('addbutton');

  Shopping.prototype.addToCart = function(button) {
    if (!button.data('isTarget')) {
      this._errorCount += 1;
    }

    button.toggleClass('added');

    if (button.is('.added')) {
      button.text('Remove from Cart');
    } else {
      button.text('Add to Cart');
    }
  };

  Shopping.prototype.checkCorrectness = function() {
    var target = this.addbuttons().filter('[data-is-target="true"]'),
        liked = this.addbuttons().filter('.added').not(target);

    if (target.is('.added')) {
      this._correctness = 100 - (liked.length / this.addbuttons().length);
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
