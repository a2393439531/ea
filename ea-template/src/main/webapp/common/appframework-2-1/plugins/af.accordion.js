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
		accid = 0;
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
				
				var $el = $(this[i]);
				$el.find("div>table").css("display", "none");
				var items = $el.find("div");
				for(var i =0; i < items.length; i++){
					var id = $(items[i]).attr("id");
					if(!id) $(items[i]).attr("id", "accid_" + (accid++));
				}
			}
		}
		return this.length == 1 ? tmp : this;
	};
	var accid = 0;
	function Accordion(el,opts){
		var time=opts&&opts.time;
		var $el=$(el);
		
		if(time){
			$el.find("div>li").vendorCss("TransitionDuration",time);
			$el.find("div>table").css("display", "none");
			var items = $el.find("div");
			for(var i =0; i < items.length; i++){
				var id = $(items[i]).attr("id");
				if(!id) $(items[i]).attr("id", "accid_" + (accid++));
			}
		}
		
		$el.one('destroy', function(e){
           var id = el.afAccordionID;
           if(cache[id]) delete cache[id];
           e.stopPropagation();
           $el.off("click","li");
        });
        $el.on("click","li",function(e){
			var $e = $(e.target).siblings("table");
			showhidecontent($e);
			
			e.preventDefault();
        });

	}
})(af,window);

function showhidecontent(obj){
	var $e = obj;
	var pid = $e.parent().attr("id");
	var acc = $e.parent().parent();
	var items = acc.find("div");
	
	//先关闭其它 ITEM 的内容
	for(var i =0; i < items.length; i++){
		if($(items[i]).attr("id") == pid){
			continue;
		}
		$(items[i]).find("div>table").css("display", "none");
	}
	var display = $e.css("display");
	if(display == "none"){
		$e.css("display", "block");
	}else{
		$e.css("display", "none");
	}
}
