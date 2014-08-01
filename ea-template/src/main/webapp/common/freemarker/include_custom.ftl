<#include "macro_common.ftl">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<style>

/* ################## */
/* ##### Public ##### */
/* ################## */
a {
	cursor: pointer;
}
a {
	color: #00A9D4;
	text-decoration: none;
}
a:hover, a:focus {
	color: #00625F;
	text-decoration: none;
}
body {
	color: #00285F;
}
/* ################## */
/* ##### Button ##### */
/* ################## */
.btn-xs {
	padding: 2px 7px;
	margin-left: 1px;
}
.btn-custom {
	color: #fff;
	font-weight: bold;
	background-color: #8f3f7b;
	border-color: #7B0663;
}
.btn-custom:hover, .btn-custom:focus, .btn-custom:active, .btn-custom.active, .open .dropdown-toggle .btn-custom {
	color: #fff;
	background-color: #7B0663;
	border-color: #7B0663;
}
/* ################## */
/* ###### table ######*/
/* ################## */
.table-bordered>thead>tr>th, 
.table-bordered>tbody>tr>th, 
.table-bordered>tfoot>tr>th, 
.table-bordered>thead>tr>td, 
.table-bordered>tbody>tr>td, 
.table-bordered>tfoot>tr>td {
	text-align: center;
}
/* ################## */
/* ##### SideBar #####*/
/* ################## */
.bs-sidenav {
	padding-top: 0;
	margin-top: 0;
	margin-left: 12px;
	background-color: #fff;
}
.bs-sidebar .nav > li {
	width: 198px;
 	background:url(common/images/dotted_level.gif) repeat-x bottom left;
}
.bs-sidebar .nav > li > a {
	display: block;
  	color: #00285F;
  	padding: 10px 20px;
  	line-height: 26px;
}
.bs-sidebar .nav > li > a:hover,
.bs-sidebar .nav > li > a:focus,
.bs-sidebar .nav > li > a:active {
  	text-decoration: none;
  	background-color: #fff;
  	border: none;
  	background:url(common/images/dotted_level.gif) repeat-x bottom left;
  	color: #7B0663;
}

/* =========================================================================================================== */

/* ################## */
/* ##### Header ##### */
/* ################## */
.header_Style {
	background-color: #00295A;
}
.header_logoStyle {
	margin: 12px 0 0 12px; 
}
.header_logoStyle>a {
	color: #fff;
	text-decoration: none;
}
.header_navBarStyle{
	color: #fff;
	padding: 12px 12px 0 0;
}
.header_navBarStyle>a {
	color: #fff;
	text-decoration: none;
}

/* ################## */
/* ##### Panel ###### */
/* ################## */
.panel-heading strong {
	padding-left: 10px;
}

/* ################## */
/* ##### Module ##### */
/* ################## */
.moduleDisplay {
	width: 100%;
}
.moduleDisplay a {
	color: #00295A;
	text-decoration: none;
}
.templateTitle {
	border-right: 2px solid #fff;
	padding: 8px 0;
	color: #fff;
	font-weight: bold;
	text-align: center;
}
.templateTitle td {
	color: #fff;
	font-weight: bold;
	padding: 6px 0;
}
.templateFour td {
	width:25%;
}
.templateEight td {
	width:12%;
}
.templateTen td {
	width: 7%;
}
.templateFour td, .templateEight td, .templateTen td{
	text-align: center;
	vertical-align: top;
	border-right: 2px solid #fff;
	border-bottom: 2px solid #fff;
}
.templateFour ul, .templateEight ul {
	padding-left: 0;
	margin-bottom: 0;
	list-style: none;
	padding: 10px 0;
}
.templateFour li, .templateEight li {
	position: relative;
	display: block;
}
.templateFour a, .templateEight a {
	position: relative;
	display: block;
	padding: 8px 0;
}
.templateTen a {
	position: relative;
	display: block;
	padding: 32px 0;
	color: #fff;
}
.pubModuNam {
	background-color: #5bc0de;
}
.archiNam {
	background-color: #d9534f;
}
.pubModuNam, .archiNam {
	width: 25%;
	padding: 8px 0;
	border-right: 1px solid #fff;
	border-bottom: 1px solid #fff;
	color: #fff;
	text-align: center;
	font-weight: bold;
}
.pubModuCon {
	background-color: #EDF3F6;
}
.archiCon {
	background-color: #FFF3E8;
}
.pubModuCon, .archiCon {
	border-bottom: 1px solid #fff;
	padding-left: 10px;
}

/* ################## */
/* ##### color ###### */
/* ################## */
.templateRed {
	background-color: #FFF3E8;
}
.templateRed a:hover, .templateRed a:focus {
	color: #CE1A37;
	background-color: #FFE6D2;
}
.templateOrange {
	background-color: #f0ad4e;
}
.templateOrange a:hover, .templateOrange a:focus {
	color: #FF6C00;
	background-color: #fcf8e3;
}
.templateYellow {
	background-color: #FDFDDE;
}
.templateYellow a:hover, .templateYellow a:focus {
	color: #FFC400;
	background-color: #FCFACA;
}
.templateBlue {
	background-color: #F1F8F9;
}
.templateBlue a:hover, .templateBlue a:focus {
	color: #006C79;
	background-color: #E5F4F6;
}
.templateGreen {
	background-color: #F2FFE2;
}
.templateGreen a:hover, .templateGreen a:focus {
	color: #376915;
	background-color: #ECFFCE;
}
.templatePurple {
	background-color: #F4F0FF;
}
.templatePurple a:hover, .templatePurple a:focus {
	color: #433657;
	background-color: #ECE6FE;
}
</style>

</head>	

<body>