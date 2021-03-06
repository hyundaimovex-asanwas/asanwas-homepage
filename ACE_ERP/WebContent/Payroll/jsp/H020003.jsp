<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	인사
+ 프로그램 ID	: H020003.HTML
+ 기 능 정 의	: 조회
+ 변 경 이 력	: 
+ 서 블 릿 명	: h020003_s1, h020004_s2, h020002_s9
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>채용진행조회</title>

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
get_cookdata();
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	var ls_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);

	//응시분야
	gcds_before.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h020004_s2?v_str1=" + ls_date;
	gcds_before.Reset();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	txt_msg.value = "";
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h020003_s1?"
									 + "v_str1=" + fn_trim(gcem_resino.text)
									 + "&v_str2=" + fn_trim(gclx_info.bindcolval);
	gcds_data.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

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
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gcds_before classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_before" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";

	if (row<1) {
		photo.src = "photo/00000.gif";
		txt_msg.value = "";
		alert("검색된 데이터가 없습니다.");
		return;
	}

	var str1 = gclx_info.bindcolval;
	var str2 = gcds_data.namevalue(1,"resino");
	if (fn_trim(gcds_data.namevalue(1,"PHOTO"))=="") photo.src = "photo/00000.gif";
	else photo.src = "<%=dirPath%><%=HDConstant.PATH_PERSON%>h020002_s9?v_str1="+str1+"&v_str2="+str2;
	
	var ls_msg = "";
	var ls_pam = "";
	var ls_gbn = gcds_data.namevalue(1,"PROSTS");
	var ls_intdt = fn_trim(gcds_data.namevalue(1,"INTDT"));
	var ls_passdt = fn_trim(gcds_data.namevalue(1,"PASSDT"));
	var ls_inttm = fn_trim(gcds_data.namevalue(1,"INTTM"));

	if (ls_gbn=="2"){
		var ls_date = ls_intdt.substring(0,4) + "년"+ ls_intdt.substring(4,6) +"월"+ ls_intdt.substring(6,8)+ "일 " + ls_inttm.substring(0,2) + "시" + ls_inttm.substring(2,4) + "분 입니다.\n\n ";
	}

	ls_pam = "\n ";
	if (ls_gbn=="4") {
		ls_msg = "NORMEMO";
	} else if (ls_gbn=="3") {
		ls_msg = "PMEMO";
	} else if (ls_gbn=="2") {
		ls_msg = "IMEMO";
		ls_pam = "귀하의 면접일자는 " + ls_date;
	} else if (ls_gbn=="1") {
		ls_msg = "RMEMO";
	}

	var tText = ls_pam + gcds_data.namevalue(row,ls_msg)
	txt_msg.value = tText;

</script>

<script language="javascript" for="gcds_before" event="onloadcompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data" event="onloadError()">
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
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
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td><img src="../img/h020003_head.gif"></td>
    <td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_Query()">&nbsp;
		</td>
  </tr>
	<tr>
		<td colspan=2> 
			<table cellpadding="0" cellspacing="0" border="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;border:1 solid #708090">
        <tr> 
					<td style="width:100px;border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center><nobr>주민번호</td>
					<td width="200">
						<comment id="__NSID__"><object id=gcem_resino classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:3px; width:95px; height:17px; font-family:굴림; font-size:9pt;z-index:2;" onkeydown="if(event.keyCode==13) ln_Query();">
								<param name=Alignment			value="0">
								<param name=Border	      value="false">
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="_">
					  </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td style="width:100px;border:0 solid #708090;border-left-width:1px;border-right-width:1px;" align="center" bgcolor="#eeeeee">응시분야</td>
					<td>
 						<comment id="__NSID__"><object id=gclx_info classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
 							style="position:relative;left:8px;top:0px;font-size:12px;width:250px;">
								<param name=ComboDataID			value="gcds_before">
								<param name=CBDataColumns		value="INFODIV, DSPNM">
  							<param name=SearchColumn		value="DSPNM">
  							<param name=Sort						value="false">
  							<param name=ListExprFormat	value="DSPNM^0^250">
	 							<param name=BindColumn			value="INFODIV">
 						</object></comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
			</table>
		</td>
	</tr>  
	<tr><td colspan=2 height=3></td></tr>  	
	<tr>
		<td colspan=2> 
			<table cellpadding=0 cellspacing=0  border=0 style="width:876px;font-size:9pt;background-color:#ffffff;border:1 solid #708090;">
				<tr>
					<td class="tab11" style="width:100px;" rowspan=5 valign=middle><IMG id="photo" style="height:110;width:85" src="photo/00000.gif"></td>
					<td class="tab11" style="width:100px;height:25px;" bgcolor="#eeeeee">성명</td>
					<td class="tab21"><input id="txt_nmk" name="txt_nmk" type="text" class="txt11" style="width:80px;border:0;top:2px;" disabled></td>
					<td class="tab11" style="width:100px;height:25px;" bgcolor="#eeeeee">한자명</td>
					<td class="tab21"><input id="txt_nmc" name="txt_nmc" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
					<td class="tab11" style="width:100px;height:25px;" bgcolor="#eeeeee">영문명</td>
					<td class="tab22"><input id="txt_nme" name="txt_nme" type="text" class="txt11" style="width:140px;border:0;top:2px;" disabled></td>
				</tr>
				<tr>
					<td class="tab11" style="width:100px;" bgcolor="#eeeeee">주민등록번호</td>
					<td class="tab21">
						<comment id="__NSID__"><object id=gcem_resino2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:3px; width:100px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="000000-0000000">
								<param name=PromptChar	  value="_">
								<param name=Enable	      value=false>
					  </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" bgcolor="#eeeeee">생년월일</td>
					<td class="tab21">
						<comment id="__NSID__"><object id=gcem_birdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
							style="position:relative; left:8px;top:3px; width:100px; height:17px; font-family:굴림; font-size:9pt;z-index:2; ">
								<param name=Alignment			value=0>
								<param name=Border	      value=false>
								<param name=Format	      value="YYYY년MM월DD일">
								<param name=PromptChar	  value="_">
								<param name=Enable	      value=false>
					  </object></comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab11" bgcolor="#eeeeee">출신도</td>
					<td class="tab22"><input id="txt_bircity" name="txt_bircity" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
				</tr>
				<tr>
					<td class="tab11" bgcolor="#eeeeee">취미</td>
					<td class="tab21"><input id="txt_hobby" name="txt_hobby" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
					<td class="tab11" bgcolor="#eeeeee">종교</td>
					<td class="tab21"><input id="txt_rilign" name="txt_rilign" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
					<td class="tab11" bgcolor="#eeeeee">특기</td>
					<td class="tab22"><input id="txt_special" name="txt_special" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
				</tr>
				<tr>
					<td class="tab11" bgcolor="#eeeeee">집전화</td>
					<td class="tab21"><input id="txt_telno" name="txt_telno" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
					<td class="tab11" bgcolor="#eeeeee">휴대폰</td>
					<td class="tab21"><input id="txt_hpno" name="txt_hpno" type="text" class="txt11" style="width:120px;border:0;top:2px;" disabled></td>
					<td class="tab11" bgcolor="#eeeeee">이메일</td>
					<td class="tab22"><input id="txt_email" name="txt_email" type="text" class="txt11" style="width:150px;border:0;top:2px;" disabled></td>
				</tr>
				<tr>
					<td class="tab11" bgcolor="#eeeeee">현재 주소</td>
					<td colspan=5 class="tab22">
						<table cellspacing=0 cellpadding=0 border=0>
							<tr>
								<td>
									<comment id="__NSID__"><object id=gcem_czipcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
										style="position:relative; left:8px;top:3px; width:50px; height:17px; font-family:굴림; font-size:9pt;z-index:2; " class=objclsEme1>
											<param name=Alignment			value=0>
											<param name=Border	      value=false>
											<param name=Format	      value="000-000">
											<param name=PromptChar	  value="_">
											<param name=Enable	      value=false>
								  </object></comment><script>__ws__(__NSID__);</script>
								</td>
								<td><input id="txt_caddr" name="txt_caddr" type="text" class="txt11" style="width:400px;border:0;top:2px;" disabled></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tab12" bgcolor="#eeeeee">&nbsp;</td>
					<td class="tab12" bgcolor="#eeeeee">현재 상태</td>
					<td colspan=5>
						<table cellspacing=0 cellpadding=0 border=0>
							<tr>
								<td>
									<comment id="__NSID__"><object id=gcra_prosts classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0
										style="position:relative;left:8px;top:0px;height:20;width:300;cursor:hand;">
											<param name=Cols     value="4">
											<param name=enable	 value=0>
											<param name=Format   value="1^접수,2^면접,3^합격,4^불합격">
									</object></comment><script>__ws__(__NSID__);</script>

								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>  	
	<tr><td colspan=2 height=12></td></tr>  	
	<tr><td colspan=2 height=3><b>채용안내정보</b></td></tr>  	
	<tr>
		<td colspan=2> 
			<textarea id="txt_msg" style="font-family:굴림;font-size:9pt;height:270px;width:876px;border:1 solid #999999" disabled></textarea>
		</td>
	</tr>  	
</table>

<comment id="__NSID__"><object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
		<C>Col=NMK        Ctrl=txt_nmk         Param=value</C>
		<C>Col=NMC        Ctrl=txt_nmc         Param=value</C>
		<C>Col=NME        Ctrl=txt_nme         Param=value</C>
		<C>Col=RESINO     Ctrl=gcem_resino2    Param=text</C>
		<C>Col=BIRDT      Ctrl=gcem_birdt      Param=text</C>
		<C>Col=MINORNM    Ctrl=txt_bircity     Param=value</C>
		<C>Col=HOBBY      Ctrl=txt_hobby       Param=value</C>
		<C>Col=RILIGN     Ctrl=txt_rilign      Param=value</C>
		<C>Col=SPECIAL    Ctrl=txt_special     Param=value</C>
		<C>Col=TELNO      Ctrl=txt_telno       Param=value</C>
		<C>Col=HPNO       Ctrl=txt_hpno        Param=value</C>
		<C>Col=EMAIL      Ctrl=txt_email       Param=value</C>
		<C>Col=CADDR      Ctrl=txt_caddr       Param=value</C>
		<C>Col=CZIPCD     Ctrl=gcem_czipcd     Param=text</C>
		<C>Col=PROSTS     Ctrl=gcra_prosts     Param=codevalue</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	