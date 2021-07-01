<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명  : 협력업체대금지급현황
+ 프로그램 ID: a070022.jsp
+ 기 능 정 의  : 협력업체대금지급현황
+ 작  성   자   : 정 영 식
+ 작 성 일 자  : 2012.09.28
-----------------------------------------------------------------------------
+ 수 정 내 용 : 출력물 소계관련 
+ 수   정  자  : 정영식
+ 수 정 일 자 : 2017.02.24
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a070022_s1
+ PROCEDURE : 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>협력업체대금지급현황</title>

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

var gs_save_gubun="";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) ;
var gs_fdcode = gfdcode;

<%
/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
  
	//지점코드[검색]
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gclx_fdcode.bindcolval="02";

   //gcem_actyymm.text = gs_date2;
	gcem_actyymm.text =fnGetbyymm(gs_date2);
	gcem_actyymm_to.text=fnGetbyymm(gs_date2);
	gcem_paydat_fr.text = gs_date2+"01";
	gcem_paydat_to.text = gs_date;
	
	gcrd_gubun.codevalue="1";
	gcrd_prt_gubun.codevalue="1";
	
	ln_DispChk(0);

 }
 
 <%
 //****************************************************************************
// 전월구하기
//****************************************************************************
%>
function fnGetbyymm(v_yyyymm) {

	var ls_yy = v_yyyymm.substring(0,4);
	var ls_mon = v_yyyymm.substring(4,6);
	var ls_bef_yyyymm="";
	var mm=0;
	
	if (ls_mon == "01") {
		ls_bef_yyyymm = parseInt(ls_yy,10)-1;
		ls_bef_yyyymm = ls_bef_yyyymm+"12";
	}else {
        mm =  parseInt(ls_mon,10)-1;
        if(mm<10){
        	ls_bef_yyyymm = ls_yy+"0"+mm;
        }else{
            ls_bef_yyyymm = ls_yy+mm;
        }
	}
	return(ls_bef_yyyymm);
}	
 


<%
/******************************************************************************
	Description : 조회
	//검색조건
    //저장전 -   지점, 회계년월, 정산일자
    //저장후 -   지점, 회계년월, 지급일자  
******************************************************************************/
%>
function ln_Query(){ 

    
    //필수항목 체크하기 
    //지점 
    if(gclx_fdcode.bindcolval==""){
    	alert("지점을 입력하십시요");
    	return false;
    }
    
    //회계년월
    if(gcem_actyymm.text==""){
    	alert("회계년월을 입력하십시요");
    	return false;
    }
    
    if(gcrd_prt_gubun.codevalue=="1"){   //보고용 
            //gcds_code01.SubsumExpr = "2:ATCODE,1:VENDCD";
          	gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070022_s1"
										     + "?v_str1="+gclx_fdcode.BindColVal     
										 	 + "&v_str2="+gcem_actyymm.text           
											 + "&v_str3="+gcem_paydat_fr.text       
									    	 + "&v_str4="+gcem_paydat_to.text
									    	 + "&v_str5="+gcrd_gubun.codevalue    
          	                                 + "&v_str6="+gcem_actyymm_to.text;    
			// prompt('', gcds_code01.DataID);				
			gcds_code01.Reset();
	}else if (gcrd_prt_gubun.codevalue=="2"){ //제출용
			//gcds_code01.SubsumExpr = "";     
	        gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070022_s2"
										     + "?v_str1="+gclx_fdcode.BindColVal     
										 	 + "&v_str2="+gcem_actyymm.text           
											 + "&v_str3="+gcem_paydat_fr.text       
									    	 + "&v_str4="+gcem_paydat_to.text
									    	 + "&v_str5="+gcrd_gubun.codevalue
	                                         + "&v_str6="+gcem_actyymm_to.text;      
		     // prompt('', gcds_code01.DataID);				
		   gcds_code01.Reset();
	}
}


<%
/******************************************************************************
	Description : 엑셀
******************************************************************************/
%>
function ln_Excel(){

	if(gcrd_prt_gubun.codevalue=="1"){   //보고용 
    	if(gcrd_gubun.codevalue=="1"){ //현금 
    		var strTitle ="협력업체대금지급 ( 보고용 현금 ) ";
    	}else if (gcrd_gubun.codevalue=="2"){ //어음
    	    var strTitle ="협력업체대금지급 ( 보고용 어음 ) ";
    	} 
    	gcgd_disp01.SetExcelTitle(1, "value:"+strTitle+"; font-face:±¼¸²u; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
	    gcgd_disp01.GridToExcel(strTitle,"",1);
	}else if (gcrd_prt_gubun.codevalue=="2"){ //제출용
		if(gcrd_gubun.codevalue=="1"){ //현금 
    		var strTitle ="협력업체대금지급 ( 제출용 현금 ) ";
    	}else if (gcrd_gubun.codevalue=="2"){ //어음
    	    var strTitle ="협력업체대금지급 ( 제출용 어음 ) ";
    	} 
    	gcgd_disp02.SetExcelTitle(1, "value:"+strTitle+"; font-face:±¼¸²u; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:red;line-width:2pt; skiprow:1;");
	    gcgd_disp02.GridToExcel(strTitle,"",1);
	}  
}


<%
/******************************************************************************
	Description : display 적용화면 ....  
******************************************************************************/
%>
function ln_DispChk(index){
   var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index)  {
			eval("document.all."+div_cm[i]+".style.display='block';");	
	  }else{
			eval("document.all."+div_cm[i]+".style.display='none';");		
		}
	}	
}


<%
/******************************************************************************
	Description : 출력  
******************************************************************************/
%>
function ln_Print(){
	
	   var irow=0;
	   
	   _out:
	   for(var k=1;k<=gcds_code01.countrow;k++){
		   
		   if(gcds_code01.namevalue(k,"PAYDAT")!=""){
			   irow = k;
			   break _out;
		   }
	   } 

	  if(gcrd_prt_gubun.codevalue=="1"){   //보고용 

		        if (gcds_master.countrow<1){ 
		           var s_temp = "TITLE:STRING";
					gcds_master.SetDataHeader(s_temp);
				}
				
		        // alert("irow:::"+irow+"::::"+gcds_code01.namevalue(irow,"PAYDAT"));  
		
		        gcds_master.addrow();
		        gcds_master.namevalue(gcds_master.rowposition,"TITLE") = "대금지급명세서 ("
		                                                                                                     +gcds_code01.namevalue(irow,"PAYDAT").substring(0,4)+"."
		                                                                                                     +gcds_code01.namevalue(irow,"PAYDAT").substring(4,6)+"."
		                                                                                                     +gcds_code01.namevalue(irow,"PAYDAT").substring(6,8)+")";
            if(gcrd_gubun.codevalue=="1"){ //현금 		                                                                                                     
				gcrp_print.Preview();
			}else if(gcrd_gubun.codevalue=="2"){//어음
				gcrp_print2.Preview();
			}
		}else{
			//alert("제출용은 출력물이 없습니다. 엑셀을 이용하십시요");
			 if (gcds_master.countrow<1){ 
		         var s_temp = "TITLE:STRING";
			     gcds_master.SetDataHeader(s_temp);
			 }
				
		       gcds_master.addrow();
		        gcds_master.namevalue(gcds_master.rowposition,"TITLE") = "대금지급명세서 ("
		                                                                                                     +gcds_code01.namevalue(irow,"PAYDAT").substring(0,4)+"."
		                                                                                                     +gcds_code01.namevalue(irow,"PAYDAT").substring(4,6)+"."
		                                                                                                     +gcds_code01.namevalue(irow,"PAYDAT").substring(6,8)+")";
            if(gcrd_gubun.codevalue=="1"){ //현금 		                                                                                                     
				gcrp_print3.Preview();
			}else if(gcrd_gubun.codevalue=="2"){//어음
				gcrp_print3.Preview();
			}
		}
	  
}


</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!-- 대금지급 -->
<object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<option value="1:PageSkip,VENDNM"> 
</object>

<!-- 지점 -->
<object  id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id=gcds_master classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id="gctr_code01" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a0900033_t1(I:USER=gcds_code01)">
</OBJECT></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
    if(gcrd_prt_gubun.codevalue=="1"){
    	ft_cnt01.innerText="데이타 조회중입니다.";
    }else if(gcrd_prt_gubun.codevalue=="2"){
	    ft_cnt02.innerText="데이타 조회중입니다.";
	}
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
    var icnt=0;

   	if(gcds_code01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else {
		for(var i=1; i<=row;i++){
			if(gcds_code01.namevalue(i,"GB")=="1"){
				icnt+=1;
			}
		}
	}
  
    if(gcrd_prt_gubun.codevalue=="1"){
	  	ft_cnt01.innerText = "조회건수 : " + icnt + " 건";
	}else if(gcrd_prt_gubun.codevalue=="2"){
	   	ft_cnt02.innerText = "조회건수 : " + row + " 건";
	}
 
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";


</script>


<!-- 지점분류 (검색)-->
<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
   /*
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.index=0;
	*/
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcrd_prt_gubun  event=OnSelChange()>
     
     gcds_code01.ClearAll(); 

	if(gcrd_prt_gubun.codevalue=="1"){
		ln_DispChk(0);
		//gcds_code01.SubsumExpr = "2:ATCODE,1:VENDCD";
		
	}else if(gcrd_prt_gubun.codevalue=="2"){
	    ln_DispChk(1);
	    //gcds_code01.SubsumExpr = "";    
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>   

 </script>


<script language=JavaScript for=gcgd_disp01 event=onKeyPress(keycode)>

    /**
    alert("gcds_code01.Countindex:"+gcds_code01.Countindex);
    alert(gcds_code01.ColumnInex(gcds_code01.Countindex) );

	if(keycode==32) { //스페이스바 
		var row = gcds_code01.rowposition;
		//var colid = gcds_code01.rowposition  
		//ln_CashBill_Sel(row);
	}
	**/
 </script>
 



 
<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_code01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_code01 event=OnFail()>
    alert("Error Code : " + gctr_code01.ErrorCode + "\n" + "Error Message : " + gctr_code01.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td background="../../Common/img/com_t_bg.gif"  align=left ><img src="../img/a070022_head.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
		
		    <img src="../../Common/img/btn/com_b_print.gif"      style="cursor:hand" onclick="ln_Print()">
		    <img src="../../Common/img/btn/com_b_excel.gif"	   style="cursor:hand;" onclick="ln_Excel()"> 
			<img src="../../Common/img/btn/com_b_query.gif"	   style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"  class="tab25" bgcolor="#eeeeee" align=center>지점</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
			 style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID		  value="gcds_fdcode">
				<param name=CBDataColumns	  value="FDCODE, FDNAME">
				<param name=SearchColumn		  value=FDNAME>
				<param name=ListExprFormat	      value="FDNAME^0^120">
				<param name=BindColumn			  value="FDCODE">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center> 회계년월</td>  
	    <td width="240px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object id=gcem_actyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text				value="">
				<param name=Alignment      value=0>
				<param name=Border          value=true>
				<param name=Format           value="YYYY/MM">
				<param name=PromptChar   value="_">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor    value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">~  
		    <comment id="__NSID__">
			<object id=gcem_actyymm_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:3px">		
				<param name=Text				value="">
				<param name=Alignment      value=0>
				<param name=Border          value=true>
				<param name=Format           value="YYYY/MM">
				<param name=PromptChar   value="_">
				<param name=BackColor      value="#CCCCCC">
				<param name=InheritColor    value=false>
				</object>
			</comment><script>__ws__(__NSID__);</script> </nobr>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallMonth('gcem_actyymm_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>지급일자</td> 
		<td class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_paydat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		  value=0>
			<param name=Border	          value=true>
			<param name=Format	          value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat_fr', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">~
			<comment id="__NSID__">
			<OBJECT id=gcem_paydat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
			<param name=Alignment		 value=0>
			<param name=Border	         value=true>
			<param name=Format	         value="YYYY/MM/DD">
			<param name=PromptChar	 value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script>
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_paydat_to', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">
		</td>
	</tr>
	
	<tr> 
		<td width="80px"  class="tab27"  bgcolor="#eeeeee" align=center >지급구분</td>
		<td class="tab28"  colspan=3 >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
					<param name=Cols	    value="2">
					<param name=Format	value="1^현금 ,2^어음">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px;" class="tab28"  bgcolor="#eeeeee" align=center>출력구분</td> 
		<td class="tab28" >&nbsp;
			<comment id="__NSID__">
				<object id=gcrd_prt_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:150">
					<param name=Cols	    value="2">
					<param name=Format	value="1^보고용 ,2^제출용">
				</object>
			</comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
</table>

<table id="div_disp1"  width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			  style="position:relative;left:0px;width:858px; height:440px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	  value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name="Format"		  value=" 			
					<C> Name='GB'			           ID=GB		  HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''   show=false   edit=none   </C>
					<C> Name='순번'			           ID=Currow		      HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none  Value={CurRow}   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} </C>
					<C> Name='구분'			           ID=GUBUN		  HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='계정코드'			   ID=ATCODE		  HeadAlign=Center HeadBgColor=#B9D4DC Width=53 	align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='계정명' 			       ID=ATKORNAM	  HeadAlign=Center HeadBgColor=#B9D4DC Width=83 	align=left        SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} </C>
					<C> Name='거래처'	               ID=VENDCD		  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=center  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='거래처명'			   ID=VENDNM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=130    align=left        SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}  Suppress=1</C>
					<C> Name='지급금액'              ID=JANAMT      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=right	  SumBgColor=#C3D0DB sumtext=''    edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='계산서\\발생일'         ID=TAXDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=69 	align=center   SumBgColor=#C3D0DB sumtext=''    edit=none   MASK='XXXX/XX/XX'  BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} </C>
					<C> Name='지급일자'              ID=PAYDAT		  HeadAlign=Center HeadBgColor=#B9D4DC Width=69	    align=center   SumBgColor=#C3D0DB sumtext=''    MASK='XXXX/XX/XX'      BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}  </C>
					<C> Name='만기일자'		       ID=FULDAT     	  HeadAlign=Center HeadBgColor=#B9D4DC Width=69      align=center   SumBgColor=#C3D0DB sumtext=''    MASK='XXXX/XX/XX'  edit=none  BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} </C>
					<C> Name='적요'	        		  ID=REMARK   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=150    align=left   	  SumBgColor=#C3D0DB sumtext=''     edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='접수일자'			  ID=FSDAT 			  HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center   SumBgColor=#C3D0DB sumtext=''     edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='접수번호'		      ID=FSNBR			  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	    align=center   SumBgColor=#C3D0DB sumtext=''     edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))}</C>
					<C> Name='상태'		    	      ID=FSSTAT           HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   SumBgColor=#C3D0DB sumtext=''     edit=none   BgColor={IF(GB='2','#BEF781',IF(GB='4','#04B404','FFFFFF'))} show=false</C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>

<table id="div_disp2"  width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;display:none">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
			  style="position:relative;left:0px;width:858px; height:440px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		  value="gcds_code01">
					<param name="IndWidth"		  value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		  value="true">
					<param name="Sortview"		  value="false">
					<param name="ColSizing"	  value="true">
					<param name="Editable"		  value="true"> 
					<param name=TitleHeight       value="30">
					<param name=UsingOneClick  value="1">
					<param name=ViewSummary   value="1">
					<param name="Format"		  value=" 			
					<C> Name='LV'			           ID=CurLevel		  HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''    sort=false   edit=none  Value={CurLevel} show=false</C>
					<C> Name='순번'			           ID=Currow		      HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''    sort=false   edit=none  Value={CurRow}   </C>
					<C> Name='구분'			           ID=GUBUN		  HeadAlign=Center HeadBgColor=#B9D4DC Width=28 	align=center  SumBgColor=#C3D0DB sumtext=''    sort=false   edit=none  show=true</C>
					<C> Name='거래처'	               ID=VENDCD		  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	    align=center  SumBgColor=#C3D0DB sumtext=''    sort=true     edit=none   SumTextAlign=center  Value={Decode(CurLevel,2,'',0,VENDCD)} </C>
					<C> Name='거래처명'			   ID=VENDNM		  HeadAlign=Center HeadBgColor=#B9D4DC Width=150    align=left        SumBgColor=#C3D0DB sumtext=''    sort=true    edit=none  Value={Decode(CurLevel,1,'소계',0,VENDNM)}</C>
					<C> Name='지급금액'              ID=JANAMT      	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=right	  SumBgColor=#C3D0DB sumtext='@sum'  sort=true  edit=none </C>
					<C> Name='사업자등록번호'    ID=VENDID  		  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   </C>
					<C> Name='은행\\코드'       ID=BANKCD		  HeadAlign=Center HeadBgColor=#B9D4DC Width=35	    align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none    </C>
					<C> Name='은행명'		          ID=BANNAM    	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left        SumBgColor=#C3D0DB sumtext=''  sort=true   edit=none</C>
					<C> Name='계좌번호'	          ID=ACCTNO   		  HeadAlign=Center HeadBgColor=#B9D4DC Width=143    align=left   	  SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none </C>
					<C> Name='어음계좌예금주'    ID=ACCTNM  		  HeadAlign=Center HeadBgColor=#B9D4DC Width=100    align=left   	  SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none </C>
					<C> Name='어음만기일'		  ID=FULDAT			  HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none  MASK='XXXX/XX/XX' </C>
					<C> Name='담당자'		          ID=EMPNMK   	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45  	align=center   SumBgColor=#C3D0DB sumtext=''   sort=true  edit=none   </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt02 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_master">
	<param name="DetailDataID"			    value="gcds_code01">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"			   	    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"	        value="1:VENDNM"> 
	<PARAM NAME="Format"                    VALUE="
	<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=381 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=995 ,top=98 ,right=1929 ,bottom=376 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1344 ,top=310 ,right=1320 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1580 ,top=312 ,right=1556 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1804 ,top=310 ,right=1781 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1103 ,top=312 ,right=1080 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=304 ,right=1924 ,bottom=304 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=156 ,right=1924 ,bottom=156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1693 ,top=98 ,right=1693 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1463 ,top=98 ,right=1463 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1228 ,top=98 ,right=1228 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='승  인' ,left=1699 ,top=101 ,right=1924 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=1466 ,top=101 ,right=1691 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=1233 ,top=101 ,right=1458 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담  당' ,left=1000 ,top=101 ,right=1225 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=995 ,top=32 ,right=1929 ,bottom=98 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='년     월     일   (  기안 :               )' ,left=1024 ,top=40 ,right=1900 ,bottom=93 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=289 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=778 ,top=201 ,right=778 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Page : #p of #t' ,left=1508 ,top=143 ,right=1929 ,bottom=191 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=45 ,top=201 ,right=45 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='GUBUN', left=180, top=143, right=759, bottom=191, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1931 ,top=201 ,right=1931 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=982 ,top=201 ,right=982 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='구분 :' ,left=48 ,top=143 ,right=172 ,bottom=191 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='발행일' ,left=794 ,top=249 ,right=953 ,bottom=283 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='계산서' ,left=794 ,top=212 ,right=953 ,bottom=246 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='거래처' ,left=50 ,top=222 ,right=513 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=532 ,top=222 ,right=775 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적요' ,left=990 ,top=222 ,right=1913 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='TITLE', left=50, top=45, right=1926, bottom=132, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=288 ,right=1931 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=524 ,top=201 ,right=524 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=201 ,right=1931 ,bottom=201 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=45 ,top=0 ,right=45 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=524 ,top=0 ,right=524 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=778 ,top=0 ,right=778 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=982 ,top=0 ,right=982 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VENDNM', left=56, top=5, right=519, bottom=66, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACTDAT', left=783, top=5, right=971, bottom=66 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=990, top=5, right=1913, bottom=66, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=524 ,top=0 ,right=1929 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='JANAMT', left=529, top=5, right=775, bottom=66, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=0 ,right=524 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=0 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=45 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2788 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1550 ,top=0 ,right=1929 ,bottom=82</I>
</B>

">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object id="gcrp_print2" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_master">
	<param name="DetailDataID"			    value="gcds_code01">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="false">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<param name="SuppressColumns"	        value="1:VENDNM"> 
	<PARAM NAME="Format"                    VALUE="
	
<B>id=FHeader ,left=0,top=0 ,right=2000 ,bottom=381 ,face='Tahoma' ,size=10 ,penwidth=1
	<X>left=995 ,top=98 ,right=1929 ,bottom=376 ,border=true ,penstyle=solid ,penwidth=2</X>
	<L> left=1344 ,top=310 ,right=1320 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1580 ,top=312 ,right=1556 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1804 ,top=310 ,right=1781 ,bottom=365 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1103 ,top=312 ,right=1080 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=304 ,right=1924 ,bottom=304 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=995 ,top=156 ,right=1924 ,bottom=156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1693 ,top=98 ,right=1693 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1463 ,top=98 ,right=1463 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1228 ,top=98 ,right=1228 ,bottom=376 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='승  인' ,left=1699 ,top=101 ,right=1924 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=1466 ,top=101 ,right=1691 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='검  토' ,left=1233 ,top=101 ,right=1458 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담  당' ,left=1000 ,top=101 ,right=1225 ,bottom=153 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<X>left=995 ,top=32 ,right=1929 ,bottom=98 ,border=true ,penstyle=solid ,penwidth=2</X>
	<T>id='년     월     일   (  기안 :               )' ,left=1024 ,top=40 ,right=1900 ,bottom=93 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=294 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='Page : #p of #t' ,left=1508 ,top=143 ,right=1929 ,bottom=191 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='GUBUN', left=180, top=143, right=759, bottom=191, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=204 ,right=1931 ,bottom=204 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='구분 :' ,left=48 ,top=143 ,right=172 ,bottom=191 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=50, top=45, right=1926, bottom=132, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=204 ,right=45 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='거래처' ,left=64 ,top=217 ,right=452 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=487 ,top=217 ,right=725 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적요' ,left=1024 ,top=217 ,right=1918 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=482 ,top=204 ,right=482 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=736 ,top=204 ,right=736 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=878 ,top=204 ,right=878 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1016 ,top=204 ,right=1016 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=204 ,right=1931 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='발행일' ,left=743 ,top=254 ,right=863 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='계산서' ,left=743 ,top=214 ,right=863 ,bottom=251 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='어 음' ,left=889 ,top=214 ,right=1005 ,bottom=251 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='만기일' ,left=889 ,top=254 ,right=1005 ,bottom=291 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=45 ,top=294 ,right=1931 ,bottom=294 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=default ,left=0,top=0 ,right=2000 ,bottom=72 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=45 ,top=0 ,right=45 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=482 ,top=0 ,right=482 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=736 ,top=0 ,right=736 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=878 ,top=0 ,right=878 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1931 ,top=0 ,right=1931 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='JANAMT', left=487, top=5, right=733, bottom=66, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='VENDNM', left=56, top=5, right=479, bottom=66, align='left', supplevel=1, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAXDAT2', left=741, top=5, right=873, bottom=66, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FULDAT2', left=884, top=5, right=1016, bottom=66, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=1024, top=5, right=1918, bottom=66, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=0 ,right=482 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 ,supplevel=1 </L>
	<L> left=1016 ,top=0 ,right=1016 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=484 ,top=0 ,right=1931 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2000 ,bottom=6 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=48 ,top=0 ,right=1934 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Footer ,left=0 ,top=2788 ,right=2000 ,bottom=2870 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=1550 ,top=0 ,right=1929 ,bottom=82</I>
</B>


">
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object id="gcrp_print3" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param name="MasterDataID"			    value="gcds_master">
	<param name="DetailDataID"			    value="gcds_code01">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				    VALUE="true">
    <PARAM NAME="PrintSetupDlgFlag"         VALUE="true">
	<PARAM NAME="PreviewZoom"			    VALUE="100">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"		        VALUE="true">
	<PARAM NAME="PrintMargine"				VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<PARAM NAME="Format"                    VALUE="
	
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=291 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='Page : #p of #t' ,left=2376 ,top=143 ,right=2797 ,bottom=191 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=45 ,top=201 ,right=45 ,bottom=288 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='GUBUN', left=180, top=143, right=759, bottom=191, align='left', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='구분 :' ,left=48 ,top=143 ,right=172 ,bottom=191 ,align='left' ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TITLE', left=50, top=45, right=2802, bottom=132, face='굴림', size=20, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='사업자등록번호' ,left=942 ,top=222 ,right=1217 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='금액' ,left=632 ,top=222 ,right=918 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='거래처' ,left=50 ,top=222 ,right=614 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=45 ,top=204 ,right=2802 ,bottom=204 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=624 ,top=204 ,right=624 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=926 ,top=204 ,right=926 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='은행명' ,left=1233 ,top=222 ,right=1601 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1609 ,top=204 ,right=1609 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1937 ,top=204 ,right=1937 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2320 ,top=204 ,right=2320 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계좌번호' ,left=1625 ,top=222 ,right=1921 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2596 ,top=204 ,right=2596 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1222 ,top=204 ,right=1222 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2802 ,top=204 ,right=2802 ,bottom=291 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='어음만기일' ,left=2334 ,top=222 ,right=2585 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='담당자' ,left=2604 ,top=222 ,right=2786 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='어음계좌예금주' ,left=1958 ,top=222 ,right=2302 ,bottom=278 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=74 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=45 ,top=0 ,right=45 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2802 ,top=0 ,right=2802 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VENDID', left=942, top=5, right=1217, bottom=66, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JANAMT', left=632, top=5, right=918, bottom=66, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=624 ,top=0 ,right=624 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='VENDNM', left=50, top=5, right=614, bottom=66, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=45 ,top=0 ,right=2802 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=74 ,right=2802 ,bottom=74 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=926 ,top=0 ,right=926 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='BANNAM', left=1233, top=5, right=1598, bottom=66, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCTNO', left=1625, top=5, right=1921, bottom=66, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FULDAT', left=2334, top=8, right=2585, bottom=69 ,mask='XXXX-XX-XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1937 ,top=0 ,right=1937 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1609 ,top=0 ,right=1609 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=1222 ,top=0 ,right=1222 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='EMPNMK', left=2604, top=8, right=2786, bottom=69, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2596 ,top=0 ,right=2596 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2320 ,top=0 ,right=2320 ,bottom=71 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='ACCTNM', left=1958, top=8, right=2302, bottom=69, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=90 ,face='Tahoma' ,size=10 ,penwidth=1
	<L> left=45 ,top=87 ,right=2802 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=45 ,top=0 ,right=45 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=624 ,top=0 ,right=624 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=926 ,top=0 ,right=926 ,bottom=87 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2802 ,top=3 ,right=2802 ,bottom=90 ,penwidth=0 ,pencolor=#000000 </L>
	<T>id='합       계' ,left=56 ,top=21 ,right=614 ,bottom=69 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<S>id='{Sum(JANAMT)}' ,left=632 ,top=8 ,right=918 ,bottom=74 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</S>
</B>
<B>id=Footer ,left=0 ,top=1918 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../Common/img/icon.jpg' ,left=2429 ,top=0 ,right=2807 ,bottom=82</I>
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 