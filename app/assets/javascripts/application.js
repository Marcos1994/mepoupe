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
//= require_tree .



$(document).ready(function()
{
	var relatorio = $('#paginaRelatorio').attr('class').toString();
	if(relatorio != "undefined") preencherMeses(relatorio);
	
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
	
	$('.legendaRelatorio').click(function()
	{
		$('.linha').css('opacity', '0.5');
		$('#despesa' + $(this).attr('id')).css('opacity', '1');
		$('#receita' + $(this).attr('id')).css('opacity', '1');
	});
});


function preencherMeses(relatorio)
{
	var mes = "";
	for(i = 5; i < 7; i++)
		mes += relatorio[i];
	mes = parseInt(mes);
	
	var html = "<td></td>";
	for(i = 1; i < 10; i++)
	{
		html += "<td>" + mesToString(mes--) + "</td>";
		if(mes < 1) mes = 12;
	}
	$('.meses').html(html);
}

function mesToString(mes)
{
	switch(mes)
	{
		case 1:
			mes = "Jan";
			break;
		case 2:
			mes = "Fev";
			break;
		case 3:
			mes = "Mar";
			break;
		case 4:
			mes = "Abr";
			break;
		case 5:
			mes = "Mai";
			break;
		case 6:
			mes = "Jun";
			break;
		case 7:
			mes = "Jul";
			break;
		case 8:
			mes = "Ago";
			break;
		case 9:
			mes = "Set";
			break;
		case 10:
			mes = "Out";
			break;
		case 11:
			mes = "Nov";
			break;
		case 12:
			mes = "Dez";
			break;
	}
	return mes;
}