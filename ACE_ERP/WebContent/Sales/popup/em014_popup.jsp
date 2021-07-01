<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="sales.common.*"%>
<%
/*--------------------------------------------------------------------------------
+ 시스템명 : 인사관리 - 출력일보 - 소속팀 개인별 환경설정
+ 프로그램ID : em014_popup.jsp
+ 기능정의 : 
+ 작 성 자 : 정영식 
+ 작성일자 : 2008.4.11
----------------------------------------------------------------------------------
+ 수정내용 :
+ 수 정 자 : 
+ 수정일자 :
----------------------------------------------------------------------------------
+ 서블릿명 : Em014_S1_Pop
----------------------------------------------------------------------------------*/
%>

<%	// ContextPath 및 기타 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());			
%>

<!-- HTML 시작-->
<html>
<head>
<title>[소속팀별 출력시간 설정]</title>
<jsp:include page="/Sales/common/include/head.jsp"/>

<script language="javascript">

get_cookdata();

//로컬에서 사용하기 위해 임의로 막음.
/*
	var gs_date1 = gcurdate.substring(0,4)+gcurdate.substring(5,7);
	var gs_date2 = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
*/
    var gs_date2 ='<%=firstday%>';
    var gs_date1 =gs_date2.substring(0,6);
    var opener = window.dialogArguments;

/*----------------------------------------------------------------------------
 Description : 페이지 로딩
----------------------------------------------------------------------------*/

function ln_Start(){
	ln_before();

	txt_deptcd.value= opener.gclx_dept_cd.bindcolval;
  txt_deptnm.value= opener.gclx_dept_cd.text; 
	txt_teamcd.value= opener.gclx_team_cd.bindcolval;
	txt_teamnm.value= opener.gclx_team_cd.text;


}
/*----------------------------------------------------------------------------
 Description : 조회
----------------------------------------------------------------------------*/
function ln_Query(){

	if(!ln_Query_Chk()) return;

	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_S1_Pop?"
									 +"v_str1=" + txt_deptcd.value 
									 +"&v_str2="+ txt_teamcd.value;
											
	//prompt('',gcds_data.DataID);
	gcds_data.Reset();
}


/*----------------------------------------------------------------------------
 Description : 조회시 필수항목체크 (휴가대상일자)
----------------------------------------------------------------------------*/
function ln_Query_Chk(){

  /*
	if(fn_trim(gcem_start_dt.text)==""||fn_trim(gcem_end_dt.text)==""){
		alert("휴가대상일자는 필수항목입니다.");
		return false;
	}

  if(fn_trim(gcem_start_dt.text).length!=8||fn_trim(gcem_end_dt.text).length!=8){
		alert("휴가대상일자를 정확하게 입력하십시요.");
		return false;
	}
	*/

	return true;
}
/*----------------------------------------------------------------------------
 Description : 조회
----------------------------------------------------------------------------*/
function ln_before(){
	 //gcem_start_dt.text = gs_date1;
   //gcem_end_dt.text = gs_date2;
	 //근속년차  
	 gcds_cm017.DataID="<%=dirPath%>/servlet/sales.em.Em_com_s1?v_str1=CM017";
	 gcds_cm017.Reset();

	 	//근무구분  
	 gcds_cm014.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM014";
	 gcds_cm014.Reset();

	  	//근무구분  
	 gcds_cm014_S.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM014";
	 gcds_cm014_S.Reset();
}

/*----------------------------------------------------------------------------
	Description : 사원찾기
----------------------------------------------------------------------------*/
function ln_Find(){//성명조회

  var arrParam	= new Array();
	var strURL   = "../em/Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);
	
	if (arrResult != null) {
		arrParam = arrResult.split(";");
		txt_empno.value = arrParam[0];
		txt_empnmk.value = arrParam[1];
	} else {
		txt_empno.value = "";
		txt_empnmk.value = "";
	}
}


/*----------------------------------------------------------------------------
 Description : 창닫기
----------------------------------------------------------------------------*/
function ln_Close() {
 
  window.close();

}
/*----------------------------------------------------------------------------
 Description : 창닫기
----------------------------------------------------------------------------*/
function ln_Select() {
 /*
 if (gcds_data.countrow>1) {
  var row = gcds_data.rowposition;
   window.returnValue =  gcds_data.namevalue(row,"CUST_NM")
									+ ";"+ gcds_data.namevalue(row,"CUST_SID")
									+ ";"+ gcds_data.namevalue(row,"BIRTHDAY")
									+ ";"+ gcds_data.namevalue(row,"SEX")
									+ ";"+ gcds_data.namevalue(row,"PASS_NO")
									+ ";"+ gcds_data.namevalue(row,"PASS_EXPIRE_DATE")
									+ ";"+ gcds_data.namevalue(row,"N_CARD_NO")
									+ ";"+ gcds_data.namevalue(row,"COUNTRY_CD")
									+ ";"+ gcds_data.namevalue(row,"TEL_NO")
									+ ";"+ gcds_data.namevalue(row,"MOBILE_NO")
									+ ";"+ gcds_data.namevalue(row,"ZIP_CD")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS1")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS2")
									+ ";"+ gcds_data.namevalue(row,"USTS")
									+ ";"+ gcds_data.namevalue(row,"ENG_NM");
  window.close();
 } else {
  window.close();
 }
 */
}


/*----------------------------------------------------------------------------
 Description : 일괄변경
----------------------------------------------------------------------------*/
function ln_Change(){
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			gcds_data.namevalue(i,"WORK_GB")=gclx_work_gb.bindcolval;
			gcds_data.namevalue(i,"W_TIME")=fn_trim(gcem_w_time.text);
			gcds_data.namevalue(i,"W2_TIME")=fn_trim(gcem_w2_time.text);
			gcds_data.namevalue(i,"W_TIME_TOT")=gcem_w_time_tot.text;

			gcds_data.namevalue(i,"W_REMARK")=txt_w_remark.value;
			gcds_data.namevalue(i,"O_TIME")=gcem_o_time.text;
			gcds_data.namevalue(i,"O2_TIME")=gcem_o2_time.text;
			gcds_data.namevalue(i,"O3_TIME")=gcem_o3_time.text;
			gcds_data.namevalue(i,"O4_TIME")=gcem_o4_time.text;
			gcds_data.namevalue(i,"O_TIME_TOT")=gcem_o_time_tot.text;
			gcds_data.namevalue(i,"O_DTIME")=gcem_o_dtime.text;
			gcds_data.namevalue(i,"O_NTIME")=gcem_o_ntime.text;
			gcds_data.namevalue(i,"O_REMARK")=txt_o_remark.value;

		}
	}
}


/*----------------------------------------------------------------------------
 Description : 
----------------------------------------------------------------------------*/
function ln_Change2(){
    for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.SysStatus(i)==3){
		   gcds_data.namevalue(i,"O_TIME_TOT")=gcds_data.namevalue(i,"O_DTIME")+gcds_data.namevalue(i,"O_NTIME");
		}
	}
}

/*----------------------------------------------------------------------------
 Description : 저장
----------------------------------------------------------------------------*/
function ln_Save(){
  
	//if(!ln_Save_Chk()) return;
	if (gcds_data.IsUpdated) {
		if(confirm("정보를 저장하시겠습니까?")){
		        ln_Change2();
		     
				gctr_data.KeyValue = "Em014_t2(I:USER=gcds_data)";
				gctr_data.action = "<%=dirPath%><%=HDConstant.PATH_EM%>Em014_t1_Pop?";
				//gctr_data.Parameters = "v_str1="+gusrid
			   gctr_data.Parameters = "v_str1=6070001";
				//prompt(this,gcds_data.text);
				gctr_data.post();
		}
	}
}

 function ln_Sum(){
		if(fn_trim(gcem_o_dtime.text)=="")gcem_o_dtime.text=0;
		if(fn_trim(gcem_o_ntime.text)=="")gcem_o_ntime.text=0;

		gcem_o_time_tot.text = parseFloat(gcem_o_dtime.text) + parseFloat(gcem_o_ntime.text);
}


</script>
<!-----------------------------------------------------------------------------
  DataSet Components(DS) 선언 시작
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm014 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_cm014_S classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<!-- 민족 -->
<comment id="__NSID__"><OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<PARAM NAME="SortExpr" value="+COM_SNAME">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
     D A T A S E T   C O M P O N E N T' S
  M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.CHK="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	window.CHK="조회가 완료 되었습니다.";
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	if (row <1) {
	alert("검색된 데이터가 없습니다.");
	}
</script>


<script language=JavaScript for=gcgd_disp event=OnClick(row,colid)>
	if(row<1&&colid=="CHK"){
		if(gcds_data.namevalue(1,colid)=="T"){
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="F";
			}
		}else{
			for(i=1;i<=gcds_data.countrow;i++){
				gcds_data.namevalue(i,colid)="T";
			}
		}
	}
</script>

<script language=JavaScript for=gcgd_disp event=OnDblClick(row,colid)>
  /*
	if (gcds_data.countrow>1) {
  var row = gcds_data.rowposition;
   window.returnValue =  gcds_data.namevalue(row,"CUST_NM") 
									+ ";"+ gcds_data.namevalue(row,"CUST_SID")
									+ ";"+ gcds_data.namevalue(row,"BIRTHDAY")
									+ ";"+ gcds_data.namevalue(row,"SEX")
									+ ";"+ gcds_data.namevalue(row,"PASS_NO")
									+ ";"+ gcds_data.namevalue(row,"PASS_EXPIRE_DATE")
									+ ";"+ gcds_data.namevalue(row,"N_CARD_NO")
									+ ";"+ gcds_data.namevalue(row,"COUNTRY_CD")
									+ ";"+ gcds_data.namevalue(row,"TEL_NO")
									+ ";"+ gcds_data.namevalue(row,"MOBILE_NO")
									+ ";"+ gcds_data.namevalue(row,"ZIP_CD")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS1")
									+ ";"+ gcds_data.namevalue(row,"ADDRESS2")
									+ ";"+ gcds_data.namevalue(row,"USTS")
									+ ";"+ gcds_data.namevalue(row,"ENG_NM");
  window.close();
 }
 */
</script>
<script language=JavaScript for=gcem_o_dtime event=onKillFocus()>
    ln_Sum();
</script>

<script language=JavaScript for=gcem_o_ntime event=onKillFocus()>
    ln_Sum();
</script>

<script lanaguage=JavaScript for=gcem_o_dtime event=OnLastDownChar(char)>
	  ln_Sum();
</script>

<script lanaguage=JavaScript for=gcem_o_ntime event=OnLastDownChar(char)>
    ln_Sum();
</script>


<script language=JavaScript for=gctr_data event=OnFail()>

	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");

</script>



<!-----------------------------------------------------------------------------
      B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
 
<table cellpadding="0" cellspacing="0" border="0" width="780" height="690">
	<tr height="5"><td>&nbsp;</td></tr>
	<tr height="25">
		<td>
			<td align="right">
			<img src="<%=dirPath%>/Sales/images/p_find.gif"    style="cursor:hand" onclick="ln_Query()">
			<!-- <img src="<%=dirPath%>/Sales/images/p_select.gif"  style="cursor:hand" onclick="ln_Select()">&nbsp; -->
			<img src="<%=dirPath%>/Sales/images/save.gif"	      style="cursor:hand" onClick="ln_Save()">
			<img src="<%=dirPath%>/Sales/images/p_exit.gif"   	style="cursor:hand" onclick="ln_Close()">
		</td>
	</tr>
	<tr height="25">
		<td colspan="2" >
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:780px;height:25px;font-size:12px;" bgcolor="#708090">
				<tr>
					<td align="center" bgcolor="#eeeeee" width="80px">부서</td>
					<td  bgcolor="#FFFFFF" >
						<input type="text" id="txt_deptcd" style="position:relative;;left:8px;width:70px;top:0px;" readonly>&nbsp;
						<input type="text" id="txt_deptnm" style="position:relative;;left:8px;width:100px;top:0px;" readonly>&nbsp;
					</td>
					<td align="center" bgcolor="#eeeeee" width="80px">소속팀</td>
					<td bgcolor="#FFFFFF" >
						<input type="text" id="txt_teamcd" style="position:relative;;left:8px;width:70px;top:0px;" readonly>&nbsp;
						<input type="text" id="txt_teamnm" style="position:relative;;left:8px;width:100px;top:0px;" readonly>&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
  <tr height="3">
     <td colspan="2" ></td>
	</tr>
	<tr height="25">
		<td colspan="2" >
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:780px;height:25px;font-size:12px;" bgcolor="#708090">
				<tr>
					<td align="center" bgcolor="#B3D392" width="50px" rowspan=2>일괄변경</td>
					<td align="center" bgcolor="#D0F2ED" width="50px">근무구분</td>
					<td  bgcolor="#FFFFFF" >
						 <%=HDConstant.COMMENT_START%>
							<OBJECT id=gclx_work_gb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:8px;top:1px;font-size:12px;width:80px;">
							<param name=ComboDataID			value="gcds_cm014_S">
							<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
							<param name=SearchColumn		value=COM_SNAME>
							<param name=Sort						value=false>
							<param name=Index						value=0>
							<param name=ListExprFormat	value="COM_SNAME^0^80">
							<param name=BindColumn			value=COM_CODE>
							</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" bgcolor="#D0F2ED" width="50px">근무시간</td>
					<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_w_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:1px; width:35px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="##:##">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=PromptChar	value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<span style="position:relative;left:8px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_w2_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:1px; width:35px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="##:##">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=PromptChar	value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" bgcolor="#D0F2ED" width="50px">작업내용</td>
					<td bgcolor="#FFFFFF" >
						<textarea id="txt_w_remark" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
					</td>
          <td align="center" bgcolor="#D0F2ED" width="80px">계</td>
					<td bgcolor="#FFFFFF" >
						  <%=HDConstant.COMMENT_START%><OBJECT id=gcem_w_time_tot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:1px; width:35px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=2>
							<param name=Border	      value=true>
							<param name=Numeric       value="true">
							<param name=MaxLength     value=2>
							<param name=MaxDecimalPlace  value=1>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							</OBJECT><%=HDConstant.COMMENT_END%>&nbsp;&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/btn_change.gif"   	style="cursor:hand;position:relative;left:8px;" onclick="ln_Change()">
					</td>
				 </tr>
				 <tr>
					<td align="center" bgcolor="#D0F2ED" width="50px">OT시간1</td>
					<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:3px; width:35px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="##:##">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=PromptChar	value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<span style="position:relative;left:8px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o2_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:3px; width:35px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="##:##">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=PromptChar	value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" bgcolor="#D0F2ED" width="50px">OT시간2</td>
					<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o3_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:3px; width:35px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="##:##">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=PromptChar	value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
								<span style="position:relative;left:8px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%><OBJECT id=gcem_o4_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:3px; width:35px;  font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="##:##">
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=PromptChar	value="_">
							</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
					<td align="center" bgcolor="#D0F2ED" width="50px">작업내용</td>
					<td bgcolor="#FFFFFF" >
						<textarea id="txt_o_remark" class="txtbox"  style= "width:125px; height:20px; overflow:auto;position:relative;left:7px" maxlength="20" onBlur="bytelength(this,this.value,40);"></textarea>&nbsp;
					</td>
					<td align="center" bgcolor="#D0F2ED" width="80px">주간|야간|계</td>
					<td bgcolor="#FFFFFF" >
						  <%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_dtime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:3px; width:35px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=2>
							<param name=Border	      value=true>
							<param name=Numeric       value="true">
							<param name=MaxLength     value=2>
							<param name=MaxDecimalPlace  value=1>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							</OBJECT><%=HDConstant.COMMENT_END%>
							<span style="position:relative;left:8px;top:-4px;">&nbsp;|</span>
							 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_ntime classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative; left:8px;top:3px; width:35px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=2>
							<param name=Border	      value=true>
							<param name=Numeric       value="true">
							<param name=MaxLength     value=2>
							<param name=MaxDecimalPlace  value=1>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							</OBJECT><%=HDConstant.COMMENT_END%>
							<span style="position:relative;left:8px;top:-4px;">&nbsp;|</span>
							 <%=HDConstant.COMMENT_START%><OBJECT id=gcem_o_time_tot classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:8px;top:3px; width:35px; font-family:굴림; font-size:9pt;z-index:2; ">
							<param name=Alignment			value=2>
							<param name=Border	      value=true>
							<param name=Numeric       value="true">
							<param name=MaxLength     value=2>
							<param name=MaxDecimalPlace  value=1>
							<param name=ReadOnly      value="true">
              <param name=ReadOnlyBackColor   value="#CCFFCC">
							</OBJECT><%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr height="100%">
		<td colspan="2" valign="top"><br>
			<table cellpadding="0" cellspacing="1" style="position:relative;left:5px;width:780px;height:260px;" bgcolor="#708090">
				<tr >
					<td valign="top" bgcolor="#FFFFFF" width="780px" >
							<comment id="__NSID__">
							<OBJECT id=gcgd_disp  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="position:relative;left:0px;width:782px;height:240px;font-size:12px;">
							<param name=DataID					value=gcds_data>
							<param Name=BorderStyle			value=0> 
							<param name=indwidth				value=0>
							<param name=Editable				value=true>
							<param name=fillarea				value=true>
							<param name=colsizing				value=true>
							<param name=UsingOneClick		value=true>
							<param name=TitleHeight			value=20>
							<param name=SortView        value="Left">
							<param name=format					value='
							<FC>ID={CurRow}   ,	Name="No",       width=26,	 HeadBgColor=#B9D4DC  HeadAlign=Center  align=center  edit=none</FC> 
							<FC>ID=CHK			   ,  Name="선택",     width=32,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  EditStyle=CheckBox </FC>
							<FC>ID=DEPT_NM	   ,  Name="부서",     width=110,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left    edit=none  sort = true</FC>
							<FC>ID=TEAM_NM	   ,  Name="소속",     width=120,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left    edit=none  sort = true</FC>
							<FC>ID=EMPNO	     ,  Name="사번",     width=55,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  edit=none  sort = true</FC>
							<FC>ID=EMPNMK     ,  Name="성명",     width=60,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left    edit=none  sort = true</FC>
							<C>ID=WORK_GB  ,  Name="근무구분", width=75,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left    EditStyle=Lookup Data="gcds_cm014:COM_CODE:COM_SNAME" sort=true</C>
							<G> Name="근무시간", HeadBgColor=#B9D4DC,	 HeadAlign=center
								<C>ID=W_TIME    ,  Name="FROM", width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  mask="XX:XX"  </C>
								<C>ID=W2_TIME   ,  Name="TO",   width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  mask="XX:XX"  </C>
								<C>ID=W_TIME_TOT , Name="계",   width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=right    </C>
                <C>ID=W_REMARK   , Name="작업내용",  width=120,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left    </C>
							</G>
							<G> Name="OT시간1", HeadBgColor=#B9D4DC,	 HeadAlign=center
								<C>ID=O_TIME    ,  Name="FROM", width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  mask="XX:XX"  </C>
								<C>ID=O2_TIME   ,  Name="TO",   width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  mask="XX:XX"  </C>
							</G>
							<G> Name="OT시간2", HeadBgColor=#B9D4DC,	 HeadAlign=center
								<C>ID=O3_TIME    , Name="FROM", width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  mask="XX:XX"  </C>
								<C>ID=O4_TIME   ,  Name="TO",   width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=center  mask="XX:XX"  </C>
							</G>
							<G> Name="OT시간", HeadBgColor=#B9D4DC,	 HeadAlign=center
								<C>ID=O_DTIME ,    Name="주간",   width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=right  edit =RealNumeric  </C>
								<C>ID=O_NTIME ,    Name="야간",   width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=right  edit =RealNumeric  </C>
								<C>ID=O_TIME_TOT , Name="계",     width=38,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=right  value ={O_DTIME+O_NTIME} edit=none  dec=1</C>
								<C>ID=O_REMARK   , Name="작업내용",  width=120,	 HeadBgColor=#B9D4DC,	HeadAlign=center  align=left    </C>
							</G>
							'>
							</OBJECT></comment><script>__ws__(__NSID__);</script>	
							<fieldset style="width:782;height:20px;;border:0 solid #708090;border-top-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
							</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</body>
</html>