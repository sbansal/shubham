# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ -> 
	$('.task_check').live 'click', -> 
		$task = $(this)
		task_id = $task.attr 'id'
		checked = $task.is ':checked'
		if checked
			$.getScript("/update_task.js?id=" + task_id + "&checked=1")
			true
		else
			$.getScript("/update_task.js?id=" + task_id + "&checked=0")
			true
	    