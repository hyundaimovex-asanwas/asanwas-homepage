<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 업체등록요청 (해외,직원 ) 
+ 프로그램 ID	: a010052.jsp
+ 기 능 정 의	: 업체등록요청 (해외,직원 )
+ 최 초 이 력	: 
+ 변 경 이 력	: 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a010050_s1, a010050_t1
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

var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    
    gclx_status_0.bindcolval ="N";    
    gclx_status.bindcolval ="N";
    
    txt_empno_0.value =gusrid;
	txt_empnmk_0.value = gusrnm;
	
    document.getElementById("txt_vend_nm").disabled = true;
    document.getElementById("txt_vend_nm").className = "input_ReadOnly";
}

<%
/******************************************************************************
	Description : 조회
******************************************************************************/
%>
function ln_Query(){
		
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010052_s1?v_str1="+gcem_vend_cd_0.text
                                                                        +"&v_str2="+gcem_vend_nm_0.text
                                                                        +"&v_str3="+gclx_status_0.bindcolval
                                                                        +"&v_str4="    
                                                                        +"&v_str5="+txt_empno_0.value   	
                                                                        +"&v_str6="     
	                                                                    +"&v_str7=A";                                                                                                                                                                                                                                                            
   // prompt('',gcds_data.DataID);
	gcds_data.Reset();
}

<%
/******************************************************************************
	Description : 추가
******************************************************************************/
%>

function ln_Add(){
	
    document.getElementById("txt_vend_nm").disabled = false;
    document.getElementById("txt_vend_nm").className = "";	
	
	ln_SetDataHeader();
	gcds_data.addrow();	
    gclx_status.bindcolval ="N";
    gcds_data.namevalue(gcds_data.rowposition,"USE_TAG")="Y";
    
    txt_empnok.value="";
}

<%
/******************************************************************************
	Description : 저장
******************************************************************************/
%>
function ln_Save(){
	if(!ln_Chk_Save())return;
	else if (gcds_data.IsUpdated) {
	    if(!ln_Chk_Save_Status())return;
	    
	    //실제 거래처 테이블에서 확인 함. 
	    //직원일 경우 거래처 코드 체크 동일건 존재하는지....  
	    //해외일 경우 동일 거래처 명 존재하는지 체크 ......
	    
		if (confirm("입력하신 사항을 등록하시겠습니까?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010052_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		//prompt(this, gcds_data.text);
		gctr_data.post();
		ln_Query();
		}	
	}
}

<%
/******************************************************************************
	Description : 삭제 
******************************************************************************/
%>
function ln_Delete(){

    //상태값 체크 
    if(!ln_Chk_Delete_Status()) return false;
    
	if (confirm(" 해당 데이터를 삭제 하시겠습니까?")){	
		gcds_data.DeleteMarked();
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t1";
		gctr_data.Parameters = "v_str1="+gs_userid;
		gctr_data.post();
		ln_Query();
	}	
}

<%
/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
%>
function ln_Chk_Save() {

  //상태값이 대기 일경우만 가능 
   for(i=1;i<=gcds_data.countrow;i++){
   		if(gcds_data.SysStatus(i)=="1"||gcds_data.SysStatus(i)=="3"){
   		
			if(fn_trim(gcds_data.namevalue(i,"VEND_NM")) == ""){//거래처명
				alert("거래처명을  입력하세요.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VENDER_USERGB")) == ""){//구분
				alert("구분을  입력하세요.");
				return false;
			}
			
			if(fn_trim(gcds_data.namevalue(i,"VENDER_USERGB")) == "K"){//구분
				if(fn_trim(gcds_data.namevalue(i,"EMPNO")) == ""){//구분
					alert("구분이 직원일 경우 직원사번을 입력하십시요.");
					return false;
				}
			}
			
			if(fn_trim(gcds_data.namevalue(i,"STATUS")) == ""){//상태
				alert("상태를  입력하세요.");
				return false;
			}
			
			gcds_temp01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010052_s2?v_str1="+gcds_data.namevalue(i,"VENDER_USERGB")
																		          +"&v_str2="+gcds_data.namevalue(i,"VEND_NM")
																		          +"&v_str3="+gcds_data.namevalue(i,"EMPNO");
                                                                                                                                                                                                                                                 
			// prompt('',gcds_data.DataID);
			gcds_temp01.Reset();
			
			if(gcds_temp01.namevalue(gcds_temp01.rowposition,"CNT")>0){
				alert(gcds_data.namevalue(i,"VEND_NM")+"는 이미 존재한 데이터 입니다.");
				return false;
			}
		}
   }
	return true;
}

<%
/******************************************************************************
	Description : 취소
******************************************************************************/
%>
function ln_Cancel(){
	gcds_data.undo(gcds_data.rowposition);
}

<%
/******************************************************************************
	Description : 승인요청
******************************************************************************/
%>
function ln_AppReq(){
    //상태값 체크 : 대기 반송 상태만 요청 가능함 
    if(!ln_Chk_Status()) return false;
   
	if (confirm(" 해당 거래처 등록 승인 요청 하시겠습니까?")){	
		gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010050_t2";
		gctr_data.Parameters = "v_str1="+gs_userid;
		
	//	prompt('',gcds_data.text);
		gctr_data.post();
		ln_Query();
	}else{
		gcds_data.UndoAll();
	}	
}

<%
/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
%>
function ln_Chk_Save_Status(){
	for(var i =1; i<=gcds_data.countrow;i++){
		//alert("gcds_data.SysStatus(i)::"+gcds_data.SysStatus(i));
		if(gcds_data.SysStatus(i)==3){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 수정 가능건이 아닙니다.");
				return false;
			}
		}
	}
	return true;
}
<%
/******************************************************************************
	Description : 상태값 체크 
******************************************************************************/
%>
function ln_Chk_Status(){
    var vcnt=0;
    
    for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.SysStatus(i)=="1"){
				alert("저장 후 승인요청 하십시요.");
				return false;
			}
			vcnt+=1;	
		}
	}
    
    
    if (vcnt==0){
		alert("선택된 항목이 존재 하지 않습니다.");
		return false;
	}
	
    
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")!="N"&&gcds_data.namevalue(i,"STATUS")!="B"){
				alert(gcds_data.namevalue(i,"VEND_NM")+"은 요청 가능건이 아닙니다.");
				return false;
			}else{
				gcds_data.namevalue(i,"STATUS")="R"; 
			}
		}
	}
	
	return true;
}
<%
/******************************************************************************
	Description : 상태값 체크 삭제
******************************************************************************/
%>
function ln_Chk_Delete_Status(){
    var vcnt=0;
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			if(gcds_data.namevalue(i,"STATUS")=="Y"){
				alert(gcds_data.namevalue(i,"VEND_NM") + "은  삭제 가능건이 아닙니다.");
				return false;
			}
			gcds_data.MarkRows(i,i);
			vcnt+=1;
		}
	}
	
	if (vcnt==0){
		alert("선택된 항목이 존재 하지 않습니다.");
		return false;
	}
	return true;
}


/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}


/******************************************************************************
	Description : 문자열체크
******************************************************************************/

/******************************************************************************
	Description : Dataset Head 설정 -  
******************************************************************************/
function ln_SetDataHeader(){
	if(gcds_data.countrow<1){
		var THeader = "CHK:STRING, VEND_CD:STRING,VEND_NM:STRING,VEND_ID:STRING,VEND_NO:STRING,VD_DIRECT:STRING,"
					+ "BSNS_CND:STRING,BSNS_KND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,POST_NO1:STRING,"
					+ "POST_NO2:STRING,ADDRESS1:STRING,ADDRESS2:STRING,"
					+ "USE_TAG:STRING,"
					+ "REMARK:STRING,CREAT_DT:STRING,CREAT_NM:STRING,MSN:STRING,MPWD:STRING,"
					+ "COCOMYN:STRING,H_VEND_CD:STRING,H_VEND_NM:STRING,IUGB:STRING,"
					+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
					+ "STATUS:STRING,RQID:STRING,RQDT:STRING,CFID:STRING,CFDT:STRING,BSID:STRING,BSDT:STRING,VENDER_USERGB:STRING,EMPNO:STRING";
		gcds_data.SetDataHeader(THeader);						
	}
}

<%
/***********************************************************************************************
	Description : 사번찾기
	parameter   :
**********************************************************************************************/
%>
function ln_Popup_Empno_0(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]=""; //

	strURL =  "./empno_popup.jsp";
	strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno_0.value =arrResult[1];
		txt_empnmk_0.value = arrResult[0];
	}else{
   		txt_empno_0.value="";
		txt_empnmk_0.value="";
	}
}

<%
/***********************************************************************************************
	Description : 사번찾기
	parameter   :
**********************************************************************************************/
%>
function ln_Popup_Empno(){
	
	if(gcra_vender_usergb.codevalue!="K"){
		alert("구분코드가 직원만 가능합니다.");
		return false;
	}
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[0]="" ;//

	strURL =  "./empno_popup.jsp";
	strPos = "dialogWidth:390px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		txt_empno.value =arrResult[1];
		txt_empnmk.value = arrResult[0];
		txt_vend_nm.value = arrResult[0];
	}else{
   		txt_empno.value="";
		txt_empnmk.value="";
	}
}



</script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=gcds_temp01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object> 
</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><object id=gctr_data classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="A010047_t1(I:USER=gcds_data)">
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
//		ln_Query();
	}

	lbl_search.innerText = "총 ( " + rowcount + " ) 건";
	window.status = "정상적으로 조회되었습니다.";
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcra_vender_usergb event=OnSelChange()>
    if(gcra_vender_usergb.codevalue=="K"){
    	
    }else{
        txt_empno.value="";
    	txt_empnmk.value="";
    }
</script>



<script language=JavaScript for=gcgd_data event=OnClick(row,colid)>
	if(gcra_vender_usergb.codevalue=="K"){
		
	}else{
	    txt_empno.value="";
		txt_empnmk.value="";
	}
   
</script>

<script language=JavaScript for=gcds_data event=OnRowPosChanged(row)>

</script>
 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td ><img src="../img/a010050_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
    
            
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_appreq.gif"	style="cursor:hand" onclick="ln_AppReq()" >&nbsp;&nbsp;
    
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_insert.gif"	    style="cursor:hand" onclick="ln_Add()" >
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_delete.gif"		style="cursor:hand" onclick="ln_Delete()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_cancle.gif"      style="cursor:hand" onclick="ln_Cancel()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
  </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:868px;height:30px;font-size:9pt;background-color:#ffffff;">
		<tr> 
			<td class="tab15" width="90px;" bgcolor="#eeeeee" align="center">거래처코드</td>
			<td class="tab18" width="80px" align=CENTER><comment id="__NSID__">
			<object  id=gcem_vend_cd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:0px;width:70px" >
				<param name=Text				value="">
				<param name=Alignment			value=0>
				<param name=Border				value=true>
				<param name=GeneralEdit		    value="true">
				<param name=PromptChar		    value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="80px;" bgcolor="#eeeeee" align="center">거래처명</td>
			<td class="tab24" width="130px"  align="left" ><comment id="__NSID__">
				<object  id=gcem_vend_nm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:0px;left:5px;width:120px" >
				<param name=Text			     value="">
				<param name=Alignment		    value=0>
				<param name=Border			    value=true>
				<param name=GeneralEdit		    value="true">
				<param name=PromptChar		    value="_">
			</object></comment><script>__ws__(__NSID__);</script>
			</td>
			<td class="tab14" width="70px;" bgcolor="#eeeeee" align="center">상태</td>
			<td class="tab24" >&nbsp;
			<comment id="__NSID__">
			<object id=gclx_status_0 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
						<param name=CBData			     value="N^대기,R^승인요청,Y^완료,B^반송">
						<param name=CBDataColumns	     value="CODE,NAME">
						<param name=SearchColumn	     value=NAME>
						<param name=Sort			      value=false>
						<param name=ListExprFormat       value="NAME">								
						<param name=BindColumn		     value="CODE">
			</object>
			
			</comment><script>__ws__(__NSID__);</script>
		</td> 	 
		
		<td class="tab14" width="90px;" bgcolor="#eeeeee" align="center">작성자</td>
		<td class="tab14" ><nobr> &nbsp;
			<input type="text" class="txt11" id="txt_empno_0"  style="position:relative;top:2px;left:-2px;width:60px;background-color:#d7d7d7" readOnly>
			<img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;position:relative;top:2px;left:-3px" onclick="ln_Popup_Empno_0()">
		    <input type="text" class="txt11" id="txt_empnmk_0" maxlength=8 style="position:relative;top:2px;left:-4px;width:90px;"></nobr> 
		</td> 	 
			
		</tr>
		
	</table>

	<tr>
	<td COLSPAN=2>
		<table>
			<tr>
			<td>
				<!--Grid-->
				<table cellpadding="0" cellspacing="0"  style="position:relative;left:-3px;width:250px;border:0 solid #708090;">
					<tr> 			
					<td ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:555px;HEIGHT:427px;border:1 solid #777777;display:block;" viewastext>
 						 <PARAM NAME="DataID"		VALUE="gcds_data">
						 <PARAM NAME="BorderStyle"  VALUE="0">
						 <PARAM NAME="Indwidth"		VALUE="0">
						 <PARAM NAME="Fillarea"		VALUE="true">
						 <PARAM NAME="ColSizing"	VALUE="true">
						 <param name="sortview"     value=left>
						 <param name="Editable"     value='true'>
						 <param name=UsingOneClick  value="1">
					     <PARAM NAME="Format"		VALUE="  
					        <FC>ID=CHK 	         Name='선택'             Width=28    HeadBgColor=#B9D4DC  bgcolor=#ffffff, align=center	 EditStyle=CheckBox   </C>  
							<FC>ID=VEND_CD	     Name=거래처코드,		    width=85,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,  edit=none  sort = true</FC>
							<FC>ID=VEND_NM	     Name=거래처명,			width=160,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</FC>
							<C>ID=REMARK	     Name=비고,		    	width=90,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none  sort = true</C>
							<C>ID=STATUS		 Name=상태,			    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,    edit=none,	sort = true, EditStyle=Combo, Data='N:대기,R:승인요청,Y:완료,B:반송', show = true </C>
						    <C>ID=SB_REASON      Name=반송사유,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	 edit=none  sort = true show = true </C>
						">
					 </object></comment><script>__ws__(__NSID__);</script> 
				</td>
			  </tr>
			 </table>

			</td>
			<td>
				<!--입력창 -->
				<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:310px;height:400px;border:1 solid #708090;">
				
				<tr>
				    <td style="width:100px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;거래처코드 </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_cd" class="txtbox" type="text" style="width:100px;position:relative;left:-7px;top:0px;background-color:#d7d7d7"    ReadOnly>
					</td>
				</tr>
				
				<tr>
					<td style="width:100px;height:25px;" bgcolor="#eeeeee"  class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;거래처명 </nobr></td>               
					<td Style="width:200px;height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_vend_nm" class="txtbox" type="text" style="width:190px;position:relative;left:-7px;top:0px"   >
					</td>
				</tr>
				<tr>
				    <td style="width:100px;height:25px;" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;구분 </nobr></td>               
					<td Style="height:25px;border:0 solid #708090;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
							<object id=gcra_vender_usergb classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="width:120px;height:20px;position:relative;top:2px" >
								<param name=Cols	value="2">
								<param name=Enable 	value="true">
								<param name=Format	value="F^해외,K^직원">
							</object>
						</comment><script>__ws__(__NSID__);</script>&nbsp;
						
						<!-- 
						<span id=sp0 style="display:none;">
						<input id="txt_empno_k" class="txtbox" type="text"  maxlength=7 style="width:55px;position:relative;left:-10px;top:-3px"   >
						</span>
						 -->
						</nobr>
					</td>
				</tr>
				
				<tr>
					<td width="80px"   height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;직원명</nobr></td>
					<td class="tab13"  height="25px" style="text-align:left"><nobr>
						<input type="text" class="txtbox" id="txt_empno"  style="position:relative;top:0px;left:4px;width:60px;background-color:#d7d7d7" readOnly>
						<img src="../../Common/img/btn/com_b_find.gif" alt="코드 및 코드명을 검색합니다" style="cursor:hand;position:relative;top:2px;left:0px" onclick="ln_Popup_Empno()">
						<input type="text" class="txtbox" id="txt_empnmk" maxlength=7 style="position:relative;top:0px;left:-4px;width:85px;"></nobr> 
					</nobr></td>
				</tr>
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;비고</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_remark"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:190px;height:20px;">
					</nobr></td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;&nbsp;&nbsp;등록자</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_wrid"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true";>
					</nobr></td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;등록일시</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_wrdt"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
					</nobr></td>
				</tr>
				
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left ><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;상태</nobr></td>
					<td class="tab13" style="text-align:left"><nobr><comment id="__NSID__">
					 		<object id=gclx_status classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
									style="position:relative;left:5px;top:2px;font-size:12px;width:100px;">
										<param name=CBData			         value="N^대기,R^승인요청,Y^완료,B^반송">
										<param name=CBDataColumns	 value="CODE,NAME">
										<param name=SearchColumn	     value=NAME>
										<param name=Sort			             value=false>
										<param name=ListExprFormat       value="NAME">								
										<param name=BindColumn		     value="CODE">
										<param name=Enable                   value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
					</nobr> </td>
				</tr>
				<tr>
					<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=left><nobr>&nbsp;&nbsp;&nbsp;반송사유</nobr></td>
					<td class="tab13" style="text-align:left"><nobr>
					<input id="txt_sb_reason"    type="text"   class="txtbox"  style= "position:relative;left:5px;width:180px;height:20px;background-color:#d7d7d7" readOnly="true"; >
					</nobr></td>
				</tr>
				<tr>
					<td height="202px" align=center colspan=2 > <font color="#ff0000">*</font> 표시건은 필수 항목입니다.
					<br> 해외 - F, 직원 - K 
					
					</td>
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

<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=VEND_CD,       Ctrl=txt_vend_cd         Param=value		</C>
		<C>Col=VEND_NM,       Ctrl=txt_vend_nm         Param=value		</C>
		<C>Col=REMARK,    	  Ctrl=txt_remark          Param=value		</C>
		<C>Col=WRID,      	  Ctrl=txt_wrid            Param=value		</C>
		<C>Col=WRDT,      	  Ctrl=txt_wrdt            Param=value		</C>
		<C>Col=STATUS,   	  Ctrl=gclx_status 	       Param=bindcolval	</C>
		<C>Col=SB_REASON,     Ctrl=txt_sb_reason       Param=value     	</C>
		<C>Col=VENDER_USERGB, Ctrl=gcra_vender_usergb  Param=codevalue	</C>
		<C>Col=EMPNO,   	  Ctrl=txt_empno 	       Param=value   	</C>
		
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



