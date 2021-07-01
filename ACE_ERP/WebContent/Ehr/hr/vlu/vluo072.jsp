	<!--*************************************************************************
	* @source      : vluo072.jsp												*
	* @description : 면담일지 파일관리(조회용) PAGE                             *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
    * 2017/02/15           이 동 훈          	        최초작성
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<%
    String prmENO_NO    = request.getParameter("ENO_NO");
	String prmMEET_NO   = request.getParameter("MEET_NO");
	String prmMEET_GBN  = request.getParameter("MEET_GBN");	
	String prmEVL_YYYY  = request.getParameter("EVL_YYYY");	
	String prmIPT_YMD   = request.getParameter("IPT_YMD");	
%>

<html>
<head>
<title>면담일지 파일조회</title>
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

	<!-- 첨부 파일을 위해 -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->

	<script language="javascript">


        var prmENO_NO    = "<%=prmENO_NO %>";    //사번
        var prmMEET_NO   = "<%=prmMEET_NO %>";    //
        var prmMEET_GBN   = "<%=prmMEET_GBN %>";    // 
        var prmEVL_YYYY   = "<%=prmEVL_YYYY %>";    //        
        var prmIPT_YMD   = "<%=prmIPT_YMD %>";    //
        
		/********************************************
         * 01. 조회 함수_List 형태의 조회 			 	*
         ********************************************/
        function fnc_SearchList() {
        	
            //조회
            dsT_EV_MEETLIST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR_FILE&ENO_NO="+prmENO_NO+"&MEET_NO="+prmMEET_NO+"&EVL_YYYY="+prmEVL_YYYY;
            dsT_EV_MEETLIST.reset();        	

        }

		/********************************************
         * 02. 조회 함수_Item 형태의 조회  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. 저장 함수								*
         ********************************************/
        function fnc_Save() {
			
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

            dsT_EV_MEETLIST.UseChangeInfo = false;

			// save
			trT_EV_MEETLIST.KeyValue = "tr01(I:dsT_EV_MEETLIST=dsT_EV_MEETLIST)";
			trT_EV_MEETLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SAV_FILE";
			trT_EV_MEETLIST.post();

        }



		/********************************************
         * 04. 삭제 함수								*
         ********************************************/
        function fnc_Delete() {
			

        }

		/********************************************
         * 05. 인쇄 함수  								*
         ********************************************/
        function fnc_Print() {
			
         
            
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

			
			
        }

		/********************************************
         * 10. 초기화 함수  							*
         ********************************************/
        function fnc_Clear() {


        }

		/********************************************
         * 11. 화면 종료(닫기)  						*
         ********************************************/
        function fnc_Exit() {
            
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
			

			return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        
            //신청자 정보를 가지고옴
            document.getElementById("txtENO_NO").value = prmENO_NO;
        	
            //소속 조회
            dsT_EVL_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR_TEAM&ENO_NO="+prmENO_NO;
            dsT_EVL_TEAM.reset();

            document.getElementById('txtTEAM_NM').value = dsT_EVL_TEAM.NameValue(1,"TEAM_NM");              
            document.getElementById('txtJOB_NM').value = dsT_EVL_TEAM.NameValue(1,"JOB_NM");  
            document.getElementById("txtENO_NM").value = dsT_EVL_TEAM.NameValue(1,"ENO_NM");            
            
            
            var MEET_GB;
            
			if(prmMEET_GBN == "S"){
				
				MEET_GB = "목표설정";
				
			}else if(prmMEET_GBN == "M"){
				
				MEET_GB = "수시";
				
			}else if(prmMEET_GBN == "F"){
				
				MEET_GB = "정기(1차)";
				
			}else if(prmMEET_GBN == "G"){
				
				MEET_GB = "정기(2차)";
				
			}            

            document.getElementById("txtMEET_GBN").value = MEET_GB;
            document.getElementById("txtEVL_YYYY").value = prmEVL_YYYY;            
            document.getElementById("txtIPT_YMD").value = prmIPT_YMD;

            fnc_SearchList();
            
        }




        /********************************************
         * 첨부파일 처리								*
         ********************************************/
		function fnc_FileUpload() {
        	
            if(dsFILE.CountRow == 1) {
                alert("면담일지 파일은 하나만 업로드하시기 바랍니다.");
                return;
            }

            var key = dsT_EV_MEETLIST.NameValue(dsT_EV_MEETLIST.RowPosition, "FILE_KEY");

            
            if(key == "") {
            	
                key = "vluo071"+(new Date().getTime());
                
                dsT_EV_MEETLIST.NameValue(dsT_EV_MEETLIST.RowPosition, "FILE_KEY") = key;
                
            }

            if(!fnc_AddFileImg(key)) {
            	
                return;
                
            }
            
            
		}

		/********************************************
         * 첨부파일 삭제								*
         ********************************************/
		function fnc_FileDelete() {
			
            if(dsFILE.CountRow < 1) {
            	
                alert("삭제할 파일이 존재하지 않습니다.");
                
                return;
            }

            if( confirm("첨부된 파일을 삭제하시겠습니까?") ){
            	
                dsFILE.DeleteRow(dsFILE.RowPosition);
                
                fnc_DelFile();
                
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
    | 1. 조회 및 저장용 DataSet							   |
    | 2. 이름은 ds_ + 주요 테이블명(T_EV_MEETLIST)			   |
    | 3. 사용되는 Table List(T_EV_MEETLIST) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_MEETLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<Object ID="dsT_EVL_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton						   |
    | 2. 이름은 tr_ + 주요 테이블명(T_EV_MEETLIST)			       |
    | 3. 사용되는 Table List(T_EV_MEETLIST)				       |
    +------------------------------------------------------>
	<Object ID="trT_EV_MEETLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	


    <!-- 공통 콤보를 위한 DataSet -->
    <!-- 신청사유 구분 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Q3"/>
       <jsp:param name="CODE_GUBUN"    value="Q3"/>
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
	<Script For=dsT_EV_MEETLIST Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			
			alert("검색하신 조건의 자료가 없습니다!");
			
		} else {
			
			// 조회 자료가 1건 이상일 때 처리 할 내용 코딩
			//fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_MEETLIST.CountRow);
			
            //fnc_EnableElementAll(oElementList);
            
        }
    </Script>

    <!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리			   |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_EV_MEETLIST event=OnRowPosChanged(row)>
    
        //입력 못하게 막기
        //fnc_DisableElementAll(oElementList);

        if(row > 0) {
            //등록된 파일들 조회
            fnc_GetFileList(dsT_EV_MEETLIST.NameValue(row, "FILE_KEY"));

        }
	</script>


	<!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_MEETLIST Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

	<Script For=dsT_EV_MEETLIST Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>


	<!-----------------------------------------------------+
    | Transaction Successful 처리     						   |
    +------------------------------------------------------>
	<script for=trT_EV_MEETLIST event="OnSuccess()">
	
        //에러 메세지가 있는 여부를 파악한 후 알림
    </script>
    

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   				       |
    +------------------------------------------------------>
	<script for=trT_EV_MEETLIST event="OnFail()">
        alert(trT_EV_MEETLIST.ErrorMsg);
    </script>
    


	<!-- 파일 그리드 클릭시 다운로드 되게 -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
    
        if(row > 0) {
        	
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
           
            // 첨부 파일이 존재하는 경우만 수행하게~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
            }
        }
        
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

	<!-- 캘린더 프레임-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form 시작 -->
	<form name="form1">

	<!-- 타이틀 바 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">면담일지 파일조회</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- 타이틀 바 테이블 끝 -->

	<!-- 버튼 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)" style="cursor:hand;">
            	<!--  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)" style="cursor:hand;"> -->
	            <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)" style="cursor:hand;">
			</td>
		</tr>
	</table>
	<!-- 버튼 테이블 끝 -->

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

	<!-- 조건 입력 테이블 시작 -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="80"></col>
				<col width="80"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
            <td align="center" class="blueBold">사&nbsp;&nbsp;번</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" class="input_ReadOnly"  size="10" maxlength= "8" readonly>
            </td>
            <td align="center" class="blueBold">성&nbsp;&nbsp;명</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" class="input_ReadOnly"  size="14" maxlength= "14" readonly>
            </td>
			<td align="center" class="blueBold">직위</td>
			<td class="padding2423">
				<input id="txtJOB_NM" class="input_ReadOnly" size="10" readonly>
			</td>
			<td align="center" class="blueBold">팀</td>
			<td class="padding2423">
				<input id=txtTEAM_NM class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	
	
	<tr>
		<td colspan="8" height = "20" class="paddingTop8"></td>
	</tr>	
	
	
	<tr>
		<td colspan="8" class="paddingTop8"><img src="../../images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">면담일지 첨부</td>
	</tr>


	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>	
				<col width="80"></col>
				<col width="100"></col>	
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="blueBold">면담구분</td>
			<td class="padding2423">
				    <input type="text" id="txtMEET_GBN"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
    		</td>


			<td align="center" class="blueBold">연도</td>
				<td class="padding2423">
				    <input type="text" id="txtEVL_YYYY"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
				</td>
				
			<td align="center" class="blueBold">작성일자</td>
				<td class="padding2423">
				    <input type="text" id="txtIPT_YMD"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
				</td>



			<td align="center"></td>

		</tr>

		<tr>
			<td align="center" class="blueBold">면담일지<br>첨부</td>
			<td class="padding2423" colspan="6">
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:60px;">
                    <param name="DataID" 				value="dsFILE">
                    <param name="Editable" 				value="false">
                    <param name="DragDropEnable" 		value="true">
                    <param name="SortView" 				value="Left">
                    <param name=ViewHeader  			value="false">
                    <param name="Format" 				value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="270"     name="파일명"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)"><img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
			</td>
		</tr>

			</table>
			</td>
		</tr>

	</table>
	<!-- 조건 입력 테이블 끝 -->

	</form>
	<!-- form 끝 -->

</body>
</html>

