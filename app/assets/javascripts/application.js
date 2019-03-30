// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require popper
//= require cocoon
//= require jquery.mask
// = require tabler/tabler
// = require tabler/vendors/bootstrap.bundle.min
// = require tabler/vendors/circle-progress.min
// = require tabler/vendors/jquery.sparkline.min
// = require tabler/core


$(function() {
  $('.dropdown-toggle').dropdown();
  $('[data-toggle="tooltip"]').tooltip();

	 var SPMaskBehavior = function (val) {
    return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
  },
  spOptions = {
    onKeyPress: function(val, e, field, options) {
        field.mask(SPMaskBehavior.apply({}, arguments), options);
      }
  };

  $(".cpf").focus(function(){$(this).attr("inputmode","numeric")});
  $('.cpf').mask('000.000.000-00', {reverse: true});
    
  $(".monetario").focus(function(){$(this).attr("inputmode","numeric")});
  $('.monetario').mask('000.000.000.000.000,00', {reverse: true});

  $(".telefone").focus(function(){$(this).attr("inputmode","numeric")});
  $('.telefone').mask(SPMaskBehavior, spOptions);

  $(".cep").focus(function(){$(this).attr("inputmode","numeric")});
  $('.cep').mask('00000-000');

  $(".numero").focus(function(){$(this).attr("inputmode","numeric")});
  $('.numero').mask('00000');
});
