<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  자금관리 - 지출신청현황
+ 프로그램 ID	:  a400330.jsp
+ 기 능 정 의	:  현업이 필요한 자금신청내역을 조회하는 화면이다.  
+ 작   성  자      :  정 영 식
+ 작성 일 자      :  2017.11.06
+ 서 블 릿 명	:  
+ 가우스 버젼    :  5.2 
-----------------------------------------------------------------------------
+ 수 정 내 용     :	         
+ 수   정  자      : 
+ 수 정 일 자     : 
+ 서 블 릿 명     :
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<%@ page import="sales.common.DateUtil"%> 
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. 

	String v_dwr_sid = request.getParameter("v_dwr_sid");	//작업일보 index
	String v_status	 = request.getParameter("v_status");	//페이지 작업 구분자 : 상태 010작성중, 011현장결재진행중, 012현장결재완료
	String v_ap_m_sid = request.getParameter("v_ap_m_sid");	//결재마스터 sid : 반려시에는 스냅샷을 찍는게 아니므로 일보 인덱스가 겹친다.
	
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
%>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>지출신청</title>

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

	//^^gcem_appdate.text = gs_date;
	gcem_appdate_fr.text = "20171001";
	gcem_appdate_to.text =  gs_date;
	//gcem_reqdate.text = gs_date;
	//^^gcem_taxdat.text = gs_date;
	
	gcds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1=";
	gcds_fdcode.Reset();
	
	gclx_fdcode.bindcolval = gs_fdcode;
	gcem_appempno.text =gs_userid;
	gcem_appempnm.text =gusrnm;	
	gclx_ap_status_m.bindcolval ="A";
}

<%
/******************************************************************************************
	Description : 조회 ( 테이블에 저장된 Data 조회 )  OK
******************************************************************************************/
%>
function ln_Query(e){
		
	 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400330_s1?v_str1="+gclx_fdcode.bindcolval
	  																       +"&v_str2="+gcem_appdate_fr.text
	  																       +"&v_str3="+gcem_appdate_to.text
																		   +"&v_str4="+gcem_reqdate_fr.text
																		   +"&v_str5="+gcem_reqdate_to.text
																		   +"&v_str6="+gcem_appempno.text
																		   +"&v_str7="
																		   +"&v_str8="+gclx_ap_status_m.bindcolval;	
     gcds_data01.Reset();

}

<%
/******************************************************************************************
	Description : 결재선 조회
******************************************************************************************/
%>


<%
/******************************************************************************************
	Description : 저장
******************************************************************************************/
%>

<%
/******************************************************************************************
	Description : 저장 체크
******************************************************************************************/
%>

<%
/******************************************************************************************
	Description : 삭제
*****************************************************************************************/
%>

/*****************************************************************************************
	Description : 추가
*****************************************************************************************/
function ln_Add(){

}
/******************************************************************************
Description : 행삭제
******************************************************************************/


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
	Description : 계산서 데이터 생성
******************************************************************************/
%>

<%
/******************************************************************************
	Description : 계산서 데이터 저장  && 계산서 번호 업데이트
******************************************************************************/
%>
<%
/******************************************************************************
Description : 필수항목 체크 
******************************************************************************/
%>

<%
/******************************************************************************
Description : 원가 / 예산부서 팝업
******************************************************************************/
%>

<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>

<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>

<%
/******************************************************************************
Description : 계정 팝업
******************************************************************************/
%>
<%
/******************************************************************************
Description : 원가 팝업
******************************************************************************/
%>
<%
/******************************************************************************
Description : 거래처 계좌 팝업
******************************************************************************/
%>


<%
/******************************************************************************
Description : 거래처 계좌 팝업 
******************************************************************************/
%>

<%
/******************************************************************************
Description : 찾기 - 작성자 
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
Description : 찾기 - 통화 
******************************************************************************/
%>

<%
/******************************************************************************
Description : 거래처 초기화
******************************************************************************/
%>

<%
/******************************************************************************
Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>
<%
/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>
<%
/******************************************************************************
	Description : Report Head 설정 - 세금계산서 상세내역
******************************************************************************/
%>


<%
/******************************************************************************
	Description : 전체선택
******************************************************************************/
%>


<%
/******************************************************************************
	Description : 계산서 증빙팝업
******************************************************************************/
%>


<%
/******************************************************************************
	Description : 결재선  popup
******************************************************************************/
%>


<% //결재선 데이터셋 헤더 %>


<% //결재MST %>


<% //결재DTL %>


<% //상신  전자결재MST, 전자결재DTL %>

<% //상신 체크 %>

<% //데이터 설정 %>



</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">

<!--자금신청내역 -->
<object  id=gcds_data01 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--매입계산서 -->

<object  id=gcds_fdcode classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>



</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>


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
	
	
</script>


<script language="javascript"  for=gcgd_disp01  event=OnClick(row,colid)>

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
					<td class="tab25" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지점</nobr></td>
					<td class="tab24" style="width:120px">
						<comment id="__NSID__">
							<object  id=gclx_fdcode classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=ComboDataID      value="gcds_fdcode">
								<param name=CBDataColumns	 value="FDCODE,FDNAME">
								<param name=SearchColumn	 value=FDNAME>
								<param name=Sort			 value=false>
								<param name=ListExprFormat   value="FDNAME">								
								<param name=BindColumn		 value="FDCODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab24" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>신청일</nobr></td>
					<td class="tab24">
						<comment id="__NSID__">
							<object  id=gcem_appdate_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="GetCallCalendar('gcem_appdate_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;	
					    ~
					    <comment id="__NSID__">
							<object  id=gcem_appdate_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>	
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="GetCallCalendar('gcem_appdate_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					
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
					    
				    	<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:2px;cursor:hand"	 onclick="ln_Popup_Appempno()">
				    	
				    	
						<object  id=gcem_appempnm classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="width:80px;height:20px;position:relative;left:5px;top:2px" >		
							<param name=Text		  value="">
							<param name=Border        value=true>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Enable		  value="false">
							<param name=Language			value=1>
						</object>
						
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td class="tab27" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>결재상태</nobr></td>
					<td class="tab28" style="width:120px"   >
						<comment id="__NSID__">
							<object  id=gclx_ap_status_m classid=CLSID:D8BCC087-4710-427D-B2E4-A4B93B6EA197	style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData			        value="A^전체,1^작성중,2^승인진행,3^최종승인,4^부결">
								<param name=CBDataColumns	 		value="CODE,NAME">
								<param name=SearchColumn	     	value=NAME>
								<param name=Sort			        value=false>
								<param name=ListExprFormat       	value="NAME">								
								<param name=BindColumn		     	value="CODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab28" style="width:100px;" bgcolor="#eeeeee" align=center><nobr>지급요청일</nobr></td>
					<td class="tab28" colspan =3>
						<comment id="__NSID__">
							<object  id=gcem_reqdate_fr classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate_fr', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					    ~
						<comment id="__NSID__">
							<object  id=gcem_reqdate_to classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F  style="position:relative;top:3px;left:5px;width:70px;height:20px;">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							</object> 
						</comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_dsudt OnClick="__GetCallCalendar('gcem_reqdate_to', 'Text')" style="position:relative;width:20px;left:6px;top:2px;cursor:hand;">&nbsp;
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td ALIGN=CENTER>
			<table width="847" cellpadding="1" cellspacing="0" border="0">
				<tr>
					<td style="width:460;position:relative;top:3px" align=left valign=top  colspan=2>
					    <comment id="__NSID__">
						<OBJECT id=gcgd_disp01 classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="WIDTH:998px;HEIGHT:545px;border:1 solid #777777;display:block;position:relative;left:5px" viewastext>
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
								<FC> Name='신청일자'    ID=APPDATE        HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	    align=center  	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee' </FC>
								<FG> Name='지급정보'    HeadAlign=Center  HeadBgColor=#B9D4DC
								<FC> Name='종류'       ID=PAYKND         HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:수시지급,2:고정지급,3:자동출금,4:지로납부'</FC>
								<FC> Name='요청일'      ID=REQDATE	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	   	align=center	SumBgColor='#C3D0DB'  edit=none MASK='XXXX/XX/XX' bgcolor='#eeeeee'}   </FC>    
								<FC> Name='지급기준'    ID=PAYGB 		   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Combo, Data='1:보통예금,2:현금,3:외화보통예금,4:현금(외화)'</FC>
								<FC> Name='지급금액'    ID=OUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80        align=right 	SumBgColor='#C3D0DB'  edit=none SumText=@sum    </C>
								</FG>
								<G> Name='거래처정보'   HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='코드'	      ID=VENDCD	       HeadAlign=Center HeadBgColor=#B9D4DC Width=55    	align=center	SumBgColor='#C3D0DB'  edit=none EditStyle=Popup </FC>
								<C> Name='등록번호'	  ID=VENDID 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XXXXXXX')}</FC>
								<C> Name='거래처명'	  ID=VENDNM 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=100    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								<C> Name='계좌번호'    ID=PAYACCTNO 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								<C> Name='예금주'      ID=ACCT_AUTH 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=110    	align=left  	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'</FC>
								</G>
								<C> Name='적요'  	 ID=REMARK		   HeadAlign=Center HeadBgColor=#B9D4DC Width=150    	align=left  	SumBgColor='#C3D0DB'  edit={Decode(AP_STATUS_M,0,'',none)}</C>
									
								<G> Name='외화정보'	 HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='통화명'     ID=CURUNIT 	       HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center 	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  EditStyle=Popup</</C>
								<C> Name='외화'       ID=FOUTAMT  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  SumText=@sum</C>
								<C> Name='환율'       ID=EXRATE  	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=right 	SumBgColor='#C3D0DB'  edit=none bgcolor='#eeeeee'  </C>
								</G>
								
								<G> Name='신청전표정보'  HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='접수일자'    ID=APPFSDAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=80    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
								<C> Name='접수번호'    ID=APPFSNBR	   HeadAlign=Center HeadBgColor=#B9D4DC Width=60    	align=center	SumBgColor='#C3D0DB'  edit=none  bgcolor='#eeeeee'</C>
							    </G>
								<C> Name='결재상태'    ID=AP_STATUS_M    HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:작성중,2:승인진행,3:최종승인,4:부결' bgcolor='#eeeeee'</C>
								<C> Name='지급상태'    ID=PAYSTAT 	   HeadAlign=Center HeadBgColor=#B9D4DC Width=50    	align=center	SumBgColor='#C3D0DB'  edit=none  EditStyle=Combo, Data='1:미지급,2:접수,3:지급' bgcolor='#eeeeee'</C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
						<fieldset style="position:relative;left:5px;width:1000px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
						&nbsp;<font id="ft_cnt01" style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
				
				
				
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
