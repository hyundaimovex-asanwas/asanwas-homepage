	<!--*************************************************************************
	* @source      : eist050.jsp												*
	* @description : 인건비 배부 엑셀 Upload PAGE								 	*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2017/02/16            이동훈         	        최초작성					        *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();
    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>인건비 배부 엑셀 Upload</title>
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
    *	자바스크립트 함수 선언부분  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


        var today = gcurdate;
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {

            //이곳에 해당 코딩을 입력 하세요

            //검색조건
            var PIS_YM = document.getElementById("txtPIS_YM").value;

            //데이터셋 전송
            dsT_TS_LABORCOST.UseChangeInfo = true;
            dsT_TS_LABORCOST.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=SHR&PIS_YM="+PIS_YM;
            dsT_TS_LABORCOST.Reset();

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

            var PIS_YM    	= document.getElementById("txtPIS_YM").value;
            
            if(confirm("저장하시겠습니까?")){           
            	

				// save
				trT_TS_LABORCOST.KeyValue = "tr01(I:dsT_TS_LABORCOST=dsT_TS_LABORCOST, O:dsRESULT=dsRESULT)";
				trT_TS_LABORCOST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=SAV&PIS_YM="+PIS_YM;
				trT_TS_LABORCOST.post();

            }				
				
        }

		/********************************************
         * 03. 처리 함수								*
         ********************************************/
        function fnc_Conduct() {

            //검색조건
            var PIS_YM  = document.getElementById("txtPIS_YM").value;

            if(confirm("처리하시겠습니까?")){

					//트랜잭션 전송
					trT_TS_LABORCOST.KeyValue = "SVL(I:SAV=dsT_TS_LABORCOST)";
					trT_TS_LABORCOST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=SAV_01&PIS_YM="+PIS_YM;
					trT_TS_LABORCOST.Post();					
					
			}
            
			fnc_SearchList();
			
        }



		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {

            // 삭제 할 자료가 있는지 체크하고
            if (dsT_TS_LABORCOST.CountRow < 1) {
            	
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                
                return;
            }
            
            var PIS_YM  = document.getElementById("txtPIS_YM").value;

            if(confirm("전체 삭제하시겠습니까?")){
            	
				trT_TS_LABORCOST.KeyValue = "tr01(I:dsT_TS_LABORCOST=dsT_TS_LABORCOST)";
				trT_TS_LABORCOST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=DEL&PIS_YM="+PIS_YM;
				trT_TS_LABORCOST.post();
				
			}
            
			fnc_SearchList();
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

        }

		/********************************************
         * 07. 신규 함수 								*
         ********************************************/
        function fnc_AddNew() {

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

        	dsT_TS_LABORCOST.ClearData();

        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_TS_LABORCOST.IsUpdated)  {
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

         	if (!dsT_TS_LABORCOST.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_TS_LABORCOST,15,"true","true");      // Grid Style 적용

            document.getElementById("txtPIS_YM").value = gcurdate.substring(0,7);  //getTodayArray()[0]+"-"+getTodayArray()[1];
            
            fnc_SearchList();

        }

		/********************************************
         * 15. 단축키 처리 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}




        /*****************************
         * 16. 엑셀파일 업로드 처리  *
         ****************************/
         function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //확인을 클릭했는지 여부 검증
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            // 해당 Dataset의 Header가 없으면 Header 선언
            if (dsFILE_UPLOAD.CountColumn < 1) {
                dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** 열려있는 파일 읽기 */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_TS_LABORCOST=dsT_TS_LABORCOST, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=ULD";
                trFILE_UPLOAD.post();
            }

        }



    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 DataSet								|
    | 2. 이름은 ds_ + 주요 테이블명(T_WL_CARDUP)			|
    | 3. 사용되는 Table List(T_WL_CARDUP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_TS_LABORCOST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_CM_PERSON)			   |
    | 3. 사용되는 Table List(T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trT_TS_LABORCOST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_TS_LABORCOST=dsT_TS_LABORCOST,I:dsT_TS_LABORCOST=dsT_TS_LABORCOST)">
	</Object>


    <!-- 결과 result -->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 가우스 파일 오브젝트 -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='첨부파일'>
        <param name="Enable"    value="true">
    </object>

    <!-- 데이터셋 컴포넌트 선언 [파일 첨부용] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"  value="true">
    </object>

    <!-- 트랜젝션 컴포넌트 선언 [파일 첨부용] -->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name="KeyName"   value="dataid">
    </Object>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //에러 메세지가 있는 여부를 파악한 후 알림
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>


	<!--**************************************************************************************
    *                                       												 *
    *	Component에서 발생하는 Event 처리부														 *
    *                                       												 *
    ***************************************************************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_TS_LABORCOST Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_TS_LABORCOST.UserStatus(i) = 1;
            }
        }
    </Script>

	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_TS_LABORCOST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<!-----------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때 	   |
    +------------------------------------------------------>
	<Script For=dsT_TS_LABORCOST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_TS_LABORCOST event="OnSuccess()">
	        fnc_SearchList();
    </script>


	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   						   |
    +------------------------------------------------------>
	<script for=trT_TS_LABORCOST event="OnFail()">
        alert(trT_TS_LABORCOST.ErrorMsg);
    </script>
    <script for=trFILE_UPLOAD event="OnFail()">
        alert(trFILE_UPLOAD.ErrorMsg);
    </script>

 	<!-----------------------------------------------------+
    | Row 추가후 다른행으로 position 옮길때 처리				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_TS_LABORCOST event=CanRowPosChange(row)>
	
		if ( dsT_TS_LABORCOST.NameValue(row,"ENO_NO") == "" ) {
			
			alert("[ " + grdT_TS_LABORCOST.GetHdrDispName('-3','ENO_NO') + " ]는 필수 입력사항입니다");
			
			return false;
			
		}

	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- 켈린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
		<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','../../images/button/btn_ConductOver.gif',1)"><img src="../../images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct()"></a>
				&nbsp;&nbsp;
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">해당년월</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) cfCheckNumber(); " onkeyup="cfDateHyphen(this);" style="ime-mode:disabled"  onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('날짜형식에 맞지않습니다.'); this.value='';} ">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YM"  name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM','','10','116');"></a>
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


    <!-- 조회 상태 테이블 시작 -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    		<td class="paddingTop8">
    			<table width="100%" border="0" cellspacing="0" cellpadding="0">
    				<tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>

                        <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                        </td>
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
					<object id="grdT_TS_LABORCOST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:520px;">
						<param name="DataID" 				value="dsT_TS_LABORCOST">
						<param name="Editable" 				value="false">
						<param name="DragDropEnable" 		value="true">
						<param name="SortView" 				value="Left">
                        <param name="SuppressOption"    	value="1">							
						<param name="ViewSummary"  			value="1">								
						<param name="Format" 				value="						
							<C> Name='소속'				ID=TEAM_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, Edit=none, sort=true SumBgColor=#C3D0DB </C>
							<C> Name='직위'				ID=JOB_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB </C>
							<C> Name='사번'				ID=ENO_NO		HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB </C>
							<C> Name='성명'				ID=ENO_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB SumText='총계'</C>
							<C> Name='급여'				ID=SAL_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>							
							<C> Name='퇴직\\급여'			ID=RET_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='4대\\보험'			ID=INS_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='중식대'				ID=LUN_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='복지\\카드'			ID=WEL_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>							
							<C> Name='복지\\카페'			ID=O7_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='통근\\버스'			ID=BUS_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='주차\\보조금'		ID=PARK_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='유류\\보조금'		ID=OIL_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='합계'				ID=SUM_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>

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

