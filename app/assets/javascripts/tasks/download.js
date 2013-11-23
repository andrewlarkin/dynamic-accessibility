define('tasks/download', ['jquery', 'tasks/task'], function($, Task){

  var Download = Task.extend(function() {});

  Download.define('type', 'download');

  Download.defineRole('downloadbutton');

  Download.prototype.downloadImg = function(button) {
    if (!button.data('isTarget')) {
      this._errorCount += 1;
    }

    button.addClass('downloaded');
  };

  Download.prototype.checkCorrectness = function() {
    var target = this.downloadbuttons().filter('[data-is-target="true"]'),
        downloaded = this.downloadbuttons().filter('.downloaded').not(target);

    if (target.is('.downloaded')) {
      this._correctness = (1 - (downloaded.length / this.downloadbuttons().length)) * 100;
    }
  };

  Download.prototype._process_role_downloadbutton = function(downloadbuttons) {
    var self = this;

    downloadbuttons.on('click', function(e) {
      self.downloadImg($(this));
    });
  };

  return Download;

});
