<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	 결산관리 - 마감처리
+ 프로그램 ID	:   A040030.html
+ 최 초 이 력	:   하민숙
+ 기 능 정 의	:   실행,조회
+ 변 경 이 력	: 
+ 서 블 릿 명	:   a040030_s1,a040030_s2, a040030_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title></title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();	//선조회

	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	gcds_dept.Reset();
  
	if(gclx_sfdcode.Enable==true){
    	gclx_sfdcode.BindColVal = gs_fdcode;	
  	}
  	OutputYM();   
  	ln_Query();
}
/******************************************************************************
	Description : 월,일
******************************************************************************/
	// 오늘을 구한다. 
	var today = new Date();
	var yyyyStr, mmStr, ddStr;
	var dateOfWeek;

  var	yyyy = today.getYear();	

  var	mm = today.getMonth()+1;

  var	dd = today.getDate();
  var	ddT = dd;

	ToStrYMD();

	// 날짜 숫자형을 문자형으로 바꾸기
	function ToStrYMD(){
	//yyyyStr = yyyy.toString();
    
	//	mmStr = mm.toString();
	//	ddStr = dd.toString();
	//if ( mmStr.length ==1 ){ mmStr="0"+mmStr; }
	//if ( ddStr.length == 1 ){ ddStr="0"+ddStr; }
	}
	
	// 날짜 문자형을 숫자형으로 바꾸기
	function ToIntYMD(){
		if ( yyyyStr!="" && !isNaN(yyyyStr )) { yyyy = parseInt(yyyyStr); }
		if ( mmStr!="" && !isNaN(mmStr )) { mm = parseInt(mmStr); }
		dd = parseInt(ddStr);
	}
	// 연도와 월을 출력한다. 년도, 월의 증감을 있게 한다. 

	function OutputYM() {
		txt_year.value=yyyy.toString(); 
	
		sel_month.value=mm.toString(); 

		ky.value =txt_year.value;
              //alert(ky.value);

		sel_month.options[mm-1].seleted=true;

		//alert("OutputYM: mmStr="+sel_month.value);
		PrintCalendar();  
		//window.focus();
	}	

	function InputYM() {
		yyyy = parseInt(txt_year.value);
		mm = parseInt(sel_month.value);	
	//	alert("InputYM : mmStr="+mm);
	}
	

	function YearAdd(val) {
		ResetYM();
		yyyy += val;
		ToStrYMD();
		OutputYM();
	}
	
	function ResetYM() {
		InputYM();	
		ToIntYMD();
		ToStrYMD();	
		OutputYM();	
		 
	}
   
	// 선택된 연월을 기준으로 날짜를 출력한다. 
	function PrintCalendar(){
		// 첫째 날짜의 요일값을 가져온다. 
		var firstDay1 = new Date(yyyy, mm-1, 1);	              //이번달 1일에 대해
		var firstDay2;																					// 다음달 1일에 대해 
		var dayCnt = 28; 
		if (mm==12) { firstDay2 = new Date(yyyy+1, 0, 1); } else { firstDay2 = new Date(yyyy, mm, 1); } 

		// 해당 월의 날짜 수를 구한다. 
		var dateOfWeek1 = firstDay1.getDay(); 
		var dateOfWeek2 = firstDay2.getDay(); 
		var gap = dateOfWeek2 - dateOfWeek1; 
		if ( gap >= 0) { dayCnt+=gap } else { dayCnt+=gap+7; }


		//ftA.innerText = dateOfWeek1 + " / " + dateOfWeek2 + " / " + dayCnt;

		// 출력한다. 
		var eachDay = new Array(43);
   
		var Cnt=0;
		var todayColor="";
		var mOutCheck="";		

	//alert(ddT);

		for (var i=1; i<=42; i++) { 
			if ( i >= dateOfWeek1+1 && i <= (dayCnt+dateOfWeek1) ) { // 해당일이 나타나야 할 경우
				Cnt++; 
				if ( Cnt == ddT ) { mOutCheck=", 1"; } else { todayColor=""; mOutCheck=""; }
				eachDay[i] = "<td >"+Cnt.toString()+"</td>"

			//	alert(Cnt.toString());		
		      var  a = Cnt.toString();   
		      hy.value = a;
		   }
		}		

		var a=""+ "<table border= 0 cellpadding=0 cellspacing=0 >";
				//	+ "	<tr>" 
				
				//	+ "	</tr>";

		// dateOfWeek1, dayCnt 에 유의
		for ( var i=0; i<6; i++ ) { 
				a+="	<tr align='center' height='20px'>";
				//alert(data);
		for (var k=1; k<=7; k++ ) { a+=eachDay[i*7+k]; }
			//	data+="	</tr>";
	   //alert(eachDay);
		}
  // if(eachDay >= a) 
	//	a += "</table>";	
				a = null;  
  
	}
	function keyCheck(){		if (event.keyCode == 13) { window.focus(); 
				
		}
	}


/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){   

  
	var str1 = gclx_sfdcode.BindColVal;	        //지점코드	
	var str2 = ky.value;
	var str3 = sel_month.value;		

	if(str1=="")   str1 = gs_fdcode;	 	
  	else  str1 = gclx_sfdcode.BindColVal;	   


	 gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040030_s1?v_str1="+str1
																		+ "&v_str2="+str2
																		+ "&v_str3="+str3;	
																	
	gcds_data.Reset(); 		


	 gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040030_s2?v_str1="+str1
																		+ "&v_str2="+str2
																		+ "&v_str3="+str3;	
																											
//   prompt("",gcds_data.DataID);
		gcds_data2.Reset(); 	

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 

	//gclx_sfdcode.BindColVal = "01";					//지점코드
	txt_year.text	 = gs_date2;				           //년도

	gcds_sfdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset(); 
  
}

function default_search(){

	var str1 = gclx_sfdcode.BindColVal;	        //지점코드
	var str2 = ky.value;
	//var str2 = txt_year.text;	                       //기준년도	
	var str3 = sel_month.value;					        //월
    var lag = hy.value;
    var yea=(txt_year.text).substring(0,4);  
	for(var i=1;i<=lag;i++){     
	    var WORKCLOSE = "F";	 
	    var SLPCLOSE  = "F";
	    var ACTCLOSE  = "F";	
	    var BGTCLOSE = "F";
		var IsUpdated = "1";
		gctr_data.KeyValue  = "Account.a040030_t1(I:USER=gcds_data)";
	 	gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040030_t1?";		
		gctr_data.Parameters ="v_str1="+gclx_sfdcode.BindColVal+ ",v_str2="+ ky.value+	",v_str3="+sel_month.value+ ",v_str4="+Number(i)+",v_str5="+WORKCLOSE+",v_str6="+SLPCLOSE + ",v_str7="+ACTCLOSE+",v_str8="+IsUpdated+",v_str9="+BGTCLOSE;	
		gctr_data.post();		 
	} //for
}
/******************************************************************************
	Description : 
******************************************************************************/
function allclear(){

for (var k=1; k<=gcds_data.countrow;k++) {

gcds_data.namevalue(k,"WORKCLOSE")= 'F';
gcds_data.namevalue(k,"SLPCLOSE")= 'F';
gcds_data.namevalue(k,"ACTCLOSE")= 'F';
gcds_data.namevalue(k,"BGTCLOSE")= 'F';
}

for (var k=1; k<=gcds_data2.countrow;k++) {

gcds_data2.namevalue(k,"WORKCLOSE")= 'F';
gcds_data2.namevalue(k,"SLPCLOSE")= 'F';
gcds_data2.namevalue(k,"ACTCLOSE")= 'F';
gcds_data2.namevalue(k,"BGTCLOSE")= 'F';
}


}
/******************************************************************************
	Description : 실행
******************************************************************************/
function ln_Execute(){

   var DAY  =  0;	
   var WORKCLOSE  =  "";
   var SLPCLOSE  =  "";
   var ACTCLOSE  =  "";
   var BGTCLOSE  =  "";
   var IsUpdated = "";

   for (var k=1; k<=gcds_data.countrow;k++) {

	   DAY  =  gcds_data.namevalue(k,"DAY");	
	   WORKCLOSE  =  gcds_data.namevalue(k,"WORKCLOSE");
	   SLPCLOSE  =  gcds_data.namevalue(k,"SLPCLOSE");
	   ACTCLOSE  =  gcds_data.namevalue(k,"ACTCLOSE");
	   BGTCLOSE  =  gcds_data.namevalue(k,"BGTCLOSE");


	   IsUpdated = "2";
  
	   if (WORKCLOSE =="F" && SLPCLOSE =="T"){
      		alert(DAY+"일 현업전표마감이 되지않았습니다");  return;
	   }
	   if (SLPCLOSE =="F" && ACTCLOSE =="T"){
     		alert(DAY+"일 전표마감이 되지않았습니다");  return;
	   }

	   	 gctr_data.KeyValue  = "Account.a040030_t1(I:USER=gcds_data)";
		 gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040030_t1?";		
		 gctr_data.Parameters ="v_str1="+gclx_sfdcode.BindColVal+ ",v_str2="+ky.value+	",v_str3="+sel_month.value+ ",v_str4="+Number(DAY)+",v_str5="+WORKCLOSE+",v_str6="+SLPCLOSE + ",v_str7="+ACTCLOSE+",v_str8="+IsUpdated+",v_str9="+BGTCLOSE;	
		 gctr_data.post();	 			
     
	 }


	for (var k=1; k<=gcds_data2.countrow;k++) {
	
	   	DAY  =  gcds_data2.namevalue(k,"DAY");	
	   	WORKCLOSE  =  gcds_data2.namevalue(k,"WORKCLOSE");
	   	SLPCLOSE  =  gcds_data2.namevalue(k,"SLPCLOSE");
	   	ACTCLOSE  =  gcds_data2.namevalue(k,"ACTCLOSE");
	   	BGTCLOSE  =  gcds_data2.namevalue(k,"BGTCLOSE");
		IsUpdated = "2";
	  
		if (WORKCLOSE =="F" && SLPCLOSE =="T"){
	    	alert(DAY+"일 현업전표마감이 되지않았습니다");  return;
		}
		if (SLPCLOSE =="F" && ACTCLOSE =="T"){
	    	alert(DAY+"일 전표마감이 되지않았습니다");  return;
		}
	   	
	
		gctr_data.KeyValue  = "Account.a040030_t1(I:USER=gcds_data)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040030_t1?";		
		gctr_data.Parameters ="v_str1="+gclx_sfdcode.BindColVal+ ",v_str2="+ky.value+	",v_str3="+sel_month.value+ ",v_str4="+Number(DAY)+",v_str5="+WORKCLOSE+",v_str6="+SLPCLOSE + ",v_str7="+ACTCLOSE+",v_str8="+IsUpdated+",v_str9="+BGTCLOSE;	
		  // prompt("",gcds_data.text); 
		gctr_data.post();	 				

	 }

	 ln_Query();  
} 

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<param name="KeyName"			value="toinb_dataid4">
	<PARAM NAME="KeyValue"    VALUE="a040030_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";	
</script>


<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("에러가 발생 했습니다.");
	window.status="조회가 완료 되었습니다.";
  document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

if( row < 1){
  //alert("검색된 데이타가 없습니다.");  
default_search();
ln_Query();
}
//	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
//	window.status = " 조회가 완료 되었습니다.";	
</script>

<script language="javascript" for="gctr_data" event="onsuccess()">
//alert("요청하신 작업을 성공적으로 수행하였습니다.");
//ln_Query(); 
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert(gctr_data.ErrorMsg);
</script>

<script language=JavaScript for=gcgd_data  event=OnLButtonDblClk(row,colid,xpos,ypos)>
  if(colid=="WORKCLOSE"){
    if(gcds_data.namevalue(0,"WORKCLOSE")=='F'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"WORKCLOSE")= 'T';
      }
      gcds_data.namevalue(0,"WORKCLOSE")= 'T';
    }else if(gcds_data.namevalue(0,"WORKCLOSE")=='T'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"WORKCLOSE")= 'F';
      }
      gcds_data.namevalue(0,"WORKCLOSE")= 'F';
    }
  }else if(colid=="SLPCLOSE"){
    if(gcds_data.namevalue(0,"SLPCLOSE")=='F'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"SLPCLOSE")= 'T';
      }
      gcds_data.namevalue(0,"SLPCLOSE")= 'T';
    }else if(gcds_data.namevalue(0,"SLPCLOSE")=='T'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"SLPCLOSE")= 'F';
      }
      gcds_data.namevalue(0,"SLPCLOSE")= 'F';
    }
  }else if(colid=="ACTCLOSE"){
    if(gcds_data.namevalue(0,"ACTCLOSE")=='F'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"ACTCLOSE")= 'T';
      }
      gcds_data.namevalue(0,"ACTCLOSE")= 'T';
    }else if(gcds_data.namevalue(0,"ACTCLOSE")=='T'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"ACTCLOSE")= 'F';
      }
      gcds_data.namevalue(0,"ACTCLOSE")= 'F';
    }
  }else if(colid=="BGTCLOSE"){
    if(gcds_data.namevalue(0,"BGTCLOSE")=='F'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"BGTCLOSE")= 'T';
      }
      gcds_data.namevalue(0,"BGTCLOSE")= 'T';
    }else if(gcds_data.namevalue(0,"BGTCLOSE")=='T'){
      for (var k=1; k<=gcds_data.countrow;k++){
        gcds_data.namevalue(k,"BGTCLOSE")= 'F';
      }
      gcds_data.namevalue(0,"BGTCLOSE")= 'F';
    }
  }

  if(colid=="WORKCLOSE"){
    if(gcds_data2.namevalue(0,"WORKCLOSE")=='F'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"WORKCLOSE")= 'T';
      }
      gcds_data2.namevalue(0,"WORKCLOSE")= 'T';
    }else if(gcds_data2.namevalue(0,"WORKCLOSE")=='T'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"WORKCLOSE")= 'F';
      }
      gcds_data2.namevalue(0,"WORKCLOSE")= 'F';
    }
  }else if(colid=="SLPCLOSE"){
    if(gcds_data2.namevalue(0,"SLPCLOSE")=='F'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"SLPCLOSE")= 'T';
      }
      gcds_data2.namevalue(0,"SLPCLOSE")= 'T';
    }else if(gcds_data2.namevalue(0,"SLPCLOSE")=='T'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"SLPCLOSE")= 'F';
      }
      gcds_data2.namevalue(0,"SLPCLOSE")= 'F';
    }
  }else if(colid=="ACTCLOSE"){
    if(gcds_data2.namevalue(0,"ACTCLOSE")=='F'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"ACTCLOSE")= 'T';
      }
      gcds_data2.namevalue(0,"ACTCLOSE")= 'T';
    }else if(gcds_data2.namevalue(0,"ACTCLOSE")=='T'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"ACTCLOSE")= 'F';
      }
      gcds_data2.namevalue(0,"ACTCLOSE")= 'F';
    }
  }else if(colid=="BGTCLOSE"){
    if(gcds_data2.namevalue(0,"BGTCLOSE")=='F'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"BGTCLOSE")= 'T';
      }
      gcds_data2.namevalue(0,"BGTCLOSE")= 'T';
    }else if(gcds_data2.namevalue(0,"BGTCLOSE")=='T'){
      for (var k=1; k<=gcds_data2.countrow;k++){
        gcds_data2.namevalue(k,"BGTCLOSE")= 'F';
      }
      gcds_data2.namevalue(0,"BGTCLOSE")= 'F';
    }
  }


</script>

<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	if(gs_userid=="ACCOUNT"){
		gclx_sfdcode.index=2;
	}else{
		gclx_sfdcode.bindcolval=gs_fdcode;
	}
</script>

</HEAD>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;" >
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/a040030_head.gif"></td>
    <td align="right" style="padding-top:10px;" background="../../Common/img/com_t_bg.gif">&nbsp;&nbsp;
		<img src="../../Common/img/btn/com_b_execute.gif" style="cursor:hand" onclick="ln_Execute()">
			<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
  <tr> 
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
         <td width="70px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;지점코드&nbsp;</nobr></td>
					<td width="100px;" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:0px;width:90px;height:110px;">
							<param name=ComboDataID			value="gcds_sfdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				      value=false>
							<param name=ListExprFormat		value="FDNAME^0^70">
							<param name=BindColumn			value="FDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>  	
					<td width="60px" class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;년도&nbsp;</nobr></td>
      <td>
			<input type="text" name="txt_year" style="position:relative;top:0px;width:35px;border:0" onFocus="this.select();" onKeyup="keyCheck();" onBlur="ResetYM();" disabled>년 
			<img src="../img/com_b_left.gif"  style="position:relative;top:3px;cursor:hand;border:0" onclick="YearAdd(-1);">
			<img src="../img/com_b_right.gif" style="position:relative;top:3px;cursor:hand;border:0" onclick="YearAdd(1);">
			<select name="sel_month" class="selCal" style="position:relative;top:1px;width:44px;border:1 solid #708090" onChange="ResetYM();">
				<option value='1'>01</option>
				<option value='2'>02</option>
				<option value='3'>03</option>
				<option value='4'>04</option>
				<option value='5'>05</option>
				<option value='6'>06</option>
				<option value='7'>07</option>
				<option value='8'>08</option>
				<option value='9'>09</option>
				<option value='10'>10</option>
				<option value='11'>11</option>
				<option value='12'>12</option>
			</select>월
		   </td>
					<td>					
			<img name="btn_clear" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:95px;cursor:hand"	 onclick="allclear()"></td>
				</tr>
</table>	

<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:1px;width:200px;height:300px;font-size:9pt;background-color:#ffffff;
BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
<!------------------------------------------------------------------------------------------------------->
<tr> <td height=3  border="0"> </td> </tr>
  <tr> 
    <td colspan="2" align=LEFT valign=center style="padding-left:0px;"> 
      <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td style="width:100%;" align=LEFT>
           <div id=gcgd_reresult style="display:block;">
           <table width="876" cellpadding="0" cellspacing="0" border="0">
             <tr> 
                <td>
								<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data  style="WIDTH:434px;HEIGHT:320px;border:1 solid #777777;">
									<PARAM NAME="DataID"			 VALUE="gcds_data">
									<PARAM NAME="Editable"        VALUE="True">
									<PARAM NAME="BorderStyle"   VALUE="0">
									<param name="Fillarea"		     VALUE="true">
									<param name=ColSizing          value="true">
									<param name="IndWidth"       value="0">
									<param name="HiddenHScroll"  value="true">
									<param name="HiddenVScroll"  value="true">
									<PARAM NAME="Format"		      VALUE="  
									<C> Name='일'  ID=DAY HeadAlign=Center HeadBgColor=#B9D4DC Width=29  align=center </C>						
										<C> Name='현업전표마감'  ID=WORKCLOSE  HeadAlign=Center HeadBgColor=#B9D4DC Width=100   EditStyle=CheckBox   align=center EditStyle=none</C>
										<C> Name='전표마감'  ID=SLPCLOSE   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center   EditStyle=CheckBox EditStyle=none</C>											
										<C> Name='장부마감'  ID=ACTCLOSE   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center  EditStyle=CheckBox EditStyle=none</C>
										<C> Name='예산마감'  ID=BGTCLOSE   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center  EditStyle=CheckBox EditStyle=none</C>
				
									">
								 </object></comment><script>__ws__(__NSID__);</script> 

					<table border= "0" cellpadding=0 cellspacing=0 style='position:relative;left:0px;top:8px;width:435px;height:50px;font-size:9pt;background-color:#ffffff;
						BORDER-LEFT-WIDTH:0px;border:1 solid #708090'>
							<tr>	<td width="200" align="right">	
								<INPUT TYPE="button" NAME="button1" VALUE="손익계정자동분개" onClick="calc(this.form);"></td> 
						  	<td width="200px;" align="left"><input type="checkbox" id=txt_chk1 ></td>		
							</tr>	
							<tr>			<td width="200" align="right">		
									<INPUT TYPE="button" NAME="button2" VALUE="년마감및잔액이월" onClick="calc(this.form);"> </td>
						  	<td width="200px;" align="left"><input type="checkbox" id=txt_chk2></td>													
							</tr>							
					  </table> 

                </td>

            	<td>&nbsp;
							<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH:434px;HEIGHT:340px;border:1 solid #777777;">
									<PARAM NAME="DataID"			 VALUE="gcds_data2">
									<PARAM NAME="Editable"        VALUE="True">
									<PARAM NAME="BorderStyle"    VALUE="0">
									<param name="Fillarea"		     VALUE="true">
									<param name=ColSizing          value="true">
									<param name="IndWidth"        value="0">
									<param name="HiddenHScroll"  value="true">
									<param name="HiddenVScroll"  value="true">
									<PARAM NAME="Format"		     VALUE="  
									  <C> Name='일' ID= DAY 	HeadAlign=Center HeadBgColor=#B9D4DC Width=29  align=center  </C>
										<C> Name='현업전표마감'   ID=WORKCLOSE  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center   EditStyle=CheckBox</C>
										<C> Name='전표마감'  ID=SLPCLOSE   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center   EditStyle=CheckBox</C>
										<C> Name='장부마감'  ID=ACTCLOSE   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center   EditStyle=CheckBox</C>
										<C> Name='예산마감'  ID=BGTCLOSE   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center  EditStyle=CheckBox </C>
									">
								 </object></comment><script>__ws__(__NSID__);</script> 
							<table border= "0" cellpadding=0 cellspacing=0 style='position:relative;left:0px;top:8px;width:436px;height:26px;font-size:9pt;background-color:#ffffff;
						BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
							<tr><td></td> <td ></td></tr>	<tr><td>	 </td><td></td>			
							</tr>							
					  </table> 
                </td><td>
</table>
  </td>
	<!------------------------------------------------------------------------------------------------------------------>
<input id="hy" name="hy"	type="hidden"  >
<input id="ky" name="ky"	type="hidden"  >

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
