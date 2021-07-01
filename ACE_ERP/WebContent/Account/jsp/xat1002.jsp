<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자동전표 - 계정 분개 
+ 프로그램 ID	:  xat1002.jsp
+ 기 능 정 의	:  자동 전표의 계정을 분개정의에 따라 분개하는 화면이다 .  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2018.04.17
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
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
<title>자금신청서</title>

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


<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_Before();
}

<%
/******************************************************************************
	Description : 선조회
******************************************************************************/
%>
function ln_Before(){
	
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	if(e=="0"){  //데이터 셋만....
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1002_s1?v_str1=A"
																			   +"&v_str2=A";																	
																			  
		 gcds_data01.Reset();	 
	}else{
		 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1002_s1?v_str1="+txt_jouno.value
		                                                                       +"&v_str2="+txt_jou_name.value;																	
		  
		 //prompt('',gcds_data01.DataID );
		 gcds_data01.Reset();	 
	}
}

<%
/******************************************************************************************
	Description : 저장
******************************************************************************************/
%>
function ln_Save(){
		
	if(!ln_Chk_Save())return;
	else if (gcds_data01.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
			gctr_data.KeyValue   = "Account.xat1002_t1(I:USER=gcds_data01)";
			gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1002_t1?";
			gctr_data.Parameters = "v_str1="+gs_userid;
			//prompt('',gcds_data01.text);
			gctr_data.post();
			ln_Query();			
		}	
	}
}

<%
/******************************************************************************************
	Description : 저장 체크
******************************************************************************************/
%>
function ln_Chk_Save(){
	
	for(var i=1;i<=gcds_data01.countrow;i++){
		  
		
		//필수항목 체크
		
		//분개
		if(gcds_data01.namevalue(i,"JOUNO")==""){
			alert(i+"번째 줄의 계정코드가 필요합니다.");
			return false;
		}
		
		//분개명
		if(gcds_data01.namevalue(i,"JOU_NAME")==""){
			alert(i+"번째 줄의 계정명이 필요합니다.");
			return false;
		}
		
		
		//계정코드
		if(gcds_data01.namevalue(i,"ATCODE")==""){
			alert(i+"번째 줄의 계정코드가 필요합니다.");
			return false;
		}
		
		//계정코드명
		if(gcds_data01.namevalue(i,"ATKORNAM")==""){
			alert(i+"번째 줄의 계정명이 필요합니다.");
			return false;
		}
		
		//차대
		if(gcds_data01.namevalue(i,"ATDECR")==""){
			alert(i+"번째 줄의 차대가 필요합니다.");
			return false;
		}
		
		
		//체크
		if(gcds_data01.namevalue(i,"ACCCHK")==""){
			alert(i+"번째 줄의 체크가 필요합니다.");
			return false;
		}
		
		

		
		/*
		//거래처
		if(gcds_data01.namevalue(i,"VENDCD")==""){
			alert(i+"번째 줄의 거래처코드가 필요합니다.");
			return false;
		}
		
		if(gcds_data01.namevalue(i,"VENDNM")==""){
			alert(i+"번째 줄의 거래처명이 필요합니다.");
			return false;
		}
		
		*/	
		
	}
	return true;
}

<%
/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
%>
function ln_Delete(){
	
	if(!ln_Chk_Delete(gcds_data01.rowposition))return;

	if (confirm("삭제 하시겠습니까?")){	
		gcds_data01.deleterow(gcds_data01.rowposition);
		gctr_data.KeyValue   = "Account.xat1002_t1(I:USER=gcds_data01)";
		gctr_data.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat1002_t1?";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		ln_Query();			
	}	
}



function ln_Chk_Delete(srow){
	
	return true ;
}


/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){
		
	if(gcds_data01.countrow<1){
		ln_Query("0");
	}	
		
	gcds_data01.addrow();
	
	if (chkbox_jouno.checked==true){
		gcds_data01.namevalue(gcds_data01.rowposition,"JOUNO") = txt_jouno.value;
		gcds_data01.namevalue(gcds_data01.rowposition,"JOU_NAME") = txt_jou_name.value;
	}else{
		gcds_data01.namevalue(gcds_data01.rowposition,"JOUNO") = "";
		gcds_data01.namevalue(gcds_data01.rowposition,"JOU_NAME") ="";
	}
	
	gcds_data01.namevalue(gcds_data01.rowposition,"SORTSEQ") =gcds_data01.rowposition;
	gcds_data01.namevalue(gcds_data01.rowposition,"USEGB") ="T";
	
}

/******************************************************************************
Description : 행삭제
******************************************************************************/
function ln_RowDel(){
	
	if(gcds_data01.countrow<1){
		alert("행 삭제할 행이 존재하지 않습니다.");	
	}	
	
	if(!ln_Chk_Delete(gcds_data01.rowposition))return;
	
	gcds_data01.deleterow(gcds_data01.rowposition);

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
	//gcgd_disp01.GridToExcel("일자별 예금집계 현황","",2);
}


<%
/******************************************************************************
Description : 계정 팝업  ok
******************************************************************************/
%>
function ln_Popup_Atcode(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="";
	arrParam[1]="02";
	strURL = "./actcode_popup_ifrm.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if(result != null){
		arrResult = result.split(";");
		ln_Ref_Data_Clear(row);         //관리항목 Clear();		
		ln_Ref_Find(arrResult,row);     //관리항목찾기
	}
}


/******************************************************************************
Description :  관리항목 데이타 Clear();
parameter   :  
******************************************************************************/
function ln_Ref_Data_Clear(row){
	for(k=1;k<=7;k++){
		gcds_data01.namevalue(row,"FSREFCD"+k)="";
		gcds_data01.namevalue(row,"FSREFVAL"+k)="";
	}
}

/******************************************************************************
Description : 관리항목설정
parameter   : arrResult - return 값
******************************************************************************/
function ln_Ref_Find(arrResult,row){
	// hid_lastref.value=""; //마지막관리항목     
	
	 if(arrResult[0]!=undefined){
		    gcds_data01.namevalue(row,"ATCODE") = arrResult[0];
		    gcds_data01.namevalue(row,"ATKORNAM") =arrResult[1];
			
			//++++++++++++++++++++++++++++++++++
			//계정별 관리항목 Setting
			//++++++++++++++++++++++++++++++++++
	       	
			//hid_lastref.value = 2;
			
			for(k=1;k<=7;k++){
				gcds_data01.namevalue(row,"FSREFCD"+k)   = arrResult[k+k+1+4];
				gcds_data01.namevalue(row,"FSREFCDNM"+k) = arrResult[k+k+2+4];
			}//for
	 }
}

<%
/******************************************************************************
Description : 거래처  팝업 ok
******************************************************************************/
%>
function ln_Popup_Vendcd(row){

	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_data01.namevalue(row,"VENDCD")     = arrResult[0];  // 코드 
		gcds_data01.namevalue(row,"VENDNM")     = arrResult[1];  // 거래처명
	}else{
		gcds_data01.namevalue(row,"VENDCD")     = "";  // 코드 
		gcds_data01.namevalue(row,"VENDNM")     = "";  // 거래처명
	}
}


<%
/******************************************************************************
Description : 찾기 - 작성자 OKjys
******************************************************************************/
%>
function ln_Popup_Appempno(){

	if(gusrid=="6070001"){
		//var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	
		strURL = "./empno_popup.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);
		
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_appempno.text    = arrParam[1];
			gcem_appempnm.text    = arrParam[0];
		}else{
			gcem_appempno.text="";
			gcem_appempnm.text="";
		}
	}
}


<%
/******************************************************************************
Description : 분개 MST 정보 
******************************************************************************/
%>
function ln_Popup_Accjoumst0(strGB){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='';
	arrParam[1]='';
	
	strURL = "./accjoumst_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	
	if(strGB=="0"){
		if(result != null) {
			arrResult = result.split(";");
			txt_jouno0.value   = arrResult[0];  // 코드 
			txt_jou_name0.value = arrResult[1];  // 분개명
		}else{
			txt_jouno0.value   = "";  // 코드 
			txt_jou_name0.value = "";  // 분개명
		}
		
	}else if(strGB="1") {
		if(result != null) {
			arrResult = result.split(";");
			txt_jouno.value   = arrResult[0];  // 코드 
			txt_jou_name.value = arrResult[1];  // 분개명
		}else{
			txt_jouno.value   = "";  // 코드 
			txt_jou_name.value = "";  // 분개명
		}
	}	
}


<%
/******************************************************************************
Description : 분개MST정보 - Grid
******************************************************************************/
%>
function ln_Popup_Accjoumst(row){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]='';
	arrParam[1]='';
	
	strURL = "./accjoumst_popup.jsp";
    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null) {
		arrResult = result.split(";");
		gcds_data01.namevalue(row,"JOUNO")   = arrResult[0];  // 코드 
		gcds_data01.namevalue(row,"JOU_NAME") = arrResult[1];  // 분개명
	}else{
		gcds_data01.namevalue(row,"JOUNO")   = "";
		gcds_data01.namevalue(row,"JOU_NAME") = "";
	}
}

<%
/******************************************************************************
Description : 관리항목값  - 팝업(공통)
******************************************************************************/
%>
function ln_Popup(row,p1){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strposition="";
	var strpo2="";
	var strpo3="";
	var strPopGubun ="";
	var strPo="";// 관리항목위치
	var divcd="";
	var intp=0; //관리항목 위치
	
	arrParam[0] = gcds_data01.namevalue(row,"FSREFCD"+p1);
	arrParam[1]="";
	//arrParam[1] = gcds_data01.namevalue(row,"FSREFCDNM"+p1);
	
	strURL = "./commdtil_popup_ifrm.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);	
	
	if(result != null) {
		arrResult = result.split(";");
		
		gcds_data01.namevalue(row,"FSREFVAL"+p1)= arrResult[0];
		gcds_data01.namevalue(row,"FSREFVALNM"+p1)= arrResult[1];
		
	}else{
		gcds_data01.namevalue(row,"FSREFVAL"+p1)= "";
		gcds_data01.namevalue(row,"FSREFVALNM"+p1)= "";
	}
}



</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--분개정보 -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object  id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object>

</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<script language=JavaScript for=gcgd_disp01 event=OnPopup(row,colid,data)>
	
	if(row>0){
		
		if(colid=="VENDCD"){
			ln_Popup_Vendcd(row); 
		}
		
		if(colid=="ATCODE"){
			ln_Popup_Atcode(row);
		}
		
		if(colid=="JOUNO"){
			ln_Popup_Accjoumst(row);
		}
		
		
		if(colid=="FSREFVAL1"){
			ln_Popup(row,"1");
		}
		
		if(colid=="FSREFVAL2"){
			ln_Popup(row,"2");
		}
		
		if(colid=="FSREFVAL3"){
			ln_Popup(row,"3");
		}
		
		if(colid=="FSREFVAL4"){
			ln_Popup(row,"4");
		}
		
		if(colid=="FSREFVAL5"){
			ln_Popup(row,"5");
		}
		
		if(colid=="FSREFVAL6"){
			ln_Popup(row,"6");
		}
		
		if(colid=="FSREFVAL7"){
			ln_Popup(row,"7");
		}
	
	}
</script>


<script language="javascript"  for=gcgd_disp01  event=OnClick(row,colid)>

	if(row>0){
		if(colid =="CHKBOX"){
			
		}
	}
</script>

<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
    

</script>

<script language=JavaScript for=gcds_data01 event=onColumnChanged(row,colid)>



</script>
 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data event=OnSuccess()>
	alert("성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr>
		<td align="right">&nbsp;<nobr>      
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Query()"> 
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	    style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/b_delete.gif"	        style="cursor:hand;position:relative;top:-2px;right:2px" onClick="ln_Delete()">
			</nobr>
		</td>
	</tr>
</table>

<!--  ===========================================================================================================-->
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0">	
  	<tr><td height="2px"><td></tr>
	<tr>
		<td colspan=8 align=left style="position:relative;left:6px;top:-2px">
			<table cellpadding="1" cellspacing="0" border="0" style='width:1000px;height:20px;border:0 solid #708090'>
				<tr>
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>분개정보</nobr></td>
					<td class="tab24" style="width:400px">
                        <input id="txt_jouno0"       type=text        style="position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7;"  readOnly>
						<img src="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup_Accjoumst0('0');">
					    <input id="txt_jou_name0"    type="text"      style="position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>			
					</td>
					
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>처리자</nobr></td>
					<td class="tab24" >
						<comment id="__NSID__">
						<object id=gcem_appempno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Appempno()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_appempnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Enable		  value="false">
							<param name=Language			value=1>
						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
			
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
			    <tr>
				    <td align = right   colspan=2>
				    	<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowadd.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_Add()"></font>
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_rowdel.gif"		style="cursor:hand;position:relative;top:0px;right:0px;" onclick="ln_RowDel()"></font>
					</td>
				</tr>
				
			    <tr height='25px'>
			    	<td style="position:relative;left:6px;" colspan=2>
			    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
			    			<tr>           
			    			                                                        
			                    <td align="center" class="text" width="100">분개정보</td>
			                    <td bgcolor="#FFFFFF">&nbsp;
			                        <input type=checkbox     id=chkbox_jouno     style="width:15px;position:relative;left:0px;top:0px">    
			                        <input id="txt_jouno"       type=text        style="position:relative;top:0px;left:4px;width:50px; height:20px;"  class="txtbox"  maxlength=7;"  readOnly>
									<img src="<%=dirPath%>/Sales/images/help.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup_Accjoumst0('1');">
								    <input id="txt_jou_name"    type="text"      style="position:relative;top:0px;left:4px;width:150px; height:20px;" class="txtbox"  maxlength="36" " readOnly>	
			                    </td>
			    			</tr>
			       		</table>
			       	</td>
			 	</tr>
				
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:500px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
							<PARAM NAME="DataID"        VALUE="gcds_data01">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="BorderStyle"	VALUE="0">
							<PARAM NAME="IndWidth"		VALUE="0">
							<PARAM NAME="ColSizing"		VALUE="true">
							<param NAME="Fillarea"      VALUE="true">
							<param name="SortView"      value="Left">
							<PARAM NAME="viewSummary"	VALUE="1">
							<param name="GTitleHeight"  value=25>
							<param name="TitleHeight"   value="25">
							<param name=RowHeight       value="20">
							<param name="UsingOneClick" value="1">
							<PARAM NAME="Format"        VALUE="  
								<FC> Name='순번'       ID=SORTSEQ       HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	    align=center  	SumBgColor='#C3D0DB'    </FC>
								<FG> Name='분개정보'    HeadAlign=Center HeadBgColor=#B9D4DC
									<C> Name='분개NO'  ID=JOUNO	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	SumBgColor='#C3D0DB'  EditStyle=Popup</C>
								    <C> Name='분개명'	  ID=JOU_NAME	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								</FG>
								<G> Name='계정정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	     ID=ATCODE 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50     	align=center 	SumBgColor='#C3D0DB'  EditStyle=Popup</C>
								<C> Name='계정명'	     ID=ATKORNAM	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100  	    align=left  	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='차대'	     ID=ATDECR  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='1:차변,2:대변'</C>
								<C> Name='체크'  	 ID=ACCCHK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=30    	align=left  	SumBgColor='#C3D0DB'  </C>
								<C> Name='체크명'  	 ID=CHKNAME  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  </C>
								</G>
								<G> Name='거래처정보'    HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  EditStyle=Popup </FC>
								<C> Name='거래처명'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								</G>
								
								<G> Name='세목정보(관리항목)'	  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드1'       ID=FSREFCD1  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명1'     ID=FSREFCDNM1    HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값1'	  ID=FSREFVAL1     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명1'	  ID=FSREFVALNM1   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='코드2'       ID=FSREFCD2  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명2'     ID=FSREFCDNM2    HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값2'	  ID=FSREFVAL2     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명2'	  ID=FSREFVALNM2   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='코드3'       ID=FSREFCD3  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명3'     ID=FSREFCDNM3    HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값3'	  ID=FSREFVAL3     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명3'	  ID=FSREFVALNM3   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='코드4'       ID=FSREFCD4  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명4'     ID=FSREFCDNM4     HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값4'	  ID=FSREFVAL4     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명4'	  ID=FSREFVALNM4   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='코드5'       ID=FSREFCD5  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명5'     ID=FSREFCDNM5     HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값5'	  ID=FSREFVAL5     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명5'	  ID=FSREFVALNM5   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='코드6'       ID=FSREFCD6  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명6'     ID=FSREFCDNM6     HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값6'	  ID=FSREFVAL6     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명6'	  ID=FSREFVALNM6   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='코드7'       ID=FSREFCD7  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=40    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='코드명7'     ID=FSREFCDNM7     HeadAlign=Center HeadBgColor=#B9D4DC Width=80     	align=left  	SumBgColor='#C3D0DB'   </C>
								<C> Name='항목값7'	  ID=FSREFVAL7     HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=left  	SumBgColor='#C3D0DB'  EditStyle=Popup </C>
								<C> Name='항목값명7'	  ID=FSREFVALNM7   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=left  	SumBgColor='#C3D0DB'   </C>
								</G>
								<C> Name='사용\\유무'    ID=USEGB 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  EditStyle=Combo, Data='T:사용,F:미사용' </C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				<tr>
				
				<tr><td colspan=2>&nbsp;</td></tr>
				
			</table>			
		</td> 
	</tr> 
</table> 
			 

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N - [A]
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					  P R I N T   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
