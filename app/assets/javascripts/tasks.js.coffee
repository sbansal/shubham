# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ -> 	
	for elem in $("input:text")
		placeholder = $(elem).attr("placeholder")
		if placeholder
			$(elem).val(placeholder)
			$(elem).css("color", "#AAA")
		else
			return false
		$(elem).focus -> 
			$(elem).val("")
			$(elem).css("color", "#000")
		$(elem).focusout ->
			if $(elem).val() == ""
				$(elem).val(placeholder)
				$(elem).css("color", "#AAA")
			
			
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