$(function () {
    // input text
    $('.input_text_wrap,.textarea_wrap,.input-text-wrap').each(function () {
        var $this = $(this);
        var $field = $this.find('[type=text], [type=file], [type=email], [type=password], [type=button], textarea');
        var $label = $(this).find('label');

        $field.on('focusin change', function () {
            $label.fadeOut(100);
        })
        $field.on('focusout', function () {
            $label.fadeOut(100);
            if($field.val() == ''){
                $label.fadeIn(0, 100);
            }
        });
    });

    // main class item animate event
    $('.main_class_item').on('mouseover focusin', function(){
        $('.main_class_item').removeClass('active');
        $('.main_class_box').removeClass('hover');
        $(this).addClass('active');
        $('.main_class_box').addClass('hover');
    });
    $('.main_class_item').on('mouseout focusout', function(){
        $('.main_class_item').removeClass('active');
        $('.main_class_box').removeClass('hover');
    });
    
    $('.main_class_item').click(function(){
        if($(this).parent().hasClass('click') === true){
            $('.main_class_item').removeClass('c_active');
            $('.main_class_box').removeClass('click');
        };
        $(this).addClass('c_active');
        $('.main_class_box').addClass('click');
    });
});