<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*******************************************************************************
* 시 스 템 명	: 정보보보>정보관리>수신열람관리>수신열람확인
* 프로그램 ID	: li0101S.jsp
* 기 능 정 의	: 정보조회
* 작  성   자 : 정 영 식
* 작 성 일 자 : 2011.10.26
-----------------------------------------------------------------------------
* 수 정 내 용 : 
* 수   정  자 :
* 수 정 일 자 : 
-----------------------------------------------------------------------------
* 서 블 릿 명	: 
* PROCEDURE 	: 
*******************************************************************************/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="security.common.*" %>

<%
// Description 	:  JAVA Import 끝
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath 변수 설정.
  String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 
%>

<html>
<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>수신열람확인</title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var sApproveLine="";

/******************************************************************************
	Description : 페이지 로딩
****************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
    fnInit();
    txt_rcp_dpt.value = gdeptcd;
    txt_rcp_dptnm.value = gdeptnm;
    
    txt_rcp_psn.value = gusrid;
    txt_rcp_psnnm.value = gusrnm;
}

/******************************************************************************
	Description : 초기화 
****************************************************************************/
function fnInit(){
	ds_doc_grd.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI001&s_item1=Y";
    ds_doc_grd.Reset(); //문서등급
    
    ds_doc_frm.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI002&s_item1=Y";
    ds_doc_frm.Reset(); //문서형태
    
    ds_crt_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI003&s_item1=Y";
    ds_crt_div.Reset(); //생성구분
    
    ds_rcp_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=LI004&s_item1=Y";
    ds_rcp_sts.Reset(); //수신열람
    
    ds_snd_div.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=LI005&s_item1=Y";
    ds_snd_div.Reset(); //발신구분
    
    ds_sgn_sts.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=AP002&s_item1=Y";
    ds_sgn_sts.Reset(); //결재상태
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function fnSelect() {

	 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		              + ",v_doc_grd="+gclx_doc_grd.bindcolval
		              + ",v_doc_frm=" +gclx_doc_frm.bindcolval
		              + ",v_rcp_dpt=" + txt_rcp_dpt.value
		              + ",v_sgn_sts=" +gclx_sgn_sts.bindcolval
		              + ",v_rcp_sts=" +gclx_rcp_sts.bindcolval
		              + ",v_rcp_psn=" + txt_rcp_psn.value
		              + ",v_doc_tle=" + gcem_doc_tle.text
		              + ",v_doc_cts=" + gcem_doc_cts.text
		              + ",v_doc_kwd=" + gcem_doc_kwd.text;
              
    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Li0300I",  "JSP(O:DS_DEFAULT=ds_default)",  param);
       
    tr_post(tr1);
}

/******************************************************************************
	Description : 확인 저장 
	                     문서 등록에 저장됨 
******************************************************************************/
 function fnApply() {
 
    if (ds_default.IsUpdated) {
        if (fnChk()) {
            ln_TRSetting(tr1, "<%=dirPath%><%=HDConstant.PATH_LI%>Li0300I",  "JSP(I:DS_DEFAULT=ds_default )",  "proType=A");
            //prompt('',ds_default.text);
            tr_post(tr1);
        }
    }
}


/******************************************************************************
	Description : 확인 저장시 체크
******************************************************************************/
 function fnChk() {    
 
   // return true;
    
    var row=0;
 
    for (var i=1; i<=ds_default.countrow;i++) {
		if(ds_default.namevalue(i,"CHK") =="T") {
			row = i; 
		}
	}
	
	if(row==0){
		alert("선택을 하지 않았습니다.");
		return false;
	}
 
   //임시막음
 	if(ds_default.namevalue(row,"RCP_SGN_STS")!=3){ //최종승인
 		alert("결재상태가 [최종승인]건만 수신확인 가능합니다.");
 		return false;
 	}
 	
 	
 	ds_default.namevalue(i,"RCP_DT")=gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10); 
 	
 	      
  	return true;
}


/******************************************************************************
	Description : 결재선  popup
******************************************************************************/
function fnApproval() {
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;
	var strPos;
	strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
	strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";

	arrResult = showModalDialog(strURL,arrParam,strPos);
	sApproveLine = arrResult; // ru
}

/******************************************************************************
	Description : 기안  popup
******************************************************************************/
function fnDraft() {
    var row; 
    var strGB="030";

	if(ds_default.CountRow ==0){
		alert("기안 할 내용을 조회 해 주세요");
		return;
	}
	
	if(ds_default.namevalue(ds_default.rowposition,"DOC_GRD")!="1"){
		alert("문서등급이 기밀만 기안 가능합니다.");
		return;
	}
		
	
	if(sApproveLine==""||sApproveLine=="undefined"){
	   alert("결재선지정이 되지 않았습니다.");
	   return;
	}
	
	
	if(ds_default.namevalue(ds_default.rowposition,"RCP_SGN_STS")!="1"){
		alert("결재상태가 작성 중인 건만 기안 가능합니다.");
		return;
	}
	
	var arrParam	= new Array();
		
	arrParam[0]=strGB;  // AP006 ( 010 정보등록 , 020 정보배포, 030 정보수신, 040 정보열람, 100 서비스요청 
	arrParam[1]=ds_default.namevalue(ds_default.rowposition,"RCP_RDG_SID");  //수신열람번호 
	arrParam[2]=sApproveLine;      // 결재선정보 
	arrParam[3]=ds_default.namevalue(ds_default.rowposition,"RCP_DPT");  // 수신부서
	
	//alert("arrParam[3]"+arrParam[3]);
	
	strURL = "<%=dirPath%>/Security/help/li0300h.jsp?";
	strPos = "dialogWidth:740px;dialogHeight:480px;status:no;scroll:no;resizable:no";
	
	arrResult = showModalDialog(strURL,arrParam,strPos);
}
	
	
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr   value="-RCP_RDG_SID">
</object>

<object  id=ds_doc_grd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_doc_frm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_crt_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_rcp_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_snd_div classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_sgn_sts classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
</comment><script>__ws__(__NSID__);</script>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="ds_default" event="OnLoadStarted()">
	
</script>

<script language="javascript" for="ds_default" event="onloadCompleted(row,colid)">
  
    ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	
	if(ds_default.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}
</script>

<script language="javascript" for="ds_doc_grd" event="onloadCompleted(row,colid)">
  
  //alert("ds_doc_grd::"+ds_doc_grd.countrow);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

 <script language="javascript"  for=gcgd_disp01 event="OnClick(row,colid)">
	if (colid =="CHK") {
		for (var i=1; i<=ds_default.countrow;i++) {
			if(i != row) {
				ds_default.namevalue(i,"CHK") = "F";
			}
		}
	}
</script>


<!-- 그리드 선택일괄 체크 이벤트 -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>


</HEAD>
<jsp:include page="/Common/sys/body_s09.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	    <td align=left >
			<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnApproval()">
			<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:hand" onclick="fnDraft()">
		</td>
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
			<img src="<%=dirPath%>/Sales/images/b_ok.gif"		style="cursor:hand" onclick="fnApply()">
		</td>
	</tr>
</table>

<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="80px"   class="tab25" bgcolor="#eeeeee" align=center>문서등급</td>
		<td width="120px" class="tab24"  >&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_grd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	value="ds_doc_grd">
				<param name=BindColumn      value="detail">
                <param name=BindColVal        value="detail">
                <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                <param name=ListExprFormat  value="detail_nm^0^100">
			</object>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
		<td width="80px"  class="tab24"  bgcolor="#eeeeee" align=center>문서형태</td>  
	    <td width="120px" class="tab24">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_doc_frm classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_doc_frm">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px;" class="tab24"  bgcolor="#eeeeee" align=center>수신부서</td> 
		<td class="tab24" >&nbsp;
			<input type="text" class="txt11" id="txt_rcp_dpt"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_rcp_dptnm"  style="position:relative;left:-4px;width:180px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	<tr> 
		<td width="80px"    class="tab30"  bgcolor="#eeeeee" align=center>결재상태</td>
		 <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_sgn_sts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_sgn_sts">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px"    class="tab28"  bgcolor="#eeeeee" align=center>수신상태</td>
		 <td width="120px" class="tab28">&nbsp;
			<comment id="__NSID__">
			<object  id=gclx_rcp_sts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:0px;top:1px;font-size:12px;width:100px;">
				<param name=ComboDataID	  	value="ds_rcp_sts">
				<param name=CBDataColumns   value="detail, detail_nm">
				<param name=SearchColumn		value=detail_nm>
				<param name=ListExprFormat	    value="detail_nm^0^100">
				<param name=BindColumn			value="detail">
			</object>
			</comment><script>__ws__(__NSID__);</script> 
		</td>
		<td width="80px"    class="tab28"  bgcolor="#eeeeee" align=center>수신자</td>
		 <td class="tab28">&nbsp;
			<input type="text" class="txt11" id="txt_rcp_psn"       style="position:relative;left:-4px;width:50px;background-color:#d7d7d7" readOnly>
			<input type="text" class="txt11" id="txt_rcp_psnnm"  style="position:relative;left:-4px;width:180px;background-color:#d7d7d7" readOnly>
		</td>
	</tr>
	
	
	<tr> 
		<td width="80px"    class="tab30"  bgcolor="#eeeeee" align=center>제목</td>
		<td class="tab28"  colspan =5 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_tle classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>내용</td>
		<td class="tab28" colspan =5 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_cts classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	<tr> 
		<td width="80px"  class="tab30" bgcolor="#eeeeee" align=center>키워드</td>
		<td class="tab28" colspan =5 >&nbsp;
			<comment id="__NSID__">
			<OBJECT id=gcem_doc_kwd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:683px">
				<param name=Text				value="">
				<param name=Alignment		value=0>
				<param name=Border			value= true>
				<param name=Enable			value="true">
				<param name=GeneralEdit   value="true">
				
			</OBJECT>
			</comment><script>__ws__(__NSID__);</script>
		</td> 
	</tr>
	
</table>

<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
	<tr> 
		<td>
			<comment id="__NSID__">
			<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:0px;width:858px; height:350px; border:1 solid #708090;display:block;" viewastext>
					<param name="DataID"		 value="ds_default">
					<param name="IndWidth"		 value='0'>
					<param name="BorderStyle"  value="0">
					<param name="Fillarea"		 value="true">
					<param name="Sortview"		 value="left">
					<param name="ColSizing"	 value="true">
					<param name="Editable"		 value="TRUE"> 
					<param name=TitleHeight      value="20">
					<param name=UsingOneClick  value="1">
					<param name="Format"	 	 value=" 
					<C> Name='선택'		          ID=CHK                     HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=center  EditStyle=CheckBox	     </C>
					<C> Name='등록번호'		  ID=DOC_MAG_SID     HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=right    edit = none  </C>
					<C> Name='배포번호'		  ID=DTB_MAG_SID     HeadAlign=Center HeadBgColor=#B9D4DC Width=65	    align=right    edit = none  </C>
					<C> Name='순번' 	              ID=DTB_SEQ            HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=right    edit = none </C>
                    <C> Name='수신번호'          ID=RCP_RDG_SID    HeadAlign=Center HeadBgColor=#B9D4DC Width=65 	align=right    edit = none </C>
                    <C> Name='생성' 	              ID=CRT_DIV              HeadAlign=Center HeadBgColor=#B9D4DC Width=30 	align=center      edit = none  EditStyle=Lookup	Data='ds_crt_div:detail:detail_nm'  </C>
                    <C> Name='등급'  	          ID=DOC_GRD	          HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=left      edit = none  EditStyle=Lookup	Data='ds_doc_grd:detail:detail_nm' </C>
					<C> Name='형태'  	          ID=DOC_FRM	          HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=left      edit = none  EditStyle=Lookup	Data='ds_doc_frm:detail:detail_nm' </C>
					<C> Name='제목'      	      ID=DOC_TLE             HeadAlign=Center HeadBgColor=#B9D4DC Width=160 	align=left      edit = none  </C>
					<C> Name='배포부서'  	      ID=OWN_DPT_NM     HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left      edit = none  </C>
					<C> Name='발신구분'  	      ID=SND_DIV	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      edit = none  EditStyle=Lookup	Data='ds_snd_div:detail:detail_nm' </C>
					<C> Name='결재상태'	      ID=RCP_SGN_STS    HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=left      edit = none  EditStyle=Lookup	Data='ds_sgn_sts:detail:detail_nm'   </C>
					<C> Name='수신상태'          ID=RCP_STS	          HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=left      edit = none  EditStyle=Lookup	Data='ds_rcp_sts:detail:detail_nm'  </C>
					">
			</object></comment><script>__ws__(__NSID__);</script>
			<fieldset style="position:relative;left:0px;width:860px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
			&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font></fieldset>
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 