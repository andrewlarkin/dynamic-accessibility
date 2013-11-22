define('tasks/task', ['jquery', 'xooie/widgets/base', 'xooie/event_handler'], function($, Base, EventHandler){
  var Task = Base.extend(function(){
    var self = this;

    this._errorCount = 0;

    this._correctness = 0;

    this.root().on(this.initEvent(), function() {
      window.alert('Click "OK" to start the activity');

      self._startTime = new Date();
    });

    this._submitEvents = new EventHandler(this.namespace());

    this._submitEvents.add({
      click: function(event) {
        self.submit();
      }
    });

  });

  Task.define('namespace', 'task');

  Task.define('taskId');

  Task.define('target');

  Task.define('type');

  Task.define('activityId');

  Task.defineRole('tasksubmit', true);

  Task.prototype.checkCorrectness = function() {
    return 0;
  };

  Task.prototype.submit = function() {
    
    var time = new Date() - this._startTime;

    this.checkCorrectness();

    $.ajax({
      url: '/submit/',
      type: 'post',
      data: {
        participant_id: 15,
        task_id: this.taskId(),
        activity_id: this.activityId(),
        time: time,
        error_rate: this._errorCount,
        success_rate: this._correctness,
        type: this.type()
      },
      success: function(data, status, xhr) {
        alert('Activity Complete!  Click "OK" to continue to the next activity.');
      },
      error: function(xhr, status, error) {
        alert('Oops, something went wrong.  Click "OK" to restart the activity.');
      },
      complete: function() {
        window.location.reload();
      }
    });

    //submit error rate, total time (now - this._startTime)

  };

  Task.prototype._process_role_tasksubmit = function(tasksubmit) {
    tasksubmit.off(this._submitEvents.handlers);

    tasksubmit.on(this._submitEvents.handlers);
  };

  return Task;
});