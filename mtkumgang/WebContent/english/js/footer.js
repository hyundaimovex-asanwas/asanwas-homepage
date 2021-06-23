<!--
/***********************************************************************
* 스크립트명 : 패밀리사이트 보기
***********************************************************************/
function familysiteOn(objTD) {
	obj = document.getElementById("familysite") ;
	if (obj.style.display == "none") {
		obj.style.display = "" ;
	} else {
		obj.style.display = "none" ;
	}
}

/***********************************************************************
* 스크립트명 : 패밀리사이트 닫기
***********************************************************************/
function familysiteOff() {
	obj = document.getElementById("familysite") ;
	obj.style.display = "none" ;
}

/***********************************************************************
* 스크립트명 : 푸터출력
***********************************************************************/
function writeFooter() {

	familySite = new Object() ;
	familySite.total = 0 ;

	familySite.site1 = ["Hyundai Group" ,						"http://www.hyundaigroup.com"] ;
	familySite.site2 = ["Hyundai Elevator" ,					"http://www.hyundaielevator.co.kr"] ;
	familySite.site3 = ["Hyundai Merchant Marine" ,		"http://www.hmm21.com"] ;
	familySite.site4 = ["Hyundai Logistics" ,					"http://www.hlc.co.kr"] ;
	familySite.site5 = ["Hyundai Securities" ,				"http://www.youfirst.co.kr"] ;
	familySite.site6 = ["Hyundai Research Institute" ,		"http://www.hri.co.kr/main/home.htm"] ;

	for (i=1 ; familySite["site"+i] ; i++) {
		familySite.total++ ;
	}

	// family site
	document.write('<div id="" style="position:relative ; z-index:10">') ;

	document.write('<div id="familysite" style="position:absolute ; top:-'+(familySite.total*18+1)+' ; z-index:50 ; display:none">') ;
	document.write('	<table width="180" cellpadding="0" cellspacing="0" border="0" class=table01') ;
	document.write('		style="border:1px solid #D4D4D4 ; cursor:hand">') ;

	for (i=1 ; i<=familySite.total ; i++) {
		document.write('		<tr bgcolor=#FFFFFF onmouseover="javascript:this.style.backgroundColor=0xF6F6F6;familysiteMode=true" onmouseout="javascript:this.style.backgroundColor=0xFFFFFF;familysiteMode=false"') ;
		document.write('			onClick="window.open(\''+familySite["site"+i][1]+'\');familysiteOn();">') ;
		document.write('			<td height=18>&nbsp;'+familySite["site"+i][0]+'</td>') ;
		document.write('		</tr>') ;
	}

	document.write('		<tr bgcolor=#FFFFFF onClick="javascript:familysiteOn(this);">') ;
	document.write('			<td>');
	document.write('				<table width="100%" cellpadding="0" cellspacing="0" border="0" class=table01') ;
	document.write('					style="border-top:1px solid #D4D4D4 ; cursor:hand">') ;
	document.write('					<tr bgcolor=#FFFFFF>') ;
	document.write('						<td height=15 background="/img/common/select_site.gif">&nbsp;</td>') ;
	document.write('						<td width=1><img src="/img/common/select_arrow_search.gif" border="0" align="ABSMIDDLE" vspace=1 hspace=1></td>') ;
	document.write('					</tr>') ;
	document.write('				</table>') ;
	document.write('			</td>') ;
	document.write('		</tr>') ;
	document.write('	</table>') ;
	document.write('</div>') ;

	document.write('<table width="180" cellpadding="0" cellspacing="0" border="0" class=table01') ;
	document.write('	style="border:1px solid #D4D4D4 ; cursor:hand" onClick="javascript:familysiteOn();">') ;
	document.write('	<tr bgcolor=#FFFFFF>') ;
	document.write('		<td height=15 background="/img/common/select_site.gif">&nbsp;</td>') ;
	document.write('		<td width=1><img src="/img/common/select_arrow_search.gif" border="0" align="ABSMIDDLE" vspace=1 hspace=1></td>') ;
	document.write('	</tr>') ;
	document.write('</table>') ;
	document.write('</div>') ;

}

//-->