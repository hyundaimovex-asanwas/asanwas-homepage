<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인감관리 - 인감정보
+ 프로그램 ID	: a400120.jsp
+ 기 능 정 의	: 인감정보
+ 최 초 이 력	: 2017.04.06 jys
+ 가우스 버젼    : 5.2
-----------------------------------------------------------------------------
+ 변 경 이 력	:   
+ 변 경 내 용	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a400120_s1, a400120_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

    gcra_usegb_0.codevalue ="";	
	
    gcds_signet_gb_0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2270&v_str2=&v_str3=&v_str4=C";   
	gcds_signet_gb_0.Reset();	
	
	gcds_signet_gb.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2270&v_str2=&v_str3=&v_str4=C";   
	gcds_signet_gb.Reset();	
	
	ln_Query();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_s1?v_str1="+gclx_signet_gb_0.bindcolval
			                                                            +"&v_str2="+gcra_usegb_0.codevalue;
   //prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){
	gcds_data.addrow();	
	gcem_reg_date.text=gs_date2;
	gcra_usegb.CodeValue="1";
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
		if (confirm("입력하신 사항을 저장하시겠습니까?")){	
		//His_Data_Add();		
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt('',gcds_data.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
    //필수항목 체크     
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==3){
			
			if(gcds_data.namevalue(i,"SIGNET_GB") == ""){ 			
				alert("인감구분을 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"MGR_TEAMCD") == "" || gcds_data.namevalue(i,"MGR_TEAMNM") == "" ){
				alert("인감관리팀을 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"MAIN_EMPID") == "" || gcds_data.namevalue(i,"MAIN_EMPNMK") == "" ){ 				
				alert("책임자(정)을 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"SUB_EMPID") == "" ||gcds_data.namevalue(i,"SUB_EMPNMK")=="" ){ 				
				alert("책임자(부)를 입력하세요.");
				return false;
			}
			
			if(gcds_data.namevalue(i,"SIGNET_HEAD_NO") == ""){ 				
				alert("인감번호를 입력하세요.");
				return false;
			}
		}
	} 
	
	return true;
}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}

<%	
/******************************************************************************
	Description : 삭제
******************************************************************************/
%>
function ln_Delete(){
		
	if (confirm("선택하신 사항을 삭제하시겠습니까?")){
		gcds_data.deleterow(gcds_data.rowposition);
		//gctr_data.KeyValue = "Account.a400120_t1(I:USER=gcds_data)";
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400120_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		return ln_Query();
	}
	else gcds_data.undo(gcds_data.rowposition);
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}


<%
/******************************************************************************
Description : 관리자팝업(정) 
******************************************************************************/
%>
function ln_Popup_Main_Empid(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_asnhr_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_main_empid.text   = arrParam[0];
		gcem_main_empnmk.text  = arrParam[1];
	}else{
		gcem_main_empid.text="";
		gcem_main_empnmk.text="";
	}
}


<%
/******************************************************************************
Description : 관리자팝업(부) 
******************************************************************************/
%>
function ln_Popup_Sub_Empid(){

	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_asnhr_popup.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_sub_empid.text   = arrParam[0];
		gcem_sub_empnmk.text  = arrParam[1];
	}else{
		gcem_sub_empid.text="";
		gcem_sub_empnmk.text="";
	}
}

<%
/******************************************************************************
Description : 인감관리팀 
******************************************************************************/
%>
function ln_Popup_Mgr_Team(){
	 var result="";
	 var arrParam	= new Array();
	 var arrResult	= new Array();
	
     strURL = "./hcdept_asnhr_popup1.jsp";
	 strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
	 arrResult = showModalDialog(strURL,arrParam,strPos);	
	 
	 if (arrResult != null) {
		arrParam = arrResult.split(";");
		gcem_mgr_teamcd.text   = arrParam[0];
		gcem_mgr_teamnm.text   = arrParam[1];
	 }else{
		gcem_mgr_teamcd.text   = "";
		gcem_mgr_teamnm.text   = "";
	 }
}

<%
/******************************************************************************
Description : 이력내역 데이터 셋 헤드 설정 
******************************************************************************/
%>
function His_SetDataHeader() {
	 var s_temp = "SIGNET_ID:STRING,SIGNET_SEQ:DECIAML,WORK_GB:STRING,MGR_TEAMCD:STRING,MGR_TEAMNM:STRING,"
		        + "MAIN_EMPID:STRING,SUB_EMPID:STRING,SEND_DATE:STRING,DISUSE_DATE:STRING,DISUSE_REASON:STRING,"
		        + "RECE_DATE:STRING,RECE_REASON:STRING,USEGB:STRING,USE_REMARK:STRING,ETC:STRING,"
		        + "WRID:STRING,WRDT:STRING";
	 gcds_data_his.SetDataHeader(s_temp);
}


<%
/******************************************************************************
Description : 이력내역 데이터 추가 
******************************************************************************/
%>
function His_Data_Add(){
	/*
	var hrow=0;
	His_SetDataHeader();
	
	for(var i=1;i<=gcds_data.countrow;i++){
			
		if(gcds_data.SysStatus(i)==1||gcds_data.SysStatus(i)==2||gcds_data.SysStatus(i)==3){
			
			gcds_data_his.AddRow();
			hrow = gcds_data_his.rowposition;
			
			gcds_data_his.namevalue(hrow,"SIGNET_ID")     = gcds_data.namevalue(i,"SIGNET_ID");
			gcds_data_his.namevalue(hrow,"SIGNET_SEQ")    = 0;
			gcds_data_his.namevalue(hrow,"MGR_TEAMCD")    = gcds_data.namevalue(i,"MGR_TEAMCD");
			gcds_data_his.namevalue(hrow,"MGR_TEAMNM")    = gcds_data.namevalue(i,"MGR_TEAMNM");
			gcds_data_his.namevalue(hrow,"MAIN_EMPID")    = gcds_data.namevalue(i,"MAIN_EMPID");
			gcds_data_his.namevalue(hrow,"SUB_EMPID")     = gcds_data.namevalue(i,"SUB_EMPID");
			gcds_data_his.namevalue(hrow,"SEND_DATE")     = "";
			gcds_data_his.namevalue(hrow,"DISUSE_DATE")   = gcds_data.namevalue(i,"DISUSE_DATE");
			gcds_data_his.namevalue(hrow,"DISUSE_REASON") = gcds_data.namevalue(i,"DISUSE_REASON");
			gcds_data_his.namevalue(hrow,"RECE_DATE")     = gcds_data.namevalue(i,"RECE_DATE");
			gcds_data_his.namevalue(hrow,"RECE_REASON")   = gcds_data.namevalue(i,"RECE_REASON");
			gcds_data_his.namevalue(hrow,"USEGB")         = gcds_data.namevalue(i,"USEGB");
			gcds_data_his.namevalue(hrow,"USE_REMARK")    = gcds_data.namevalue(i,"USE_REMARK");
			gcds_data_his.namevalue(hrow,"ETC")           = gcds_data.namevalue(i,"ETC");
			gcds_data_his.namevalue(hrow,"WRID")          = "";
		}
		

		if(gcds_data.SysStatus(i)==1){ // INSERT
			gcds_data_his.namevalue(hrow,"WORK_GB")="1";
		}else if(gcds_data.SysStatus(i)==2){ //DELETE
			gcds_data_his.namevalue(hrow,"WORK_GB")="3";
		}else if(gcds_data.SysStatus(i)==3){ //UPDATE
			gcds_data_his.namevalue(hrow,"WORK_GB")="2";
		}
	}
	*/
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_data_his classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_signet_gb_0 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_signet_gb classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:78E24950-4295-43D8-9B1A-1F41CD7130E5 VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a400120_t1(I:USER=gcds_data)">
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">//하위코드
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//총 조회 건수
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="전체";
    gclx_signet_gb_0.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"  style="cursor:hand" onclick="ln_Cancel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"	style="cursor:hand" onclick="ln_Save()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
	 	<td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" >검색</td>
			<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">인감구분</td>
			<td width="400px"  class="tab18"  align=left  >
		    	<comment id="__NSID__">
					<object  id=gclx_signet_gb_0  classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:5px;top:0px;font-size:12px;width:130px;">
							<param name=ComboDataID      value="gcds_signet_gb_0">
							<param name=CBDataColumns	 value="CDCODE,CDNAM">
							<param name=SearchColumn	 value="CDNAM">
							<param name=Sort			 value=true>
							<param name=SortColumn       value="CDCODE">
							<param name=ListExprFormat   value="CDNAM^0^100">								
							<param name=BindColumn		 value="CDCODE">
					</object>
				</comment><script>__ws__(__NSID__);</script> 
			</td>
			<td class="tab18" width="100px;" bgcolor="#eeeeee" align="center">사용유무</td>
			<td class="tab18" >&nbsp;
				<comment id="__NSID__">
				<object id=gcra_usegb_0 classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200px;height:20px" >
					<param name=Cols	value="4">
					<param name=Format	value="1^사용,2^보관,9^폐기,^전체">
				</object></comment><script>__ws__(__NSID__);</script>
			</td> 	 
		</tr>
		</table>

	<tr>
		<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
					<tr> 			
						<td ALIGN=LEFT VALIGN=TOP>
							<comment id="__NSID__"><object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_pyo style="WIDTH:633px;HEIGHT:550px;border:1 solid #777777;display:block;" viewastext>
	 						 <PARAM NAME="DataID"		VALUE="gcds_data">
							 <PARAM NAME="BorderStyle"  VALUE="0">
							 <PARAM NAME="Indwidth"		VALUE="0">
							 <PARAM NAME="Fillarea"		VALUE="true">
							 <PARAM NAME="ColSizing"	VALUE="true">
							 <param name="sortview"     value=left>
						     <PARAM NAME="Format"		VALUE="  
								<FC>ID=CurRow,	        Name=NO,	        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false Value={CurRow}</FC>
								<FC>ID=SIGNET_ID        Name=인감ID,    	    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </FC>
								<FC>ID=SIGNET_GB        Name=인감구분,    	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  EditStyle=Combo,  Data='1:법인인감,2:사용인감'</FC>
								<C> ID=MGR_TEAMNM       Name=관리팀,	    	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=SIGNET_HEAD_NO   Name=인감번호,  	    width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=MAIN_EMPNMK      Name=책임자(정),	    width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=SUB_EMPNMK       Name=책임자(부),  	width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
								<C> ID=PLACEGB		    Name=지급구분,	    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  EditStyle=Combo,  Data='1:서울,2:현장/사무소,3:예비'</C>
								<C> ID=USEGB	        Name=사용유무,	    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  EditStyle=Combo,  Data='1:사용,2:보관,9:폐기'</C>
								<C> ID=ETC 	            Name=적요,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
							">
						 	</object></comment><script>__ws__(__NSID__);</script> 
						</td>
				  	</tr>
				 </table>
			</td>
			<td>
				<!--입력창 -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:346px;height:525px;border:1 solid #708090;">
				
				   <tr>
						<td width="100px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>인감ID</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_signet_id"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:60px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>인감구분<font size="2" color="red" >(*)</font></nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object  id=gclx_signet_gb  classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:5px;top:0px;font-size:12px;width:130px;">
										<param name=ComboDataID      value="gcds_signet_gb">
										<param name=CBDataColumns	 value="CDCODE,CDNAM">
										<param name=SearchColumn	 value="CDNAM">
										<param name=Sort			 value=true>
										<param name=SortColumn       value="CDCODE">
										<param name=ListExprFormat   value="CDNAM^0^100">								
										<param name=BindColumn		 value="CDCODE">
								</object>
							</comment><script>__ws__(__NSID__);</script> 
						</td>
					</tr>
				
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>인감관리팀<font size="2" color="red" >(*)</font></nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__">
							<object id=gcem_mgr_teamcd classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="#######">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Mgr_Team()">
					    	<comment id="__NSID__">
							<object  id=gcem_mgr_teamnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:150px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language	  value=1>
								<param name=Enable		  value="false">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>등록일자<font size="2" color="red" >(*)</font></nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_reg_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reg_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;</nobr>
						</td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>책임자(정)<font size="2" color="red" >(*)</font></nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__">
							<object id=gcem_main_empid  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="#####">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Main_Empid()">
					    	<comment id="__NSID__">
							<object  id=gcem_main_empnmk classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:150px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language	  value=1>
								<param name=Enable		  value="false">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>책임자(부)<font size="2" color="red" >(*)</font></nobr></td>
						<td Style="height:20px;border:0 solid #708090;border-bottom-width:1px"><nobr>
							<comment id="__NSID__">
							<object id=gcem_sub_empid  classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:5px;width:50px">
								<param name=Text		  value="">
								<param name=Alignment	  value=0>
								<param name=Border		  value=true>
								<param name=Format		  value="#####">
								<param name=PromptChar	  value="_">
								<param name=Enable		  value="false">
							</object>
						    </comment><script>__ws__(__NSID__);</script></nobr>
					    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_Popup_Sub_Empid()">
					    	<comment id="__NSID__">
							<object  id=gcem_sub_empnmk classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:150px;height:20px;position:relative;left:5px;top:2px" >		
								<param name=Text		  value="">
								<param name=Border        value=true>
								<param name=GeneralEdit   value="true">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Language	  value=1>
								<param name=Enable		  value="false">
							</object></comment><script>__ws__(__NSID__);</script>
						</td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>각인내역</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_carve"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>재료</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_material"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>폐기일자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_disuse_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_disuse_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;</nobr>
						</td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>폐기사유</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_disuse_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>반납일자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
							<object  id=gcem_rece_date classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object>
							</comment><script>__ws__(__NSID__);</script> 
							<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_rece_date', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;</nobr>
						</td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>반납사유</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_rece_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사용유무</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_usegb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0	style="position:relative;left:-6px;top:2px;width:150px;height:20px;">
								<param name=Cols	value="3">
								<param name=Format	value="1^사용,2^보관,9^폐기">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
					</tr>
					
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>사용내역</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_use_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
					
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>지급구분</nobr></td>
						<td  class="tab13" style="text-align:left">&nbsp;
							<comment id="__NSID__">
							<object id=gcra_placegb classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0	style="position:relative;left:-6px;top:2px;width:270px;height:20px;">
								<param name=Cols	value="3">
								<param name=Format	value="1^서울,2^현장/사무소,3^예비">
							</object></comment><script>__ws__(__NSID__);</script> 
						</td> 
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>기타</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_etc"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
                    
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>인감번호<font size="2" color="red" >(*)</font></nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
							<input id="txt_signet_head_no"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;">
						</nobr></td>
					</tr>
				
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>입력자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>입력일시</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>수정자</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_upid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					
					<tr>
						<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>수정일시</nobr></td>
						<td class="tab13" style="text-align:left"><nobr>
						<input id="txt_updt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
						</nobr></td>
					</tr>
					<tr>
						<td  class="tab12" align=center colspan=2  style= "height:25px" > <font size="2" color="red" >(*)</font> 표시건은 필수 항목입니다.</td>
					</tr>
			  </table>
		 </td>
		 </tr>
		</table>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
	</tr>	
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
  <object  id=gcbn_disp2 classid=CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='  
	<C>Col=SIGNET_ID             Ctrl=txt_signet_id         Param=value</C>
	<C>Col=SIGNET_GB             Ctrl=gclx_signet_gb        Param=bindcolval</C>
	<C>Col=MGR_TEAMCD            Ctrl=gcem_mgr_teamcd       Param=text</C>
	<C>Col=MGR_TEAMNM            Ctrl=gcem_mgr_teamnm       Param=text</C>
	<C>Col=REG_DATE              Ctrl=gcem_reg_date         Param=text</C>
	<C>Col=MAIN_EMPID            Ctrl=gcem_main_empid       Param=text</C>
	<C>Col=MAIN_EMPNMK           Ctrl=gcem_main_empnmk      Param=text</C>
	<C>Col=SUB_EMPID             Ctrl=gcem_sub_empid        Param=text</C>
	<C>Col=SUB_EMPNMK            Ctrl=gcem_sub_empnmk       Param=text</C>
	<C>Col=CARVE                 Ctrl=txt_carve             Param=value</C>
	<C>Col=MATERIAL              Ctrl=txt_material          Param=value</C>
	<C>Col=DISUSE_DATE           Ctrl=gcem_disuse_date      Param=text</C>
	<C>Col=DISUSE_REASON         Ctrl=txt_disuse_reason     Param=value</C>
	<C>Col=RECE_DATE             Ctrl=gcem_rece_date        Param=text</C>
	<C>Col=RECE_REASON           Ctrl=txt_rece_reason       Param=value</C>
	<C>Col=USEGB                 Ctrl=gcra_usegb            Param=codevalue</C>
	<C>Col=USE_REMARK            Ctrl=txt_use_remark        Param=value</C>
	<C>Col=ETC                   Ctrl=txt_etc               Param=value</C>
	<C>Col=PLACEGB               Ctrl=gcra_placegb          Param=codevalue</C>
	<C>Col=SIGNET_HEAD_NO        Ctrl=txt_signet_head_no    Param=value</C>
	<C>Col=WRID                  Ctrl=txt_wrid              Param=value</C>
	<C>Col=WRDT                  Ctrl=txt_wrdt              Param=value</C>
	<C>Col=UPID                  Ctrl=txt_upid              Param=value</C>
	<C>Col=UPDT                  Ctrl=txt_updt              Param=value</C>
	'>
  </object>
  </comment><script>__ws__(__NSID__);</script> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



