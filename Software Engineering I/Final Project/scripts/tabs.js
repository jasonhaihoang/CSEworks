jQuery(document).ready(function(){
    jQuery('.tabs .tab-links li').on('click', function(e){
        var currentAttrValue = jQuery(this).attr('name');
 
        // Show/Hide Tabs
        jQuery('.tabs ' + currentAttrValue).show().siblings().hide();
 
        // Change/remove current tab to active
        jQuery(this).addClass('active').siblings().removeClass('active');
  
        e.preventDefault();
    });
});