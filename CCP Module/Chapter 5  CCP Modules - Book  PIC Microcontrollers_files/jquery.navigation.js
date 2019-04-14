var selection_opened = false;
var solution_hovering = false;

function change_mcu(mcu){
    var solution =  "."+mcu+"_solution";
    
    if(mcu != "turn_off"){
		$("#dropdown").removeClass();
		$("#dropdown").addClass("full_opacity");                        
		$("#dropdown").addClass(mcu);				

		$("#select_solution").removeClass("hide_content");

		$(solution).find(".links").stop().fadeTo(0, 0.95).show();            	
		$(solution).find(".hover_intent").addClass("selected_nav");
    }else{
		$("#select_solution").addClass("hide_content");
    }
    
    if(selection_opened){
		close_selection('#dropdown');
    }
}//~!

function open_selection(element){
	var mcu = $(element).attr('class').split(' ')[1]; 
	$(element).removeClass(mcu);
	$(element).addClass('invert_'+mcu);
	$(element).parent().find(".links").stop().fadeTo(0, 0.95).show();            	
	selection_opened = true;
    //Invert arrow	
    $('.drop_up_arrow').removeClass('hide_content');
	$('.drop_down_arrow').addClass('hide_content');
}//~!

function close_selection(element){
	var mcu = $(element).attr('class').split(' ')[1]; 									
	$(element).removeClass(mcu);
	mcu = mcu.replace('invert_','');
	$(element).addClass(mcu);			
	$(element).parent().find(".links").stop().hide();  
	selection_opened = false;		
    //Invert arrow	
    $('.drop_down_arrow').removeClass('hide_content');
	$('.drop_up_arrow').addClass('hide_content');	
}//~!	

$("#main").ready(function() {
    $(".navigator_solution a").hover(function(event) {
        if($("#info_box").is(":visible")){
			$(".box_close").click();
		}
    });	
		
    /*$(".drop_menu a.solution").click(function(event) {			
            change_mcu($(this).attr('class').split(' ')[0]);
            return false;
    });*/

    $("#dropdown").click(function(event) {				        
            if(!selection_opened){
               open_selection(this);
            }else{
               close_selection(this);
            }
            return false;
    });
	
	/*$("#all_solutions").hover(
	  function () {
		solution_hovering = true;
	  }, 
	  function () {
		solution_hovering = false;
	  }
	);*/
	
});