//params
var vars = [], hash;
var q = document.URL.split('?')[1];
if(q != undefined){
    q = q.split('&');
    for(var i = 0; i < q.length; i++){
        hash = q[i].split('=');
        vars.push(hash[1]);
        vars[hash[0]] = hash[1];
    }
}

$(function() {
	
	//on load
	$('#pill_id').val(vars['pill_id']);
	
	if($('#reminders').length > 0){
		$.ajax({
	    	url: 'http://careshareapp.herokuapp.com/pills/reminders/?callback=?',
	        type: "GET",
	        dataType: "jsonp",
	        crossDomain: true,
	        jsonpCallback: "func"
	    })
	    .done(function (data) {	
	    	$.each(data, function(i, result){  
	    		  	
	     	$('#reminders').append(
	     		"<li data-theme='c'>" + data[i].date + "- (1) " + data[i].name + " " + data[i].dosage + data[i].unit + " (" + data[i].freq + " by " + data[i].location + ")</li>"		
	     	);	
	     	$('#reminders').listview('refresh');   
	     });
	     		     		
	    })
	    .fail(function (XHR, status, error) {alert(error);});	
	}
	
	
	
	
	/*if($('#display_pill').length > 0){
		pill_id = $('#pill_id').val();
		$.ajax({
	    	url: 'http://careshareapp.herokuapp.com/pills/' + pill_id + '?callback=?',
	        type: "GET",
	        dataType: "jsonp",
	        crossDomain: true,
	        jsonpCallback: "func"
	    })
	    .done(function (data) {	    	
	     	$('#display_pill').append(
	     		"<li>" + data.id + "</li>"    		
	     	);	     	     		
	    })
	    .fail(function (XHR, status, error) {alert(error);});	
	}*/
	
	if ($("#period_input").length > 0){	
		pill_id = $('#pill_id').val();
		$.ajax({
	    	url: 'http://careshareapp.herokuapp.com/pills/' + pill_id + '/show_periods?callback=?',
	        type: "GET",
	        dataType: "jsonp",
	        crossDomain: true,
	        jsonpCallback: "func"
	    })
	    .done(function (data) {
	   
	    	for(var i=0;i<data.number;i++){
	    	count = i + 1;
		     	$('#period_input').append(
		     		"<li>Dose " + count + ":<input id='period" + count + "' type='time'/></li>"    		
		     	);
		     }
		     		
	    })
	    .fail(function (XHR, status, error) {alert(error);});
	  
	$('#period_submit').on('click', function(){
		pill_id = $('#pill_id').val();
		query = "&phone=" + $('#phone').val();
		counter = 0; period = counter + 1;
		$('#period_input').children().each( function(){
			query+= "&period" + period  + "=" + $('#period' + period).val();
				counter++; period++;
		});
		
		
		$.ajax({
	    	url: 'http://careshareapp.herokuapp.com/pills/' + pill_id + '/add_periods?callback=?' + query,
	        type: "GET",
	        dataType: "jsonp",
	        crossDomain: true,
	        jsonpCallback: "func"
	    })
	    .done(function (data) {
	    	document.location.href = "index.html?pill_id=" + pill_id;	    	
	    })
	    .fail(function (XHR, status, error) {alert(error);});
		return false;
		
	})
	
		return false;
    } 

	
	//enter dosage
	$("#dosage_submit").on('click', (function(){
		pill_id = $('#pill_id').val();
		query = "dosage=" + $('#dosage').val() + "&number=" + $('#selectmenu3').val() + "&frequency=" + $('#selectmenu2').val();
		query+= "&unit=" + $('#unit').val() + "&location=" + $('#selectmenu4').val();
		$.ajax({
	    	url: 'http://careshareapp.herokuapp.com/pills/' + pill_id + '/update_pills?callback=?&' + query,
	        type: "GET",
	        dataType: "jsonp",
	        crossDomain: true,
	        jsonpCallback: "func"
	    })
	    .done(function (data) {
	    	 $.each(data, function(){
		     	document.location.href = "page7.html?pill_id=" + data.pill_id;
		     });	
	    })
	    .fail(function (XHR, status, error) {alert(error);});
		return false;
    }));    
    
	$('#show_dosage_submit').on('click', function(){
		pill_id = $('#pill_id').val();
		document.location.href = "page8.html?pill_id=" + pill_id;
	})
});	

//select pills
function select_pill(element){
	query = "user_id=1&pill_data_id=" + $(element).attr('id');
	$.ajax({
    	url: 'http://careshareapp.herokuapp.com/pills/create_pill?callback=?&' + query,
        type: "GET",
        dataType: "jsonp",
        crossDomain: true,
        jsonpCallback: "func"
    })
    .done(function (data) {
    	 //$.each(data, function(){
	     	document.location.href = "page5.html?pill_id=" + data.pill_id;
	     //});	
    })
    .fail(function (XHR, status, error) {alert(error);});
	return false;
}  

function search_button(){
    	
		query = "query=" + $('#searchinput1').val();
		$.ajax({
	    	url: 'http://careshareapp.herokuapp.com/pills/find?callback=?&' + query,
	        type: "GET",
	        dataType: "jsonp",
	        crossDomain: true,
	        jsonpCallback: "func"
	    })
	    .done(function (data) {list_pills(data);})
	    .fail(function (XHR, status, error) {alert(error);});
		return false;
    	
}

function list_pills(result){
    $.each(result, function(){
      $('#search-results').empty();
      $('#search-results').append('<li data-theme="c"><a id="r' + result.id + '" onclick="select_pill(this);" class="select_pill" href="#" data-transition="slide">' + result.name + '</a></li>');
	  $('#search-results').listview('refresh');
});}
	