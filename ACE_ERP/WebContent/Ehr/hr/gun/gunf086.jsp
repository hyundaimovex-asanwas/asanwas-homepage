<!--
*****************************************************
* @source       : gunf085.jsp
* @description : 1달 근무 신청 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/02/24     이동훈             최초작성
*****************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%

	String req_no = request.getParameter("REQ_NO");         //신청번호
	String eno_no = request.getParameter("ENO_NO");         //신청자사번
	String app_yn = request.getParameter("APP_YN");			//결재상태
	String app_status = request.getParameter("APP_STATUS"); //결재진행상황
	String app_cmt = request.getParameter("APP_CMT");       //결재자의견
%>


<html>


<head>

	<title>월별 근무 신청</title>
	
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../../css/style.css" rel="stylesheet" type="text/css">
		<link href="../../css/general.css" rel="stylesheet" type="text/css">
		
		<script language=javascript src="../../common/common.js"></script>
		<script language=javascript src="../../common/input.js"></script>
		<script language=javascript src="../../common/result.js"></script>
		<script language=javascript src="../../common/mdi_common.js"></script>
		<script language="javascript" src="../../common/calendar/calendar.js"></script>
	
	
	
	<!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
	<script language="javascript" >
	

	var today = gcurdate;
	
	var GBN = "";
	
	var obj = new String();

	obj.app_cmt = "";
	// 전역변수
	

	
    /***********************************
     * 01. 조회 함수_List 형태의 조회*
     ***********************************/
    function fnc_SearchList()
    {

    	trT_DI_OVERTIMESCHEDULE.KeyValue = "tr(O:dsT_DI_OVERTIMESCHEDULE=dsT_DI_OVERTIMESCHEDULE, O:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
    	trT_DI_OVERTIMESCHEDULE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf085.cmd.GUNF085CMD&S_MODE=SHR2&REQ_NO=<%=req_no%>&ENO_NO=<%=eno_no%>";
    	trT_DI_OVERTIMESCHEDULE.post();

    }

	
    /***********************************
     * 02. 조회 함수_Item 형태의 조회  *
     ***********************************/
    function fnc_SearchItem()
    {
    	
    	
    }

    
    /******************
     * 03. 저장 함수   *
     ******************/
    function fnc_Save()
    {
    	
    	
    }


    /******************
     * 04. 삭제 함수  *
     ******************/
    function fnc_Delete()
    {
    	
    	
    }


    /******************
     * 05. 인쇄 함수  *
     ******************/
    function fnc_Print()
    {

    	
    }

    
    /***********************
     * 06. 엑셀 저장 함수   *
     ***********************/
    function fnc_ToExcel()
    {
    	
    	
    }

    
    /******************
     * 07. 신규 함수  *
     ******************/
    function fnc_AddNew()
    {
 
    	
    }

    
    /******************
     * 08. 유효성 검사 *
     ******************/
    function fnc_Valid()
    {
    	

    }


    
    /******************
     * 08. 추가 함수  *
     ******************/
	function fnc_Append()
    {
    	

	}
    
    /******************
     * 09. 제거 함수  *
     ******************/
    function fnc_Remove()
    {
    	

    }


    
    /********************
     * 10. 초기화 함수  *
     ********************/
    function fnc_Clear()
    {
    	
    	location.reload();
    	
    }

    /************************
     * 11. 화면 종료(닫기)  *
     ***********************/
    function fnc_Exit()
    {
    	
    }
    

    /******************************
     * 12. 검색 조건 유효성 검사  *
     ******************************/
    function fnc_SearchItemCheck(year)
    {
    	
    	
    }

    /*************************
     * 13. 저장 유효성 체크  *
     *************************/
    function fnc_SaveItemCheck()
    {
    	

    }

    /********************************************
     * 14. Form Load 시 Default 작업 처리 부분    *
     *******************************************/
    function fnc_OnLoadProcess()
    {

    	dsT_DI_APPROVAL.SetDataHeader(
				"GUN_YMD:STRING(10),"+			// 근태날짜
                "GUN_GBN:STRING(1),"+			// 근태결재구분
				"DPT_CD:STRING(6),"+			// 근태부서
				"DPT_NM:STRING(10),"+			// 근태부서명
				"SEQ_NO:STRING(1),"+			// 결재선
				"ENO_NO:STRING(10),"+			// 결재자사번
				"JOB_CD:STRING(10),"+			// 결재자직위
				"APP_TIME:STRING(10),"+			// 결재시간
				"ENO_NO:STRING(10),"+			// 상신자사번
				"APP_YN:STRING(10),"+			// 결재여부
				"ENO_NM:STRING(10),"+			// 결재자명
				"JOB_NM:STRING(10)"				// 직위명
		);
    	
    	
    	cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"true","false"); 			// 결재현황 Grid Style 적용(그리드, 상태변경컬럼 width, 헤더체크박스, 헤더정렬)
    	cfStyleGrid_New(form1.grdT_DI_OVERTIMESCHEDULE,0,"true","false"); 	// 한달근무 Grid Style 적용(그리드, 상태변경컬럼 width, 헤더체크박스, 헤더정렬)
    	
    	fnc_SearchList();
    	
    	// 결재자 &&  미결재 인경우에만 버튼이 활성화
		if(dsT_DI_APPROVAL.NameValue(1,"ENO_NO") == gusrid && dsT_DI_APPROVAL.NameValue(1,"APP_TIME") == ""){

        	document.getElementById("btn_approval").style.display = "";

        }else{

        	document.getElementById("btn_approval").style.display = "none";

        }
    	
    }

	/********************
     * 15. 단축키 처리   *
     *******************/
	function fnc_HotKey()
	{
		
		fnc_HotKey_Process(btnList, event.keyCode);
		
		
	}
	


    /*************************
     *   16. 결재 처리       *
     *************************/
	function fnc_SubmitApproval(kind) {

        var app_yn = "";    //결재완료여부
        
        if (!confirm(kind+" 처리를 하시겠습니까?")) return;

        if(kind == "결재"){
        	
            app_yn = "Y";
            
        }else if(kind == "부결"){
        	
			if(obj.app_cmt == ""){
				
      			window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
      	    
			}

            if(obj.app_cmt != ""){
            	
				app_yn = "N";
				
	            if(kind == "부결") {
	            	
	            	app_yn = "N";
	            	
	            }
	            
            }else{
            	
                alert("부결사유를 입력후 처리바랍니다.\n \n작업은 취소되었습니다.");
                
                return false;
                
        	}

        }
        

        dsT_DI_OVERTIMESCHEDULE_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, APP_YN:STRING");
        
        dsT_DI_OVERTIMESCHEDULE_STATE.AddRow();
        
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"REQ_NO") = dsT_DI_OVERTIMESCHEDULE.NameValue(1,"REQ_NO");
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"ENO_NO") = dsT_DI_OVERTIMESCHEDULE.NameValue(1,"ENO_NO");
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_STATUS") = kind;
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_CMT") = obj.app_cmt;        
        dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_YN") = app_yn;
        
        //prompt(this, dsT_DI_OVERTIMESCHEDULE_STATE.text);
        
        trT_DI_OVERTIMESCHEDULE_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMESCHEDULE_STATE=dsT_DI_OVERTIMESCHEDULE_STATE)";
		trT_DI_OVERTIMESCHEDULE_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf085.cmd.GUNF085CMD&S_MODE=SAV2";
		trT_DI_OVERTIMESCHEDULE_STATE.post();
		
        document.getElementById("btn_approval").style.display = "none";//결재버튼들

        window.close();

    }
    

    /*****************************************
     * 17.   사유입력팝업 (부결처리)         *
     ****************************************/
	function fnc_SubmitCancle(kind) {

        var obj = new String();
      
        window.showModalDialog("../../../Ehr/hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        if(obj.app_cmt != undefined){

            dsT_DI_OVERTIMESCHEDULE_STATE.setDataHeader("REQ_NO:STRING, ENO_NO:STRING, APP_STATUS:STRING, APP_CMT:STRING, KIND:STRING, APP_YN:STRING");
            
            dsT_DI_OVERTIMESCHEDULE_STATE.AddRow();
            
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"REQ_NO") = document.getElementById("txtREQ_NO").value;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"ENO_NO") = document.getElementById("txtENO_NO").value;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_STATUS") = kind;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_CMT") = kind+"처리-"+obj.app_cmt;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"KIND") = kind;
            dsT_DI_OVERTIMESCHEDULE_STATE.NameValue(1,"APP_YN") = "N";

            trT_DI_BUSINESSTRIP_STATE.KeyValue = "tr01(I:dsT_DI_OVERTIMESCHEDULE_STATE=dsT_DI_OVERTIMESCHEDULE_STATE)";
            trT_DI_BUSINESSTRIP_STATE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.f.gunf085.cmd.GUNF085CMD&S_MODE=SAV_03";
            trT_DI_BUSINESSTRIP_STATE.post();

            document.getElementById("btn_approval").style.display = "";

        }

    }
    
</script>



</head>


<!--**************************************************************************************
*                                                                                        *
*  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
*                                                                                        *
***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_OVERTIMESCHEDULE                 |
    | 3. Table List : T_DI_OVERTIMESCHEDULE             |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMESCHEDULE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    
    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_DI_BUSINESSTRIP_STATE           |
    | 3. Table List : T_DI_BUSINESSTRIP_STATE       |
    +----------------------------------------------->
    <Object ID="dsT_DI_OVERTIMESCHEDULE_STATE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                 |
    | 2. 이름 : dsT_DI_APPROVAL                 |
    | 3. Table List : T_DI_APPROVAL             |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    

    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_DI_DILIGENCE)		       |
    | 3. 사용되는 Table List(T_DI_DILIGENCE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_OVERTIMESCHEDULE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	
	
    <!--------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			      |
    | 2. 이름은 tr_ + 주요 테이블명(trT_DI_BUSINESSTRIP_STATE)|
    | 3. 사용되는 Table List(T_DI_BUSINESSTRIP_STATE)	      |
    +--------------------------------------------------------->
    <Object ID ="trT_DI_OVERTIMESCHEDULE_STATE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    
<!--*************************************
*                                       *
*  Component에서 발생하는 Event 처리부  *
*                                       *
**************************************-->
	<!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 dsT_DI_APPROVAL |
    +----------------------------------------------------------------->
    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">
    
        if (iCount > 0) {
			
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			document.getElementById("txtREQNO").innerText = dsT_DI_APPROVAL.NameValue(1,"REQ_NO");
			
		}
        
    </Script>
    

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_DI_APPROVAL Event="OnDataError()">
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMESCHEDULE event="OnSuccess()">
	
        if(GBN == "SAV01") {
        	
        	alert("작업을 완료 하였습니다!");
        	
        	fnc_Clear();
        	
        }
        
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						|
    +------------------------------------------------------>
	<script for=trT_DI_OVERTIMESCHEDULE event="OnFail()">
	
		cfErrorMsg(this);
		
    </script>
    

    <!-----------------------------------------------------+
    | grdT_DI_OVERTIMESCHEDULE OnClick 처리 - 부결사유 조회|
    +------------------------------------------------------>
	<script language="javascript"  for=grdT_DI_OVERTIMESCHEDULE event=OnClick(Row,Colid)>
	
		if(Colid == "END_TAG" && dsT_DI_OVERTIMESCHEDULE.NameValue(Row, "APP_REMARK") != "" ){
			
			var obj =  dsT_DI_OVERTIMESCHEDULE.NameValue(Row, "APP_REMARK");
			
			window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
			
		}
		
	</script>
    
    <!-----------------------------------------------------+
    | grdT_DI_APPROVAL OnClick 처리 - 부결사유 조회        |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

  
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){

		obj =  dsT_DI_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("../../hr/gun/gunc093.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
	}

	
	if(Colid == "REMARK1" && dsT_DI_APPROVAL.NameValue(Row, "REMARK1") == "의견입력" ){

		window.showModalDialog("../../hr/gun/gune016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	}
	
	
  </script>
  
  
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="left">
		</td>
		<td height="35" class="paddingTop5" align="right">
			 <span id="btn_approval" style="display:none">
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','../../images/button/btn_ApprovalOver.gif',1)">
				<img src="../../images/button/btn_ApprovalOn.gif" name="imgApproval" width="60" height="20" border="0" align="absmiddle"  onClick="fnc_SubmitApproval('결재');">
				</a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','../../images/button/btn_RejectionOver.gif',1)">
				<img src="../../images/button/btn_RejectionOn.gif" name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('부결');">
				</a>
 			</span>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->


<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 조건 입력 테이블 시작 -->
			<table width="220" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							<tr height="28">
								<td align="center" class="blueBold">신청번호</td>
								<td class="padding2423">
									<input id="txtREQNO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->

	        </td>
	        <td width="25">&nbsp;</td>
	        <td>

        	<!-- 결재선 정보 테이블 시작 -->
			<table width="900" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:780px;height:70px;">
							<param name="DataID"				value="dsT_DI_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
								<C> id='SEQ_NM'			width=70	name='구분'				align=center	Value={IF(SEQ_NO > '90','협조', '결재')}</C>
								<C> id='ENO_NM'			width=90	name='결재자'			align=center	</C>
								<C> id='JOB_NM'			width=80	name='직위'				align=center	</C>
                                <C> id='DPT_NM'			width=150	name='팀'				align=center	</C>
								<C> id='APP_STATUS'		width=250	name='결재상태'			align=center    </C>
								<C> id='REMARK1'		width=120	name='의견'				align=center 	Color='Blue'	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
       		  </table>
        	<!-- 결재선 정보 테이블 끝 -->

        </td>
    </tr>
</table>


<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="85%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage"></span></td>
				</tr>
			</table>
		</td>

	</tr>
</table>


<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td style="padding-top:2px;">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_DI_OVERTIMESCHEDULE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:250px;">
							<param name="DataID"				value="dsT_DI_OVERTIMESCHEDULE">
							<param name="Editable"				value="false">
							<param name="DragDropEnable"		value="true">
							<param name="SortView"				value="Left">
							<param name="Format"				value="
								<C> id='{CUROW}'			width=40		name='NO'			align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  value={String(Currow)}		</C>							
								<C> id='ENO_NO'				width=100		name='사번'			align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
								<C> id='ENO_NM'				width=100		name='성명'			align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
								<C> id='REG_YMD'			width=180		name='근무일자'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  MASK='XXXX-XX-XX' </C>
								<C> id='REMARK'				width=100		name='근무요일'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
								<C> id='REQ_NO'				width=50		name='신청번호'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  show=false</C>
								<C> id='STR_TIME'			width=180		name='시작시간'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  MASK='XX:XX'</C>
								<C> id='END_TIME'			width=180		name='종료시간'		align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  MASK='XX:XX'</C>
								<C> id='DAY_TOTAL_TIME'		width=100		name='총근무시간'	align=center	BgColor={Decode(HOL_YN,'Y','#FFEAEA')}  </C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->



</form>
<!-- form 끝 -->



</body>
</html>
