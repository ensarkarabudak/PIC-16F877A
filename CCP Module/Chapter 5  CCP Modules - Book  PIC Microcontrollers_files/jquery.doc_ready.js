/***********************************************************************************************************************
DOCUMENT: includes/javascript.js
DEVELOPED BY: Ryan Stemkoski
COMPANY: Zipline Interactive
EMAIL: ryan@gozipline.com
PHONE: 509-321-2849
DATE: 3/26/2009
UPDATED: 3/25/2010
DESCRIPTION: This is the JavaScript required to create the accordion style menu.  Requires jQuery library
NOTE: Because of a bug in jQuery with IE8 we had to add an IE stylesheet hack to get the system to work in all browsers. I hate hacks but had no choice :(.
************************************************************************************************************************/
$(document).ready(function() {	       	
    //Top navigation hover
    function megaHoverOver(){
	    var check_close = true;
		
		if($(this).attr("id") == "all_solutions"){
			solution_hovering = true;
		}
		
	    if($(this).attr("id") == "all_solutions" && selection_opened){
            check_close = false; 
		}
			
	    if($(this).attr("id") == "select_solution"){
            check_close = false; 
		}			
						
		if(check_close){
			if(selection_opened){
				close_selection("#dropdown");			
			}
			
			$(this).find(".links").stop().fadeTo(0, 0.95).show();
			$(this).find(".hover_intent").addClass("selected_nav");			        				
		}				
    }
    
    function megaHoverOut(){
	    var check_close = true;
			
	    if(solution_hovering && selection_opened){
            check_close = false;
		}			
		
		if($(this).attr("id") == "all_solutions"){
			solution_hovering = false;
		}		
		
		if(check_close){
			$(this).find(".links").stop().hide();  
			$(this).find(".hover_intent").removeClass("selected_nav");						
			
			if(selection_opened){
				close_selection("#dropdown");							
			}		
		}
    }

    //Grey div box
    function greyBoxOut(){ 
       var docHeight = $(document).height();

       $("body").append("<div id='overlay'></div>");

       $("#overlay")
          .height(docHeight)
          .css({
             'opacity' : 0.4,
             'position': 'absolute',
             'top': 0,
             'left': 0,
             'background-color': 'black',
             'width': '100%',
             'z-index': 5000
          });
    }    
    

    var config = {    
         sensitivity: 2, // number = sensitivity threshold (must be 1 or higher)    
         interval: 1, // number = milliseconds for onMouseOver polling interval    
         over: megaHoverOver, // function = onMouseOver callback (REQUIRED)    
         timeout: 100, // number = milliseconds delay before onMouseOut    
         out: megaHoverOut // function = onMouseOut callback (REQUIRED)    
    };

    $("ul#topnav li .links").css({'opacity':'0'});
    $("ul#topnav li.menu").hoverIntent(config);
	$("ul#topnav li.drop_menu").hoverIntent(config);

    //Quick search initialization
    $('input#search_mcu').quicksearch('.mcu_row');        
    
    $("area").hover(function() {                
        $('#selector div').removeClass('selected').css('display', 'none');
        
        var boardDesc = '.'+$(this).attr('id')+'-desc';
        $(boardDesc).addClass('selected').css('display', 'block');
    });  

    //Init scrollable
    $("#chained").scrollable({circular: true, mousewheel: true}).navigator().autoscroll({
        interval: 7000    
    });		    			
	
    //$('<div id="effect_overlay"></div>').appendTo('body');            	
	$('a.lightbox').lightBox(); // Select all links with lightbox class
	
	//Accessory Boards loader	
	if ($("#acc_boards").length > 0) {
		$.ajax({
			url: '/eng/categories/get_boards/',
			success: function(data) {
				var parsedData = jQuery.parseJSON(data);
				$('#acc_boards').html(parsedData.content);						
			},
			error: function(xhr,textStatus,error) {
				alert('Error: '+xhr.statusText);
			}			
		});	
	}	
	
    $(".cart_buy").click(function() {   
        /*//Fade in fade out +1 tear
        var pos = $(this).offset(); 
        var width = $(this).width(); 
        $('.tooltip').css({ 'left': (pos.left + 38) + 'px', 'top':(pos.top - 40) + 'px' }).fadeIn('fast').delay(200).fadeOut('fast');*/                
    });
	
    $('input#search_mcu').quicksearch('.mcu_row');
    $('input#search_examples').quicksearch('.example_row'); 	
	
    $("div.fancy_box").hover(
        function()
        {    
            /*var div = $(this).children('.hover_promo');
            div.show();  */    
            $(this).addClass('fancy_hover');            
        },
       function() {
          //$(".hover_promo").hide();
          if($(this).hasClass('fancy_hover')){
              $(this).removeClass('fancy_hover');
          }
       }        
    );  	
});