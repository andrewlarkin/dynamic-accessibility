define('tasks/post', ['jquery', 'tasks/task'], function($, Task){

  var Post = Task.extend(function() {});

  Post.define('type', 'post');

  Post.defineRole('likebutton');

  Post.prototype.flagButton = function(button) {
    if (!button.data('isTarget')) {
      this._errorCount += 1;
    }

    button.toggleClass('flagged');

    if (button.is('.flagged')) {
      button.text('Unlike');
    } else {
      button.text('Like');
    }
    
  };

  Post.prototype.checkCorrectness = function() {
    var target = this.likebuttons().filter('[data-is-target="true"]'),
        liked = this.likebuttons().filter('.flagged').not(target);

    if (target.is('.flagged')) {
      this._correctness = (1 - (liked.length / this.likebuttons().length)) * 100;
    }
  };

  Post.prototype._process_role_likebutton = function(likebuttons) {
    var self = this;

    likebuttons.on('click', function(e){
      self.flagButton($(this));
    });
  };

  return Post;

});
