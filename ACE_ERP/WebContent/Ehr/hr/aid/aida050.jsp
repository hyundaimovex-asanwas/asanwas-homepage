	<!--*************************************************************************
	* @source      : aida050.jsp														*
	* @description : 경공조금지급기준관리 PAGE									*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/04/28            이동훈            	ERP 이사									*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>경공조금지급기준관리</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	자바스크립트 함수 선언부분  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var year = gcurdate.substring(0,4);

		var curRowPosition = 0;

		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			//경공조금지급기준  정보 조회
			var CEF_SEC_SHR = document.getElementById("cmdCEF_SEC_SHR").value;

			dsT_AD_AIDTRF.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida050.cmd.AIDA050CMD&S_MODE=SHR&CEF_SEC_SHR="+CEF_SEC_SHR;
			
			dsT_AD_AIDTRF.reset();
			
			dsT_AD_AIDTRF.RowPosition = curRowPosition;
			
        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {
			
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			
			if ( !fnc_SaveItemCheck() ) {
				return;
			}
			
			curRowPosition = dsT_AD_AIDTRF.RowPosition;
			// save
			
			trT_AD_AIDTRF.KeyValue = "tr01(I:dsT_AD_AIDTRF=dsT_AD_AIDTRF)";
			
			trT_AD_AIDTRF.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida050.cmd.AIDA050CMD&S_MODE=SAV";
			
			trT_AD_AIDTRF.post();
			
        }

		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			
	        if (dsT_AD_AIDTRF.CountRow < 1) {
	        	
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
				
                alert("삭제 할 자료가 없습니다!");
                
                return;
                
            }
	        
			curRowPosition = dsT_AD_AIDTRF.RowPosition;
			
            var msg = "구      분  : "+fnc_GetCommonName("dsT_CM_COMMON_R2", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "CEF_SEC"))
                    + "\n지급내역  : "+fnc_GetCommonName("dsT_CM_COMMON_R1", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "AID_CD"))
                    + "\n직위 From : "+fnc_GetCommonName("dsT_CM_COMMON_A2", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "JOB_CD_FROM"))
                    + "\n직위 To   : "+fnc_GetCommonName("dsT_CM_COMMON_A2", dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "JOB_CD_TO"))
                    + "\n기준(이상): "+dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "LSE_YY1")
                    + "\n기준(미만): "+dsT_AD_AIDTRF.NameString(dsT_AD_AIDTRF.RowPosition, "LSE_YY2")
                    + "\n에 해당하는 데이타를 삭제 하시겠습니까?";

            if(!confirm(msg)) {
            	
                return;
            }

            dsT_AD_AIDTRF.DeleteRow(dsT_AD_AIDTRF.RowPosition);

            // delete
			trT_AD_AIDTRF.KeyValue = "tr01(I:dsT_AD_AIDTRF=dsT_AD_AIDTRF)";
            
			trT_AD_AIDTRF.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida050.cmd.AIDA050CMD&S_MODE=SAV";
			
			trT_AD_AIDTRF.post();
			
        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
            //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 06. 엑셀 저장 함수  							*
         ********************************************/
        function fnc_ToExcel() {
			
            if (dsT_AD_AIDTRF.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_AD_AIDTRF.GridToExcel("경공조금지급기준관리", '', 225);
        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {
			
            //DataSet에 Header가 정의되어 있지 않는 경우
            if(dsT_AD_AIDTRF.CountColumn < 1){
                // 데이터셋의 헤더 정보 설정.
                dsT_AD_AIDTRF.setDataHeader("CEF_SEC:STRING, CEF_SEC_TXT:STRING, AID_CD:STRING, AID_CD_TXT:STRING, LSE_YY1:DECIMAL, LSE_YY2:DECIMAL, AID_AMT:DECIMAL, AID_RPT:STRING, REMARK:STRING");
            }

            dsT_AD_AIDTRF.AddRow();
            
            document.getElementById("txtLSE_YY2").value = "99";
            
		}

		/********************************************
         * 08. 추가 함수 								*
         ********************************************/
        function fnc_Append() {
			//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 09. 제거 함수 								*
         ********************************************/
        function fnc_Remove() {
        	//이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {
			
	        document.getElementById("resultMessage").innerText = ' ';
	        
  			document.form1.cmdCEF_SEC_SHR.selectedIndex = 0;
  			
        	dsT_AD_AIDTRF.ClearData();
        	
        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
			
			if (dsT_AD_AIDTRF.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
        	window.close();
        	
        }

		/********************************************
         * 12. 검색 조건 유효성 검사  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //이곳에 해당 코딩을 입력 하세요
        }

		/********************************************
         * 13. 저장 유효성 체크  						*
         ********************************************/
        function fnc_SaveItemCheck() {
			
         	if ( !dsT_AD_AIDTRF.isUpdated ) {
         		
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
                
			}
         	
			return true;
			
        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            fnc_ConstructCommonCode("dsT_CM_COMMON_R2", "cmdCEF_SEC_SHR", "", "전 체");

            fnc_ConstructCommonCode("dsT_CM_COMMON_R2", "cmdCEF_SEC");
            fnc_ConstructCommonCode("dsT_CM_COMMON_R1", "cmdAID_CD");

            //직위
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_FROM", "", "전 체");
            fnc_ConstructCommonCode("dsT_CM_COMMON_A2", "cmbJOB_CD_TO", "", "전 체");
            document.getElementById("txtLSE_YY2").value = "99";


			cfStyleGrid_New(form1.grdT_AD_AIDTRF,15,"false","false");      // Grid Style 적용

            //모든 입력창 막기
            fnc_DisableElementAll(elementList);
			
        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        //입력 element
        var elementList = new Array(     "cmdCEF_SEC"
                                        ,"cmdAID_CD"
                                        ,"cmbJOB_CD_FROM"
                                        ,"cmbJOB_CD_TO"
                                        ,"txtLSE_YY1"
                                        ,"txtLSE_YY2"
                                        ,"medAID_AMT"
                                        ,"txtAID_RPT"
                                        ,"txtREMARK"
                                    );

        //제외 항목
        var exceptionList = new Array(   "cmdCEF_SEC"
                                        ,"cmdAID_CD"
                                  //      ,"cmbJOB_CD_FROM"   test
                                        ,"txtLSE_YY1"
                                      );

        //key list
        var keyList       = new Array(   "cmdCEF_SEC"
                                        ,"cmdAID_CD"
                                      );

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								   |
    | 2. 이름은 ds_ + 주요 테이블명(T_AD_AIDTRF)			 	   |
    | 3. 사용되는 Table List(T_AD_AIDTRF) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDTRF" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_AD_AIDTRF)			       |
    | 3. 사용되는 Table List(T_AD_AIDTRF)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDTRF" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDTRF=dsT_AD_AIDTRF,I:dsT_AD_AIDTRF=dsT_AD_AIDTRF)">
	</Object>

    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 경공조금 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R2"/>
       <jsp:param name="CODE_GUBUN"    value="R2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 지급내역 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R1"/>
       <jsp:param name="CODE_GUBUN"    value="R1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 직위 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_A2"/>
       <jsp:param name="CODE_GUBUN"    value="A2"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직			       |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDTRF Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("검색하신 조건의 자료가 없습니다!");
		} else {
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDTRF.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDTRF Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDTRF Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDTRF event="OnSuccess()">
		fnc_SearchList();
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDTRF event="OnFail()">
        alert(trT_AD_AIDTRF.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리 |    -- row가 변경된 후에 일어남
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_AD_AIDTRF event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);

        if(row > 0) {
            //신규일 경우
            if(dsT_AD_AIDTRF.RowStatus(row) == "1") {
                fnc_EnableElementAll(elementList);
            } else {
                fnc_EnableElementAll(elementList, exceptionList);
            }
        }
    </script>


    <!--------------------------+
    | 데이타 그리드를 선택했을때 처리  |   -- row가 변경되기 직전에 일어남
    +--------------------------->
    <script for=dsT_AD_AIDTRF event=CanRowPosChange(row)>
        var keyName;
        var colName;

        if(row > 0) {
            for(var i=0; i<keyList.length; i++) {
                keyName = keyList[i];
                colName = keyName.substring(3, keyName.length);

                if (dsT_AD_AIDTRF.NameString(row, colName) == "" ) {
                    alert("[ " + grdT_AD_AIDTRF.GetHdrDispName('-3', colName) + " ]은(는) 필수 입력사항입니다");
                    document.getElementById(keyName).focus();
                    return false;
                }
            }
        }
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

    <!-- power Search테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <colgroup>
                            <col width="60"></col>
                            <col width="600"></col>
                        </colgroup>
                        <tr>
                            <td class="searchState" align="right">구분</td>
                            <td class="padding2423" align="left">
                                <select id="cmdCEF_SEC_SHR" style="WIDTH: 15%" onChange="fnc_SearchList()"></select>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- power Search테이블 끝 -->

	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width="120"></col>
					<col width="80"></col>
					<col width=""></col>
				</colgroup>
				<tr>
					<td align="center" class="blueBold">구분</td>
					<td class="padding2423">
						<select id="cmdCEF_SEC" style="width:100px;"></select>
					</td>
					<td align="center" class="blueBold">지급내역</td>
					<td class="padding2423">
						<select id="cmdAID_CD" style="width:100px;"></select>
					</td>
                    <td align="center" class="blueBold">직위</td>
                    <td class="padding2423">
                        <select id="cmbJOB_CD_FROM" style="width:100px;" onChange="">
                        </select>
                        &nbsp;~&nbsp;
                        <select id="cmbJOB_CD_TO" style="width:100px;" onChange="">
                        </select>
                    </td>
				</tr>
				<tr>
					<td align="center" class="blueBold">기준(이상)</td>
					<td class="padding2423">
                        <input id="txtLSE_YY1" size="3" maxLength="3">
                    </td>
					<td align="center" class="blueBold">기준(미만)</td>
					<td class="padding2423">
                        <input id="txtLSE_YY2" size="3" maxLength="3">
                    </td>
					<td align="center" class="blueBold">금액</td>
					<td class="padding2423">
					   <table width="50%" border="0" >
							<tr>
								<td width="80%">
									<comment id="__NSID__"><object id="medAID_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:100%">
										<param name=Alignment				value=2>
										<param name=Border					value=true>
										<param name=ClipMode				value=true>
										<param name=DisabledBackColor		value="#EEEEEE">
										<param name=Enable					value=true>
										<param name=IsComma					value=true>
										<param name=Language				value=0>
										<param name=MaxLength				value=8>
										<param name=Numeric					value=true>
										<param name=NumericRange			value=0~+:0>
										<param name=ShowLiteral				value=false>
										<param name=Visible					value=true>
									</object></comment><script> __ShowEmbedObject(__NSID__); </script>
								</td>
								<td align="left">원</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="blueBold">증빙서류</td>
					<td class="padding2423" colspan="3"><input id="txtAID_RPT" maxLength="30" style="width:100%;"></td>
					<td align="center" class="blueBold">비고</td>
					<td class="padding2423"><input id="txtREMARK" maxLength="150" style="width:100%;"></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 조건 입력 테이블 끝 -->

	<!-- 조회 상태 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="paddingTop8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- 조회 상태 테이블 끝 -->

	<!-- 내용 조회 그리드 테이블 시작-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AD_AIDTRF" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" value="dsT_AD_AIDTRF">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"			width=40	name="NO"					align=center	value={String(Currow)}</C>
							<C> id="CEF_SEC"			width=80	name="구분"				align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R2:CODE:CODE_NAME"</C>
							<C> id="AID_CD"				width=100	name="지급내역"			align=center	Edit=none	EditStyle=Lookup  Data="dsT_CM_COMMON_R1:CODE:CODE_NAME"</C>
                            <C> id="JOB_CD_FROM"   	width=100  name="직위 From"      	align=center    EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"</C>
                            <C> id="JOB_CD_TO"     	width=100  name="직위 To"        	align=center    EditStyle=Lookup  Data="dsT_CM_COMMON_A2:CODE:CODE_NAME"</C>
							<C> id="LSE_YY1"			width=90	name="기준(이상)"		align=center	Edit=none</C>
							<C> id="LSE_YY2"			width=90	name="기준(미만)"		align=center	Edit=none</C>
							<C> id="AID_AMT"			width=100	name="지급금액"			align=right		Edit=none	RightMargin="10"</C>
							<C> id="AID_RPT"				width=150	name="증빙서류"			align=left		Edit=none</C>
							<C> id="REMARK"				width=110	name="비고"				align=left		Edit=none</C>
						'>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

	<!--**************************************************************************************
    *                                       												 *
	*	바인딩 컴포넌트																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AD_DONBOOK 설정 테이블 -->
	<object id="bndT_AD_AIDTRF" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDTRF">
		<Param Name="BindInfo", Value="
			<C>Col=CEF_SEC				Ctrl=cmdCEF_SEC				Param=value</C>
			<C>Col=AID_CD				Ctrl=cmdAID_CD					Param=value</C>
			<C>Col=JOB_CD_FROM		Ctrl=cmbJOB_CD_FROM			Param=value</C>
			<C>Col=JOB_CD_TO			Ctrl=cmbJOB_CD_TO				Param=value</C>
			<C>Col=LSE_YY1				Ctrl=txtLSE_YY1					Param=value</C>
			<C>Col=LSE_YY2				Ctrl=txtLSE_YY2					Param=value</C>
			<C>Col=AID_AMT				Ctrl=medAID_AMT				Param=text</C>
			<C>Col=AID_RPT				Ctrl=txtAID_RPT					Param=value</C>
			<C>Col=REMARK				Ctrl=txtREMARK					Param=value</C>
		">
	</object>