/**
 * 
 */
'use strict'

$(document).ready(function(){
	$('button#btn-logout').click(function(){
		window.location.href='logout.action'
	})
	$('button#btn-userAdmin').click(function(){
		window.location.href='userAdmin.action'
	})
	$('button#btn-admin').click(function(){
		window.location.href='reportAdmin.action'
	})
	$('button#btn-scheduler').click(function(){
		window.location.href='listScheduledReports.action'
	})
	$('button#btn-reports').click(function(){
		window.location.href='reportGroup.action'
	})
	$('button#btn-dashboard').click(function(){
		window.location.href='dashboard.action'
	})
	
	$('table.displaytag thead th.order1').append('&nbsp;<i class="fa fa-sort-down fa-fw"></i>')
	$('table.displaytag thead th.order2').append('&nbsp;<i class="fa fa-sort-up fa-fw"></i>')
})