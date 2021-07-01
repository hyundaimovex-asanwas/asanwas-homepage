<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 출금관리 - 지출신청 결재현황
+ 프로그램 ID	: a400340.jsp
+ 기 능 정 의	: 지출신청 결재현황
+ 최 초 이 력	: 2017.11.03 jys
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

var gs_date1  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + "01";
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	
	gcem_app_date_fr.text =gs_date1;
	gcem_app_date_to.text =gs_date2;
	
	gcem_app_empno.text = gs_userid;
	gcem_app_empnm.text = gusrnm;
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400340_s1?v_str1="+gcem_app_date_fr.text
			                                                            +"&v_str2="+gcem_app_date_to.text
	                                                                    +"&v_str3="+gcem_app_empno.text;
   //prompt('',gcds_data.DataID);
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
	Description : 입력값 체크
******************************************************************************/
function ln_Chk_Save() {
    //필수항목 체크     

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){
	
}

<%	
/******************************************************************************
	Description : 삭제
******************************************************************************/
%>
function ln_Delete(){
		
	
}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

<%
/******************************************************************************
Description : 찾기 - 작성자 
******************************************************************************/
%>
function ln_Popup_App_empno(){

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
			gcem_app_empno.text    = arrParam[1];
			gcem_app_empnm.text    = arrParam[0];
		}else{
			gcem_app_empno.text="";
			gcem_app_empnm.text="";
		}
	}
}


<%//지출신청 팝업%>
function ln_Popup(row){
	
	var result="";
    var arrParam	= new Array();
    var arrResult	= new Array();
    
    //alert("AP_M_SID::"+gcds_data.namevalue(row,"AP_M_SID"));
	
	arrParam[0]=gcds_data.namevalue(row,"DOC_GU2");    //810                        
	arrParam[1]=gcds_data.namevalue(row,"DOC_SID");    //요청SID      3000 
	arrParam[2]="";                                    //결재선정보 
	arrParam[3]=gcds_data.namevalue(row,"AP_M_SID");   //결재마스터 SID 12159
	strURL = "<%=dirPath%>/Account/jsp/a400310_approve_view.jsp";
	strPos = "dialogWidth:1020px;dialogHeight:700px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);
}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

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

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gcgd_data event=OnDblClick(row,colid)>

 	if(gcds_data.namevalue(row,"DOC_GU2")=="810"){
 		ln_Popup(row);
 	}
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

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
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
					<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">신청일자</td>
					<td width="400px"  class="tab18"  align=left  >
				    	<comment id="__NSID__">
							<object  id=gcem_app_date_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_app_date_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					    ~
					    <comment id="__NSID__">
							<object  id=gcem_app_date_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_app_date_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					<td class="tab18" width="100px;" bgcolor="#eeeeee" align="center">사번</td>
					<td class="tab18" >&nbsp;
						<comment id="__NSID__">
						<object id=gcem_app_empno classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F	style="position:relative;top:2px;left:3px;width:50px">
							<param name=Text		  value="">
							<param name=Alignment	  value=0>
							<param name=Border		  value=true>
							<param name=Format		  value="#######">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="false">
						</object>
					    </comment><script>__ws__(__NSID__);</script>
				    	
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_App_empno()">
				    	
				    	<comment id="__NSID__">
						<object  id=gcem_app_empnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
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
		<td COLSPAN=2>
			<table>
				<tr>
					<td>
						<!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_data style="WIDTH:998px;HEIGHT:530px;border:1 solid #777777;display:block;" viewastext>
			 						 <PARAM NAME="DataID"		VALUE="gcds_data">
									 <PARAM NAME="BorderStyle"  VALUE="0">
									 <PARAM NAME="Indwidth"		VALUE="0">
									 <PARAM NAME="Fillarea"		VALUE="true">
									 <PARAM NAME="ColSizing"	VALUE="true">
									 <param name="sortview"     value=left>
									 <param name="GTitleHeight"  value=25>
									 <param name="TitleHeight"   value="25">
							         <param name=RowHeight       value="20">
								     <PARAM NAME="Format"		VALUE="  
										<FC>ID=CurRow,	        Name=NO,	        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false Value={CurRow}</FC>
										<C> ID=AP_M_SID         Name=결재SID,   	    width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=DOC_GUNM         Name=구분1,    	    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=DOC_GU2NM        Name=구분2,    	    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=AP_STATUS_M_NM   Name=결재상태,  	    width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<G> Name='기안자'   HeadAlign=Center HeadBgColor=#B9D4DC
										<C> ID=L_EMPNO          Name=사번,	        width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  </C>
										<C> ID=APP_EMPNM        Name=성명,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  </C>
										<C> ID=I_DATE           Name=일시,	        width=150,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  </C>
										</G>
										<C> ID=OUTAMT           Name=신청금액합,       width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=right,	sort = true  </C>
										<C> ID=CNT              Name=신청건수,        width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  </C>
										<C> ID=AP_DESC_CNT      Name=의견,           width=80,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  </C>
										
									">
								 	</object></comment><script>__ws__(__NSID__);</script> 
								</td>
						  	</tr>
						 </table>
					</td>
			 	</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search">
		</label></td>
	</tr>	
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



