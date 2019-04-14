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
	 
	//ACCORDION BUTTON ACTION (ON CLICK DO THE FOLLOWING)
	$('.accordionButton').click(function() {

		//REMOVE THE ON CLASS FROM ALL BUTTONS
		$('.accordionButton').removeClass('on');
		  
		//NO MATTER WHAT WE CLOSE ALL OPEN SLIDES
	 	$('.accordionContent').slideUp('normal');
		$('.firstContent').slideUp('normal');
   
		//IF THE NEXT SLIDE WASN'T OPEN THEN OPEN IT
		if($(this).next().is(':hidden') == true) {
			
			//ADD THE ON CLASS TO THE BUTTON
			$(this).addClass('on');
			  
			//OPEN THE SLIDE
			$(this).next().slideDown('normal');
		 } 
		  
	 });	 
	  
	
    $("area").hover(function() {                
        $('#description div').removeClass('selected').css('display', 'none');
        
        var boardDesc = '.'+$(this).attr('id')+'-desc';
        $(boardDesc).addClass('selected').css('display', 'block');
    });  
    
    $("#board_navigation li a").click(function() {                                
        var navid = '.'+$(this).attr('id')+'-desc';        
        //$(boardDesc).addClass('selected').css('display', 'block');
        
        //Add hide and remove here on current selection
        $('.here').removeClass('here');        
        $('.select').addClass('hide');        
        $('.select').removeClass('select');        
        
        //Remove hide and add here on new selection
        $(navid).removeClass('hide');        
        $(navid).addClass('select');        
        $(this).addClass('here');
    });    
    
    $("#key_navigation li a").click(function() {                                
        var navid = '.'+$(this).attr('id')+'-desc';        
        //$(boardDesc).addClass('selected').css('display', 'block');
        
        //Add hide and remove here on current selection
        $('.here_key').removeClass('here_key');        
        $('.select_key').addClass('hide_key');        
        $('.select_key').removeClass('select_key');        
        
        //Remove hide and add here on new selection
        $(navid).removeClass('hide_key');        
        $(navid).addClass('select_key');        
        $(this).addClass('here_key');
    });   
    
    $("#doc_navigation li a").click(function() {                                
        var navid = '.'+$(this).attr('id')+'-desc';        
        //$(boardDesc).addClass('selected').css('display', 'block');
        
        //Add hide and remove here on current selection
        $('.here_doc').removeClass('here_doc');        
        $('.select_doc').addClass('hide_doc');        
        $('.select_doc').removeClass('select_doc');        
        
        //Remove hide and add here on new selection
        $(navid).removeClass('hide_doc');        
        $(navid).addClass('select_doc');        
        $(this).addClass('here_doc');
    });   
    
    $("#highlight_navigation li a").click(function() {                                
        var navid = '.'+$(this).attr('id')+'-desc';        
        //$(boardDesc).addClass('selected').css('display', 'block');
        
        //Add hide and remove here on current selection
        $('.here_nav').removeClass('here_nav');        
        $('.select_nav').addClass('hide_nav');        
        $('.select_nav').removeClass('select_nav');        
        
        //Remove hide and add here on new selection
        $(navid).removeClass('hide_nav');        
        $(navid).addClass('select_nav');        
        $(this).addClass('here_nav');
    });  
    
    $("#ide_navigation li a").click(function(){                                
        var navid = '.'+$(this).attr('id')+'-desc';        
        //$(boardDesc).addClass('selected').css('display', 'block');
        
        //Add hide and remove here on current selection
        $('.here_ide').removeClass('here_ide');        
        $('.select_ide').addClass('hide_ide');        
        $('.select_ide').removeClass('select_ide');        
        
        //Remove hide and add here on new selection
        $(navid).removeClass('hide_ide');        
        $(navid).addClass('select_ide');        
        $(this).addClass('here_ide');
    });            
	
	
	/********************************************************************************************************************
	CLOSES ALL S ON PAGE LOAD
	********************************************************************************************************************/		

    $('.accordionContent').hide();   
               
    /*if(!!$(selector).length){
    
    }*/               
});
