$(document).ready(function(){
	startSetInterval();	

// $(".chat-submit").click(function(){
// 	//let's give the data a moment to submit before clearing the form.
// 	//probably a race condition
// 	setTimeout(function(){
// 		$("#message").val("");
// 	}, 1000)
	$("#chat").hover(function(){
		clearInterval(timer);
	}, function(){startSetInterval();})

	$(".chat-form").submit(function(){
		setTimeout(function(){
			$("#message").val("");
		}, 1000)
	})

});

function startSetInterval(){
	timer = setInterval(function(){
		$("#chat").load("/show-message");
		$('#chat').scrollTop($('#chat')[0].scrollHeight);
	}, 2000)

}

