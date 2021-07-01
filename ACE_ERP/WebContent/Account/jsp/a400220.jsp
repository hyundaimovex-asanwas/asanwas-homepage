<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  입금관리 - 입금데이터 업로드 
+ 프로그램 ID	:  a400220.jsp
+ 기 능 정 의	:  은행 예금 파일을 업로드 함.  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2016.10.20
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
-----------------------------------------------------------------------------
+ 변 경 이 력	:  2016.11.29 JYS 
+ 변 경 내 용	:  원가코드 추가
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>입금데이터 업로드</title>

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
var gs_date2  = gcurdate.substring(0,4);
var gs_date3  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;		//user_id
var gs_fdcode = gfdcode;	//지점코드

var gs_frdt="";
var gs_todt="";
var gs_hf_gb="";  //반기구분
var gs_hf_seq=""; //반기내순번

var gs_upload_gb="";


<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
	
	gcem_enddat_fr.text = gs_date;
	gcem_enddat_to.text = gs_date;
}

<%
/******************************************************************************
	Description : 선조회
******************************************************************************/
%>
function ln_Before(){
	gcds_acctinfo.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400010_s1?v_str1=&v_str2=&v_str3=&v_str4=&v_str5=T";                           
	gcds_acctinfo.Reset();
}

<%
/******************************************************************************
	Description : 엑셀 적용 버튼 작업시 엑셀Data ==> Grid로 업로드 함               
******************************************************************************/
%>
function ln_Excel_Apply(){
		
  	var s_temp = "";
  	
  	gs_upload_gb="1";

    //excel_upload ( grid와 연동 )
	gcds_excel.clearAll(); 
	gcds_excel_grid.clearAll();

    //dataSet head 만들기
    //파일경로
	s_temp = "EXCEL_INFO:STRING(255),EXCEL_URL:URL";
	gcds_excel.SetDataHeader(s_temp);

	gcds_excel.addrow();
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_INFO") = file_path.value;
	gcds_excel.namevalue(gcds_excel.rowposition, "EXCEL_URL")  = file_path.value;

	gctr_data_excel.KeyValue = "excel_upload_a400020_t1(I:USER=gcds_excel,O:USER2=gcds_excel_grid)";
	//gctr_data_excel.Action = g_servlet+"/Account.excel_upload_t2?";
	gctr_data_excel.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>excel_upload_a400020_t1?";
	gctr_data_excel.post();
	
}

<%
/******************************************************************************
	Description : 저장
******************************************************************************/
%>
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_excel_grid.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
			gctr_data.KeyValue = "Account.a400020_t2(I:USER=gcds_excel_grid)";
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400020_t2?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_excel_grid.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}	


<%
/******************************************************************************
	Description : 저장시 체크
******************************************************************************/
%>
function ln_Chk_Save() {
	
    //필수항목 체크 
	for(i=1;i<=gcds_excel_grid.countrow;i++){
		if(gcds_excel_grid.namevalue(i,"ACCTNO") == ""){ 			
			alert("계좌번호를 입력하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"ACCTCD") == ""){
			alert("계좌코드를 확인하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"DEALDT") == ""){ 				
			alert("거래일시를 확인하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"CURUNIT") == ""){ 				
			alert("통화를 확인하세요.");
			return false;
		}
		
		if(gcds_excel_grid.namevalue(i,"CURUNIT") != "WON"){ 				
			if(gcds_excel_grid.namevalue(i,"EXRATE")==0){
				alert("환율을 입력하십시요.");
				return false;
			}
		}
	} 
	
	return true;
}

<%
/******************************************************************************************
	Description : 예금정보 업로드 생성
*****************************************************************************************/
%>
function ln_Create(){
	
	if(gcds_excel_grid.IsUpdated) {	
		if (confirm("예금정보를 업로드 하시겠습니까?")){	
			
			gctr_data.KeyValue = "Account.a400020_t1(I:USER=gcds_excel_grid)";
			
			gctr_data.Action   = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400020_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('gcds_excel_grid',gcds_excel_grid.text);
			gctr_data.post();
		}
	}else{
		alert("생성하실 정보가 없습니다.");
	}
    
}


<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
	//data Recode 
    gcds_excel_grid.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400020_s1?v_str1="+gcem_acctcd.text
    		                                                                  +"&v_str2="+gcem_acctno.text
    		                                                                  +"&v_str3="+gcem_enddat_fr.text
    		                                                                  +"&v_str4="+gcem_enddat_to.text
    		                                                                  +"&v_str5="+txt_remark.value;	
	gcds_excel_grid.Reset();
}



<%
/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
%>
function ln_Delete(){

}

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
 
}


/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/





<%
/******************************************************************************
	Description : 엑셀 다운로드
******************************************************************************/
%>
function ln_Excel(){

	gcgd_disp01.GridToExcel("예금업로드","",2);
}



<%
/******************************************************************************
Description : 계좌정보팝업
******************************************************************************/
%>
function ln_Popup_Acctinfo(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./acctinfo_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcem_acctcd.text = arrResult[0];  // 계좌코드 
		gcem_acctno.text = arrResult[1];  // 계좌번호
	}else{
		gcem_acctcd.text = "";
		gcem_acctno.text = "";
	}
}


<%
/******************************************************************************
Description : 업로드시점에 그리드 데이터 제어 
******************************************************************************/
%>
function fn_Acctcd_fix(){
	
	for(var j=1;j<=gcds_excel_grid.countrow;j++){
		for(var i=1;i<=gcds_acctinfo.countrow;i++){
			//계좌번호로 계좌코드 찾기
			if(gcds_acctinfo.namevalue(i,"ACCTNO")==gcds_excel_grid.namevalue(j,"ACCTNO")){
				gcds_excel_grid.namevalue(j,"ACCTCD")    = gcds_acctinfo.namevalue(i,"ACCTCD");
				gcds_excel_grid.namevalue(j,"RESULT")    = gcds_acctinfo.namevalue(i,"RESULT");
				gcds_excel_grid.namevalue(j,"RSTREMARK") = gcds_acctinfo.namevalue(i,"RSTREMARK");
				gcds_excel_grid.namevalue(j,"RSTSEQ")    = gcds_acctinfo.namevalue(i,"RSTSEQ");
				gcds_excel_grid.namevalue(j,"TEAM")      = gcds_acctinfo.namevalue(i,"TEAM");
				gcds_excel_grid.namevalue(j,"INRATE")    = gcds_acctinfo.namevalue(i,"INRATE");
				gcds_excel_grid.namevalue(j,"COSTCD")    = gcds_acctinfo.namevalue(i,"COSTCD");
				gcds_excel_grid.namevalue(j,"COSTNM")    = gcds_acctinfo.namevalue(i,"COSTNM");
				
			}	
		}
		
		//외화 처리
	
			if(gcds_excel_grid.namevalue(j,"CURUNIT")!="WON"){
				
				gcds_excel_grid.namevalue(j,"FINAMT") =gcds_excel_grid.namevalue(j,"INAMT");
				gcds_excel_grid.namevalue(j,"FOUTAMT")=gcds_excel_grid.namevalue(j,"OUTAMT");
				gcds_excel_grid.namevalue(j,"FBALAMT")=gcds_excel_grid.namevalue(j,"BALAMT");
				gcds_excel_grid.namevalue(j,"INAMT")=0;
				gcds_excel_grid.namevalue(j,"OUTAMT")=0;
				gcds_excel_grid.namevalue(j,"BALAMT")=0;
			}
		
		//거래일자 거래시간		
		gcds_excel_grid.namevalue(j,"DEDATE") = gcds_excel_grid.namevalue(j,"DEALDT").substring(0,10).replace(/-/gi,"");     
		gcds_excel_grid.namevalue(j,"DETIME") = gcds_excel_grid.namevalue(j,"DEALDT").substring(11,20).replace(/:/gi,"");
	}
	
	gs_upload_gb="";
}


<%
/******************************************************************************
Description : 환율적용시 해당계좌에 따른 잔액 적용 
******************************************************************************/
%>
function ln_Balamt_Sum(strAcctno,intBalamt2){
	
	alert("strAcctno::"+strAcctno+"::intBalamt2::"+intBalamt2);
	
	if(intBalamt2==undefined)intBalamt2=0;
	
	for(var i=1; i<=gcds_excel_grid.countrow; i++){
		if(strAcctno == gcds_excel_grid.namevalue(i,"ACCTNO")){

			gcds_excel_grid.namevalue(i,"BALAMT") = intBalamt2 +  gcds_excel_grid.namevalue(i,"INAMT")-gcds_excel_grid.namevalue(i,"OUTAMT");
			
			intBalamt2 = gcds_excel_grid.namevalue(i,"BALAMT");
		}
	}
}


<%
/******************************************************************************
Description : 원가
******************************************************************************/
%>
function ln_Popup_Cost(strrow){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] ="0030";
	arrParam[1] = "";
	arrParam[2]="";
	arrParam[3]="";
	arrParam[4]="02";

	//2007.10.08.회계일자 추가(부서 CHGYM 관련)
	//var stractdat = gcem_actdat02.text;
	arrParam[5]="201610";
	
    strURL = "./commdtil_cost_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    result = showModalDialog(strURL,arrParam,strPos);
    
    if (result != null) {
		arrResult = result.split(";");
		gcds_excel_grid.namevalue(strrow,"COSTCD")=arrResult[0];
		gcds_excel_grid.namevalue(strrow,"COSTNM") =arrResult[1];
	}else{
		gcds_excel_grid.namevalue(strrow,"COSTCD")="";
		gcds_excel_grid.namevalue(strrow,"COSTNM")="";
	}
}



</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">


<!--엑셀 -->
<object  id=gcds_excel classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--엑셀업로드 후 그리드 DATA -->
<object  id=gcds_excel_grid classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--계좌코드 정보 -->
<object  id=gcds_acctinfo classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--그리드 Data를 Table에 insert Tail -->
<object  id=gcds_tail_b classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gctr_data_excel classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language="javascript" for="gcds_head_a" event="onloadCompleted(row,colid)">
	//alert("gcds_head_a:row:"+row);
</script>

<script language="javascript" for="gcds_tail_b" event="onloadCompleted(row,colid)">
	//alert("gcds_tail_b:row:"+row);
</script>

<script language="javascript" for="gcds_excel_grid" event="onloadCompleted(row,colid)">
	//alert("gcds_excel_grid:row:"+row);
	if(gs_upload_gb=="1"){
		fn_Acctcd_fix();
	}
	
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcip_file" event=OnClick()>
	if (fn_trim(gcip_file.value)!="") {		
		file_path.value = gcip_file.value;
	}
</script>


<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>

	if(row>0){ 
		if(colid=="EXRATE"){
			if(gcds_excel_grid.namevalue(row,"CURUNIT")!="WON"){
				gcgd_disp01.ColumnProp("EXRATE","Edit")="";
			}else{
				gcgd_disp01.ColumnProp("EXRATE","Edit")="none";
			}
		}
	}

</script>


<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
    
	if(row>0){
		if(colid=="EXRATE"){
			gcds_excel_grid.namevalue(row,"INAMT")  = gcds_excel_grid.namevalue(row,"FINAMT")*gcds_excel_grid.namevalue(row,"EXRATE");
			gcds_excel_grid.namevalue(row,"OUTAMT") = gcds_excel_grid.namevalue(row,"FOUTAMT")*gcds_excel_grid.namevalue(row,"EXRATE");
			ln_Balamt_Sum(gcds_excel_grid.namevalue(row,"ACCTNO"),gcds_excel_grid.namevalue(row,"BALAMT2")); 
		}
	}
 
</script>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	ln_Popup_Cost(row);
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("데이터 생성이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("데이터 생성이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data_excel event=OnSuccess()>
	ln_Upload_Grid();
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data_excel event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data_excel.ErrorCode + "\n" + "Error Message : " + gctr_data_excel.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="cursor:hand;position:relative;top:-2px;right:2px" onclick="ln_Excel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr width="1000px"> 
					<td width="100px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>엑셀파일</nobr></td>
					<td class="tab18" ><nobr>&nbsp;
						<input type="text" name="file_path" value="" style="width:630px;position:relative;top:-2px" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcip_file classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE	style="width:70;height:20;position:relative;top:4px;fontSize=8"  >
						<param name = "Text"		value="찾아보기">
						</OBJECT>&nbsp;
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_btn_exl_app.gif" style="cursor:hand;position:relative;top:2px"  onClick="ln_Excel_Apply()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_create.gif"    style="cursor:hand;position:relative;top:2px"  onClick="ln_Create()">
						</comment><script>__ws__(__NSID__);</script>  
						</nobr>
					</td> 
				</tr>
			</table>
		</td>
	</tr>
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:1 solid #708090'>
				<tr>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>계좌번호</nobr></td>
					<td class="tab23" style="width:270px">
						<comment id="__NSID__">
						<object id=gcem_acctcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:40px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="####">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script></nobr>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Acctinfo()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_acctno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:170px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>거래일자</nobr></td>
					<td class="tab23" style="width:220px">
						<comment id="__NSID__">
							<object  id=gcem_enddat_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_enddat_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							~
							
							<object  id=gcem_enddat_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_enddat_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
							</nobr>
					</td>
					<td class="tab12" style="width:100px;" bgcolor="#eeeeee"><nobr>적요</nobr></td>
					<td class="tab22" style="width:200px">
						<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top><comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:397px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_excel_grid">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<PARAM NAME="Format"        VALUE="  
								<FG> Name ='계좌정보'                     HeadAlign=Center HeadBgColor=#B9D4DC   
								<FC> Name='코드'     ID=ACCTCD 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center	SumBgColor='#C3D0DB'  edit=none </FC>
								<FC> Name='번호'	    ID=ACCTNO	        HeadAlign=Center HeadBgColor=#B9D4DC Width=105	   	align=center	SumBgColor='#C3D0DB'  edit=none SumText=@count	 </FC> 
								</FG>
								<FC> Name='거래일시'  ID=DEALDT 	        HeadAlign=Center HeadBgColor=#B9D4DC Width=125   	align=center	SumBgColor='#C3D0DB'  edit=none SumText='계'	 </FC>
								
								<FC> Name='적요'	    ID=REMARK		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	align=left  	SumBgColor='#C3D0DB'  edit=none </FC>
								<G> Name ='원화'                         HeadAlign=Center HeadBgColor=#B9D4DC   
								<C> Name='입금액'	    ID=INAMT  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80   	align=right 	SumBgColor='#C3D0DB'  edit=none Dec=0</C>
								<C> Name='출금액'	    ID=OUTAMT  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none Dec=0</C>
								<C> Name='잔액'	    ID=BALAMT		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none Dec=0</C>
								</G>
								<G> Name ='외화'                         HeadAlign=Center HeadBgColor=#B9D4DC     
								<C> Name='입금액'	    ID=FINAMT 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='출금액'	    ID=FOUTAMT  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='잔액'	    ID=FBALAMT		    HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
								</G>
								<C> Name='통화'	    ID=CURUNIT 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=center	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='환율'	    ID=EXRATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=right 	SumBgColor='#C3D0DB'  edit=none bgcolor={IF(CURUNIT='WON','white',IF(CURUNIT='','white','yellow'))}</ </C>
								
								<G> Name ='원가'                         HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	    ID=COSTCD		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  bgcolor ='yellow'  EditStyle=Popup	 </C>
								<C> Name='원가명'	    ID=COSTNM		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  bgcolor ='yellow' </C>
								</G>
								<G> Name ='실적'                         HeadAlign=Center HeadBgColor=#B9D4DC   
								<C> Name='구분'	    ID=RESULT 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  bgcolor ='yellow' EditStyle=Combo, Data='1:입금,2:출금'</C>
								<C> Name='적요'      ID=RSTREMARK  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  bgcolor ='yellow'</C>
								<C> Name='순서'      ID=RSTSEQ  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=right 	SumBgColor='#C3D0DB'  bgcolor ='yellow'</C>
								</G>
								
								<C> Name='특이사항'	ID=TRISSUE 		    HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  bgcolor ='yellow' </C>
								<C> Name='거래일자'	ID=DEDATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=70    	align=center	SumBgColor='#C3D0DB'  edit=none  MASK='XXXX/XX/XX'</C>
								<C> Name='거래시간'	ID=DETIME  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=70    	align=center	SumBgColor='#C3D0DB'  edit=none  MASK='XX:XX:XX'</C>
								
								<C> Name='사용팀'     ID=TEAMNM  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=90    	align=left  	SumBgColor='#C3D0DB'  edit=none </C>
								<C> Name='이자율'     ID=INRATE  		    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none </C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
			</table>			
		</td> 
	</tr> 
	
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=gcbn_head classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID			value=gcds_head_a>
	<param name=BindInfo		value='  
		<C>Col=CO_NM			Ctrl=gcem_co_nm				Param=text</C>
		<C>Col=CO_CRNO			Ctrl=gcem_co_crno	    	Param=text</C>
		<C>Col=CO_RENM	        Ctrl=gcem_co_renm			Param=text</C>
		<C>Col=CO_NO	        Ctrl=gcem_co_no   			Param=text</C>
	'>
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						L O A D I N G  B A R   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 