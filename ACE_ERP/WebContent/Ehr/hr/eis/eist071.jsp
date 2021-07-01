<!--
***********************************************************************
* @source      : eist071.jsp
* @description : 프로젝트조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/20      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>


<html>

<head>
<title>프로젝트조회</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>




    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var retObj = window.dialogArguments;


        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList(e) {


        	
            var COMM_CD = document.getElementById("txtCOMM_CD").value;

            dsT_CM_PROJECT.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist070.cmd.EIST070CMD&S_MODE=SHR_PJT&COMM_CD="+COMM_CD;
            
            dsT_CM_PROJECT.Reset();
            
            
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {



        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {


        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {



        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {



        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {



        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {



        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {



        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {



        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {



        }


        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

            window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            cfStyleGrid_New(form1.grdT_CM_PROJECT,15,"false","true");      // Grid Style 적용

            document.getElementById("txtCOMM_CD").focus();
            
        }

        /********************
         * 15. 확인처리  *
         *******************/

        function fnc_Confirm(row) {

	        retObj.pjt_cd  = dsT_CM_PROJECT.NameValue(row,'PJT_CD');
	        retObj.pjt_nm  = dsT_CM_PROJECT.NameValue(row,'PJT_NM');

	        window.close();

        }

        
        /********************
         * 16. 단축키 처리  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }
        
        
        function fnc_Nothing() {


	        alert("nothing better than you");

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
    | 2. 이름은 ds_ + 주요 테이블명()      |
    | 3. 사용되는 Table List()             |
    +----------------------------------------------->
    <Object ID="dsT_CM_PROJECT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="False">
        <Param Name="UseChangeInfo"   Value="False">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->


    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직              |
    +-------------------------------------------------->
    <Script For=dsT_CM_PROJECT Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			
        } else {
            alert("성공적으로 조회되었습니다.");
            //alert("18");
        }
    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PROJECT Event="OnLoadError()">



    </Script>



    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PROJECT Event="OnDataError()">



    </Script>


    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=grdT_CM_PROJECT event=OnDblClick(row,colid)>


        fnc_Confirm(row);

       
    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto  onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">



    <!-- form 시작 -->
    <form name="form1">


    <!-- 버튼 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList('2')"></a>
            </td>
        </tr>
    </table>
    <!-- 버튼 테이블 끝 -->



    <!-- power Search테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="120">
                                    <col width="">
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">프로젝트  코드/명&nbsp;</td>
                                    <td class="padding2423" align="left">
                                        <input name="txtCOMM_CD" id="txtCOMM_CD" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13){}">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
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
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_CM_PROJECT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:450px;height:400px;">
                                <param name="DataID"            value="dsT_CM_PROJECT">
                                <param Name="Editable"          value="false">
                                <param name=HiddenHScroll    	value="true">
                                <param name="Format"            value='
                                    <FC> id={currow}    width=50    name=NO           align=center  </FC>
                                    <FC> id=PJT_CD      width=120   name=프로젝트코드    align=center  </FC>                                    
                                    <FC> id=PJT_NM      width=250   name=프로젝트명      align=left    </FC>
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



    <!-- 조회 상태 테이블 시작 -->
    <table width="450" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">* 해당항목을 더블클릭 하시면 선택됩니다.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- 조회 상태 테이블 끝 -->
    </form>
    <!-- form 끝 -->

</body>
</html>


