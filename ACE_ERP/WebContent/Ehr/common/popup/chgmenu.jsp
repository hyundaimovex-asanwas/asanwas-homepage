<!--
    ************************************************************************************
    * @Source         : chgmenu.jsp                                                    *
    * @Description    : 활성화 메뉴 변경.                                              *
    * @Font           : 굴림체, 9Font 사용하시고 Tab은 Space 4Byte로 처리 해 주세요!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2008/03/10  |  한학현   | 최초작성                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>

    <head>
    <title>바로가기(chgmenu)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->

    <script language="javascript">

        var mList = window.dialogArguments;

        function fnc_OnLoadProcess(){
            //첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
            //세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
            cfStyleGrid(form1.grdCHANGE_MENU,0,"false","false");      // Grid Style 적용
            form1.grdCHANGE_MENU.ColSizing = "false";
            //form1.grdCHANGE_MENU.IgnoreSelectionColor = "true";
            form1.grdCHANGE_MENU.ViewHeader = false;;

            dsCHANGE_MENU.setDataHeader("MENU_ID:STRING");

            for(var i=0; i<mList.length; i++){
                dsCHANGE_MENU.AddRow();

                dsCHANGE_MENU.NameValue(i+1,"MENU_ID") = mList[i][1].substring(0, mList[i][1].length-mList[i][0].length-2);
            }

            dsCHANGE_MENU.RowPosition = 1;

        }

    </script>

    </head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)*
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------------------+
    | 1. 조회 및 저장용 DataSet                                   |
    | 2. 이름은 ds_ + 주요 테이블명(dsCHANGE_MENU)   |
    | 3. 사용되는 Table List(CHANGE_MENU)           |
    +----------------------------------------------------------->
    <Object ID="dsCHANGE_MENU" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component에서 발생하는 Event 처리부                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직      |
    +------------------------------------------------------>
    <Script For=dsCHANGE_MENU Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsCHANGE_MENU Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <script language=JavaScript for=grdCHANGE_MENU event="OnClick(row,colid)">

       mList[row-1][2] = "T";
       window.close();

    </script>

    <script language=JavaScript for=grdCHANGE_MENU event="OnDblClick(row,colid)">

       mList[row-1][2] = "T";
       window.close();

    </script>

    <script language=javascript for=grdCHANGE_MENU event=OnReturn(row,colid)>

       mList[row-1][2] = "T";
       window.close();

    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

<!-- form 시작 -->
<form name="form1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
	    <td align="center">
	        <table width="248" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
	        <table width="248" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <tr>
                    <td align="center" class="creamBold" width="28"><img src="/images/common/chgmenu_no.gif" width="28" height="25"></td>
                    <td align="center" class="creamBold"><img src="/images/common/chgmenu_menu.gif" width="199" height="25"></td>
                    <td align="center" class="creamBold" width="17"><img src="/images/common/chgmenu_side.gif" width="17" height="25"></td>
                </tr>
	        </table>
	    </td>
    </tr>
    <tr>
        <td>
            <comment id="__NSID__">
            <object id="grdCHANGE_MENU" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:250px;height:232px;">
                <param name="DataID" value="dsCHANGE_MENU">
                <param name="Editable" value="false">
                <param name="DragDropEnable" value="true">
                <param name="SortView" value="Left">
                <param name="Format" value='
                    <C> id="{CUROW}"    width=29    name="NO"         align=center    value={String(Currow)}      </C>
                    <C> id="MENU_ID"    width=200   name="메뉴명"     align=left      LeftMargin=5                </C>
                '>
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
</form>

</body>

</html>