<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명		: 고객관리
 * 프로그램ID 	: CU010S
 * J  S  P		: cu010i
 * 서 블 릿		: Cu010i
 * 작 성 자		: 남기표
 * 작 성 일		: 2006-06-05
 * 기능정의		: 고객조회
 * [수  정   일  자][수정자] 내용
 * [2007-09-17][심동현] 새 메뉴트리 적용
 * [2008-05-23][심동현] 통통연계 기능 추가
 * [2008-06-27][심동현] 복사해서 관리용 페이지 추가
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="sales.common.*"%>
<%	//ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				사용자 스크립트
******************************************************************************/
%>		
	<script language="javascript">
		
	/* 페이지로딩 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//트리초기화 호출
		cfStyleGrid(getObjectFirst("gr1"), "comn1");
		fnInit(); 
	}
			
	/* 초기작업 */
	function fnInit(){
		// 국적구분
        getObjectFirst("searchds1").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=CU009&s_Item1=Y";
        getObjectFirst("searchds1").Reset();
		// 인증여부
        getObjectFirst("searchds2").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=CU002&s_Item1=Y";
        getObjectFirst("searchds2").Reset();

        getObjectFirst("searchds3").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=CU001&s_Item1=Y";
        getObjectFirst("searchds3").Reset();

        getObjectFirst("searchds4").DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=S&s_Head=CU004&s_Item1=Y";
        getObjectFirst("searchds4").Reset();
	}

			
	/* 메인 조회 */
	function fnSelect() {
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
					+",sClient_sid="+client_sid.value
					+",sCust_nm=" + sCustNm.value
					+",sManage_no=" + sManageNo.value
					+",sCust_gu=" + lc3.ValueOfIndex("detail",lc3.Index)
					+",sRegi_yn_t=" + lc2.ValueOfIndex("detail",lc2.Index)
					+",sGroup_cd=" + sAccpt_no.value;

 		ln_TRSetting(tr1, 
	        "<%=dirPath%><%=HDConstant.PATH_RV%>Rv450I",
	        "JSP(O:DEFAULT=ds1)",
	        param);
		tr_post(tr1);

		//버튼제어
		if(getObjectFirst("sAccpt_no").value == "" ){
			getObjectFirst("data_snd_btn").style.display = "none";
			getObjectFirst("data_rcv_btn").style.display = "none";			
        }
	}
		

			
   // 송신|수신
    function fnApply(dir) {
        v_job = "E";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
					+",sGroup_cd=" 	+ sAccpt_no.value
					+",sDir=" 		+ dir;	//dir=send 송신, recv 수신
 		ln_TRSetting(tr2, 
	        "<%=dirPath%><%=HDConstant.PATH_RV%>Rv450I",	        
	        "JSP(O:DS2=ds_result)",
	        param);
		tr_post(tr2);

		//한번 누르면 버튼 사라짐..;;;
		getObjectFirst("data_snd_btn").style.display = "none";
		getObjectFirst("data_rcv_btn").style.display = "none";						
		
    }
    
	/* 엑셀 */
	function fnExcelDs1() {
		
		if(ds1.RowCount==0){
			alert("데이터를 먼저 조회하시길 바랍니다.");
			return;
		}
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:고객조회 조회; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("고객조회", "고객조회.xls", 8);		 
	}
		
	/* 대리점 검색 팝업 */
	function fnClientPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		
		strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	   		client_nm.value = arrParam[1];
	   		client_sid.value = arrParam[0];
	   		
		} else {
		  client_nm.value = "";
		  client_sid.value = "";
		}				
	}
	
	</script>			

	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업성공
%>
		<script language="javascript" for="tr1" event="onsuccess()">
			
		</script>
		
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  작업실패
%>
		<script language="javascript" for="tr1" event="onfail()">
		</script>
		

		
		
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
<script language="javascript" for="initds" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 
%>
<script language="javascript" for="ds1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  조회중 에러 
%>				
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		if (ds1.countrow == 1000) {
			alert("데이터는 1000건 이상 조회 할 수 없습니다!");
		}
		
			window.status="조회가 완료 되었습니다.";

	    if(sAccpt_no.value!=""){
	    	getObjectFirst("data_snd_btn").style.display = "inline";
	    	getObjectFirst("data_rcv_btn").style.display = "inline";	    	
	    }
			
		if( row < 1){
			alert("검색된 데이타가 없습니다."); 
			getObjectFirst("data_snd_btn").style.display = "none";
			getObjectFirst("data_rcv_btn").style.display = "none";			
		}
			
	</script>

<script language=javascript for="ds_result" event="OnLoadCompleted(row)">
	if(row==0)
		return;
</script>

<script language="javascript" for="tr2" event="OnSuccess()">
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";

	var alert_msg = "";
    if(ds_result.CountRow>0){
		for(var i=1; i<=ds_result.CountRow; i++){
			if(ds_result.NameValue(i, "MSG_CD")!="0000")
				alert_msg += ds_result.NameValue(i, "MSG") +"\n";
		}
		if(alert_msg!="")
			alert(alert_msg);
		else {
			alert("데이터 송신이 완료되었습니다.");
			fnSelect();
		}
    }
    	
    ds_result.ClearAll();
</script>

		
<%
/*******************************************************************************
			가우스 오브젝트  Dataset , TR 선언
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object id=gcds_data00 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=initds classid=<%=HDConstant.CT_DATASET_CLSID%>>      
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>    
<object id=searchds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                      
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- 코딩 부분 시작 ------------------------------->		


<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="60px">
		<td >
			<table width=845 >
				<tr>
					<td colspan=2>
						<table align=right>
							<tr>
								<td align="right"> 
			                        <img src="<%=dirPath%>/Sales/images/data_snd.gif" style="cursor:hand;display:none" id="data_snd_btn" onClick="fnApply('send');" align=absmiddle>
			                        <img src="<%=dirPath%>/Sales/images/data_rcv.gif" style="cursor:hand;display:none" id="data_rcv_btn" onClick="fnApply('recv');" align=absmiddle>
									<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">                                                                                    
									<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  
								</td>                                                                                                                
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="245x">
							<tr>	                                                                                                                      
								<td align="center" width="85px" height="30px" class="text">대리점코드</td>                                                              
								<td align="left"  bgcolor="#ffffff" colspan="3">                                                                           
									&nbsp;<input type="text" id=client_nm name="sClientSid" value="" size="14" maxlength="10"  readOnly="true">
								<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onClick = fnClientPopup();>     
								 <input type='hidden' id='client_sid' name='client_sid' value=''>                                              
								</td>                                                                                                                      
							</tr>												                                   
							<tr>                
								<td align="center" width="85px" height="30px" class="text" >신청서번호</td>                                                          
								<td align="left"  bgcolor="#ffffff" colspan="3">
									&nbsp;<input type="text" name="sAccpt_no" value="" size="14" maxlength="14">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0" 		ALT="신청서번호를  검색합니다"  style="cursor:hand"  onclick="javascript:fnAcceptNoPopup('<%=dirPath%>');" align='absmiddle'>                                                                            
								</td>                               
								                                                                                                               
							</tr>
						</table>
					</td>
					<td align=right>                                                                                                                                    
						<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="600x">                                                          
							<tr>                                                                                                                                
								<td align="center" width="85px" height="30px" class="text" >고객구분</td>                                                  
								<td align="center"  bgcolor="#ffffff" >
									<%=HDConstant.COMMENT_START%>
									<object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds3>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>	
								</td>                                                                                                                       
								<td align="center" width="80px" height="30px" class="text" >인증구분</td>                                                  
								<td align="center"  bgcolor="#ffffff" >
									<%=HDConstant.COMMENT_START%>
									<object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds2>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>                                                                                                                       
							</tr>                                                                                                                               
							<tr>                                                                                                                  
								<td align="center" width="85px" height="30px" class="text" >고객명</td>                                                    
								<td align="center"  bgcolor="#ffffff">
									<input type="text" name="sCustNm" value="" size="12" maxlength="10" >  
								</td>								
								<td align="center" width="85px" height="30px" class="text" >주민/여권번호</td>                                             
								<td align="center"  bgcolor="#ffffff">
									<input type="text" name="sManageNo" value="" size="12" maxlength="13">  
								</td>                                                                                                                       
							</tr>
						</table>                                                                                                                                    
					</td>
				</tr>
				<tr>
				<td height="5"></td>
				</tr>
				<tr>
					<td colspan=2>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=845px; height:333px" border="1">
					        <param name="DataID"            value="ds1">
					        <param name="BorderStyle"       value="0">
					        <param name="Fillarea"          value="true">
					        <param name="ColSizing"         value="true">
					        <param name="IndWidth"          value="0">
					        <param name="editable"          value="false">
					        <param name="LineColor"         value="#dddddd">
					        <param name="SortView"         		value="Right">
					        <param name="ViewSummary"         	value="1">
					        <param name="SortView"         	value="right">
					        <param name="Format"            value="
					
					                <C> name='영업담당자'   ID='sal_dam_nm' 		 Width=80  align=left editlimit=22 Sumtext=계</C>
					                <C> name='대리점'    	ID='client_nm'  		 Width=100  align=left editlimit=20 Sumtext=@cnt</C>
					                <C> name='그룹코드\\(신청서번호)'    	ID='group_cd'   Width=100  align=left editlimit=7 Sumtext=명</C>
					                <C> name='성명'      	ID='cust_nm'    		 Width=100  align=left editlimit=20 Sort=True</C>
					                <C> name='주민/여권번호'	ID='manage_no'  		 Width=100  align=left editlimit=13</C>
					                <C> name='실명확인\\(통일부)' 	ID='regi_yn_t_name'   	 Width=60  align=center editlimit=50 bgColor={IF(REGI_YN_T_NAME='틀림','#FFFF66','#FFFFFF')}</C>

					                <C> name='최근\\출발일'  		ID='recent_depart_date'	 Width=60  align=center</C>
					                <C> name='송신상태'       	ID='send_status'		      Width=70  align=center</C>
					                <C> name='송신\\(EAINUM)'      	ID='send_eainum'	Width=80  align=center</C>
					                <C> name='수신상태'       	ID='rcv_status'		      Width=70  align=center</C>
					                <C> name='수신\\(LINKID)'      	ID='rcv_linkid'		  Width=84 align=center </C>
					                

					                <C> name='고객구분' 		ID='cust_gu_name'        Width=60  align=left editlimit=50</C>
					                <C> name='자택전화'		ID='tel_no'     		 Width=100  align=left editlimit=20</C>
					                <C> name='비상연락처'    	ID='mobile_no'  		 Width=100  align=left editlimit=15</C>
					                <C> name='직장명'   		ID='company_nm' 		 Width=150  align=left editlimit=30</C>
					                <C> name='직위'    		ID='positions'  		 Width=150  align=left editlimit=30</C>
					                <C> name='주소'     		ID='address1'   		 Width=200  align=left editlimit=60</C>
					                <C> name='관광횟수'    	ID='north_cnt'  		 Width=60  align=left editlimit=7</C>
					                <C> name='신장'    		ID='height'  			 Width=50  align=left editlimit=7 show=false</C>
					                <C> name='입력일시'    	ID='u_date'  			 Width=170  align=center  sort=true</C>
					        ">
					</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
					</td>
				</tr>
			</table>	                                                                                                                       
		</td>
	</tr>
	<tr>
		<td><br>
			※ 인증구분 코드 <br>
			　미확인 : 고객 입력 후 최초 상태입니다. <br>
			　틀　림 : 성명 또는 주민번호가 틀린 상태. 고객과 확인 후 다시 실명확인해야 합니다.<br>
			　진행중 : 실명확인 조회가 진행 중인 상태. 잠시 후 [맞음|틀림] 으로 변경됩니다.<br>
			　맞　음 : 정상적으로 실명확인을 받은 상태. 예약신청이 가능합니다.<br>
			<br>
			※ 통일부 정책에 따라 <font color=red>인중여부=<b>맞음</b>이 아니면 예약신청할 수 없습니다.</font>
		</td>
	</tr>
</table>						


<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

