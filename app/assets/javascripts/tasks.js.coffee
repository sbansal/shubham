# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery -> 
	$('.task_check').click ->
		task_id = $(this).attr('id')
		alert("hello" + task_id)