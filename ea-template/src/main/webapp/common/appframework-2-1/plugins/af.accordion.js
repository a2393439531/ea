/*
 * @copyright: 2013 Intel
 * @description:  An accordion script that will animate hiding/showing content.
 */
;(function($,window){
	"use strict";
	var cache = [];
	var objId = function(obj) {
		if(!obj.afAccordionID) obj.afAccordionID = $.uuid();
		return obj.afAccordionID;
	};
	$.fn.accordion=function(opts){
		opts=opts||{};
		if(this.length===0) return;
		var tmp, id;
		for(var i = 0; i < this.length; i++) {
			//cache system
			id = objId(this[i]);
			if(!cache[id]) {
				if(!opts) opts = {};
				tmp = new Accordion(this[i], opts);
				cache[id] = tmp;
			} else {
				tmp = cache[id];
			}
		}
		return this.length == 1 ? tmp : this;
	};

	function Accordion(el,opts){
		var time=opts&&opts.time;
		var $el=$(el);
		if(time){
			$el.find("li>div").vendorCss("TransitionDuration",time);
		}
		$el.one('destroy', function(e){
           var id = el.afAccordionID;
           if(cache[id]) delete cache[id];
           e.stopPropagation();
           $el.off("click","li");
        });

        $el.on("click","li",function(e){

		var $e = $(e.target).siblings("div");
		$e.parent().addClass("active");
		$el.find("li").not($e.parent().get(0)).removeClass("active");
		$el.find("div: first").not($e.get(0)).css("height", "0px"); //xiao 查找第一个div
		
		window.setTimeout(function () {
//			//xiao
//			var display = $e.css("display");
//			if(display == "none"){
//				$e.css("display", "block");
//			}else{
//				$e.css("display", "none");
//			}
		if ($e.get(0).clientHeight > 0)
		    $e.css("height", "0");
		else {
		    var to = $e.data("height");
		    if (to == null)
		        to = "auto";
		    $e.css("height", to);
		}
		});
		e.preventDefault();
        });

	}
})(af,window);
