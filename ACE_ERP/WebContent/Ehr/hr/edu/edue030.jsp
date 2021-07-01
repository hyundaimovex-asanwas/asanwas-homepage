<!--
    ************************************************************************************
    * @Source         : edue030.jsp                                                         *
    * @Description    : 교육신청서 PAGE                                                   *
    * @Developer Desc :                                                                         *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    *-------------+-----------+--------------------------------------------------------+
    * 2016/05/11  |  정영식   | 소스이전                                                    *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>

    <head>
    <title>수강신청</title>
    <jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">
	
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >


        var edu_cd      = '';
        var edu_nm      = '';
        var seq_no      = '';
        var chasu_tag   = '';
        var edu_str_ymd = '';
        var edu_end_ymd = '';

        var opener = window.dialogArguments;

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {
            
        	var FIELD_CD = document.getElementById("cmbFIELD_CD_SHR").value;
            var SHAPE_CD = document.getElementById("cmbSHAPE_CD_SHR").value;
            var EDU_CD   = document.getElementById("txtEDU_CD_SHR").value;

            dsT_ED_COURSELIST.ClearData();

            dsT_ED_COURSELIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.e.edue030.cmd.EDUE030CMD&S_MODE=SHR&FIELD_CD="+FIELD_CD+"&SHAPE_CD="+SHAPE_CD+"&EDU_CD="+EDU_CD;
            
            dsT_ED_COURSELIST.Reset();

            form1.grdT_ED_COURSELIST.Focus();

        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

            document.getElementById("cmbFIELD_CD_SHR").value = '';
            document.getElementById("cmbSHAPE_CD_SHR").value = '';
            document.getElementById("txtEDU_CD_SHR").value   = '';
            document.getElementById("txtEDU_NM_SHR").value   = '';

            document.getElementById("resultMessage").innerText = ' ';

            dsT_ED_COURSELIST.ClearData();

        }

        /******************************
         * 11. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 12. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            //이곳에 해당 코딩을 입력 하세요

        }

        /********************************************
         * 13. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //Grid Style 적용
            cfStyleGrid_New(form1.grdT_ED_COURSELIST,0,"false","false");

            //교육분야
            for( var i = 1; i <= dsCOMMON_Q5.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q5.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q5.NameValue(i,"CODE_NAME");
                document.getElementById("cmbFIELD_CD_SHR").add(oOption);

            }

            //교육형태
            for( var i = 1; i <= dsCOMMON_Q8.CountRow; i++ ) {

                oOption       = document.createElement("OPTION");
                oOption.value = dsCOMMON_Q8.NameValue(i,"CODE");
                oOption.text  = dsCOMMON_Q8.NameValue(i,"CODE_NAME");
                document.getElementById("cmbSHAPE_CD_SHR").add(oOption);

            }

            //팝업시 코드를 가져온다.
            if (opener != null){
                document.getElementById("txtEDU_CD_SHR").value = opener.edu_cd;
            }

            fnc_SearchList();
        }


        /********************************************
         * 14. 종료버튼 클릭시 수행하는 함수        *
         *******************************************/
        function fnc_Exit() {


                window.close();

                
        }

        /********************
         * 15. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_ED_COURSELIST)|
    | 3. 사용되는 Table List(T_ED_COURSELIST)       |
    +----------------------------------------------->
    <Object ID="dsT_ED_COURSELIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_ED_MAXSEQNO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- 교육주관 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q7"/>
       <jsp:param name="CODE_GUBUN"    value="Q7"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육분야 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q5"/>
       <jsp:param name="CODE_GUBUN"    value="Q5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!-- 교육형태 -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_Q8"/>
       <jsp:param name="CODE_GUBUN"    value="Q8"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <Script For=grdT_ED_COURSELIST Event="OnDblClick(row, col)">
        edu_cd      = dsT_ED_COURSELIST.NameValue(row, "EDU_CD");
        edu_nm      = dsT_ED_COURSELIST.NameValue(row, "EDU_NM");
        seq_no      = dsT_ED_COURSELIST.NameValue(row, "SEQ_NO");
        chasu_tag   = dsT_ED_COURSELIST.NameValue(row, "CHASU_TAG");
        edu_str_ymd = dsT_ED_COURSELIST.NameValue(row, "EDU_STR_YMD");
        edu_end_ymd = dsT_ED_COURSELIST.NameValue(row, "EDU_END_YMD");
        comm_no     = dsT_ED_COURSELIST.NameValue(row, "COMM_NO");

        //window.showModalDialog("/hr/edu/edue031.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
        //window.showModalDialog("/hr/edu/edue032.jsp", self, "dialogHeight:620px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        if(col == "FUNC"){
	        var obj = new String();
	        obj.edu_cd = dsT_ED_COURSELIST.NameValue(row, "EDU_CD");
	        obj.seq_no = dsT_ED_COURSELIST.NameValue(row, "SEQ_NO");

            window.showModalDialog("../../hr/edu/edue032.jsp", self, "dialogHeight:850px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        }else{
	        edu_cd  = dsT_ED_COURSELIST.NameValue(row, "EDU_CD");

			dsT_ED_MAXSEQNO.ClearData();
            dsT_ED_MAXSEQNO.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.h.eduh032.cmd.EDUH032CMD&S_MODE=SHR_CHASU&EDU_CD="+edu_cd;
            
            dsT_ED_MAXSEQNO.Reset();

            seq_no      = dsT_ED_MAXSEQNO.NameValue(1, "MAX_CHASU");

	        window.showModalDialog("../../hr/edu/edue051.jsp", self, "dialogHeight:660px; dialogWidth:870px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

	    }
    </Script>

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_ED_COURSELIST Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

            fnc_Message(document.getElementById("resultMessage"), "MSG_03", dsT_ED_COURSELIST.CountRow );

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_ED_COURSELIST Event="OnDataError()">

        //Dataset관련 Error 처리
        cfErrorMsg(this);

    </Script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->
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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                            <tr>
                                <td align="right" class="searchState">분야: </td>
                                <td class="padding2423" align="left">
                                    <select id="cmbFIELD_CD_SHR">
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">형태: </td>
                                <td class="padding2423" align="left">
                                    <select id="cmbSHAPE_CD_SHR">
                                        <option value="">전체</option>
                                    </select>
                                </td>
                                <td align="right" class="searchState">교육과정 </td>
                                <td class="padding2423">
                                    <input id="txtEDU_CD_SHR" size="10" maxlength= "10" onkeypress="if(event.keyCode==13) fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');" >
                                    <input id="txtEDU_NM_SHR" size="30" maxlength= "200" class="input_ReadOnly" onkeypress="if(event.keyCode==13) fnc_SearchList();">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEduCd','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEduCd" name="ImgEduCd" width="21" height="20" border="0" align="absmiddle" onclick="fnc_eduCodeSearchPopup('txtEDU_CD_SHR','txtEDU_NM_SHR');"></a>
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
                        <object    id="grdT_ED_COURSELIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:510px;">
                            <param name="DataID"                  value="dsT_ED_COURSELIST">
                            <param name="EdiTABLE"                value="false">
                            <param name="DragDropEnable"          value="true">
                            <param name="SortView"                value="Left">
                            <param name="VIEWSUMMARY"             value=0>
                            <param name="Format"                  value="
                                <C> id='{currow}'     		width=50    name='순번'            align=center </C>
                                <C> id='EDU_NM'       		width=400   name='과정명'        align=left   </C>
                                <C> id='EDU_GBN_NM'   	width=100    name='구분'            align=center </C>
                                <C> id='FIELD_NM'     		width=100    name='분야'            align=center </C>
                                <C> id='SHAPE_NM'     	width=100    name='형태'            align=center </C>
                                <C> id='MNGER_NM'     	width=100    name='주관'            align=center </C>
                                <C> id='INS_NM'       		width=100    name='고용보험'      align=center show=false</C>
                                <C> id='FUNC'         			width=100    name='기능'           align=center Color='Blue' value={'수강신청'} </C>
                            ">
                        </object>
                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- 내용 조회 그리드 테이블 끝-->

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop8">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="top" class="searchState">* 해당 항목을 더블클릭 하시면 과정 상세 정보를 조회할 수 있습니다.</td>
                </tr>
                <tr>
                    <td valign="top" class="searchState">* '수강신청' 셀을  더블클릭 하시면  신청할 수 있습니다.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 