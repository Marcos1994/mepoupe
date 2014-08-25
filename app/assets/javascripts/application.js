// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .



$(document).ready(function()
{
	$('#entry_periodicidade').blur(function()
	{
		var val = $('#entry_periodicidade').val();
		if(val == 1)
		{
			$('#valor').html("Valor da parcela");
			$('#parcelas_field').css('height', '45px');
			$('#parcelas_field').css('opacity', '1');
			$('#parcelas').val("1");
		}
		else
		{
			$('#valor').html("Valor total");
			$('#parcelas_field').css('height', '0px');
			$('#parcelas_field').css('opacity', '0');
			$('#parcelas').val("1");
		}
	});
});