<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	: 인감관리 - 인감정보이력
+ 프로그램 ID	: a400130.jsp
+ 기 능 정 의	: 인감정보이력조회
+ 최 초 이 력	: 2017.04.07 jys
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
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400130_s1?v_str1="+gclx_signet_gb_0.bindcolval
			                                                            +"&v_str2="+gcra_usegb_0.codevalue;
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


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_signet_gb_0 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
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
									<comment id="__NSID__"><object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_pyo style="WIDTH:998px;HEIGHT:550px;border:1 solid #777777;display:block;" viewastext>
			 						 <PARAM NAME="DataID"		VALUE="gcds_data">
									 <PARAM NAME="BorderStyle"  VALUE="0">
									 <PARAM NAME="Indwidth"		VALUE="0">
									 <PARAM NAME="Fillarea"		VALUE="true">
									 <PARAM NAME="ColSizing"	VALUE="true">
									 <param name="sortview"     value=left>
								     <PARAM NAME="Format"		VALUE="  
										<FC>ID=CurRow,	         Name=NO,	        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false Value={CurRow}</FC>
										<C> ID=SIGNET_ID         Name=인감\\ID,    	width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=SIGNET_SEQ        Name=순번,    	    width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false </C>
										<C> ID=WORK_GB           Name=업무\\구분,    	width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  EditStyle=Combo,  Data='1:신규,2:변경,3:삭제,4:반출,5:반입'</C>
										<C> ID=MGR_TEAMNM        Name=관리팀,	    	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<G> Name='관리책임자'      HeadAlign=Center    HeadBgColor=#B9D4DC
										<C> ID=MAIN_EMPNMK       Name=정,	        width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=SUB_EMPNMK        Name=부,        	width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										</G>
										<C> ID=SEND_DATE_CONFIRM Name=반출일시,	    width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=RECEIVE_DATE  	 Name=반입일시,	    width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=DISUSE_DATE       Name=폐기일,	        width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  MASK='XXXX/XX/XX'</C>
										<C> ID=DISUSE_REASON     Name=폐기사유,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=RECE_DATE         Name=반납일,	        width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  MASK='XXXX/XX/XX'</C>
										<C> ID=RECE_REASON       Name=반납사유,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=USEGB             Name=사용\\유무,	    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  EditStyle=Combo, Data='1:사용,2:보관,3:폐기'</C>
										<C> ID=USE_REMARK        Name=사용내역,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=ETC 	             Name=적요,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
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



