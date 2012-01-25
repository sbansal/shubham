# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	if $('#last_tweet').text() == '' or $('#last_tweet').text() == '- Follow us on twitter'
		try 
			url ='http://api.twitter.com/1/statuses/user_timeline/tracelyapp.json?callback=?'
			$.getJSON url, (tweet) ->
				if tweet[0]
					tweet_text = tweet[0].text
					regex = /(https?:\/\/[^\s]+)/g;
					text = tweet_text.replace(regex, "<a href='$1'>$1</a>");
					$('#last_tweet').html " - " + text
				else
					$('#last_tweet').html "- Follow us on twitter"
		catch error
			$('#last_tweet').html "- Follow us on twitter"