<!--
    ************************************************************************************
    * @Source         : chgmenu.jsp                                                    *
    * @Description    : Ȱ��ȭ �޴� ����.                                              *
    * @Font           : ����ü, 9Font ����Ͻð� Tab�� Space 4Byte�� ó�� �� �ּ���!   *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2008/03/10  |  ������   | �����ۼ�                                               *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>


<html>

    <head>
    <title>�ٷΰ���(chgmenu)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

    <script language="javascript">

        var mList = window.dialogArguments;

        function fnc_OnLoadProcess(){
            //ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdCHANGE_MENU,0,"false","false");      // Grid Style ����
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
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsCHANGE_MENU)   |
    | 3. ���Ǵ� Table List(CHANGE_MENU)           |
    +----------------------------------------------------------->
    <Object ID="dsCHANGE_MENU" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>

    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����      |
    +------------------------------------------------------>
    <Script For=dsCHANGE_MENU Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsCHANGE_MENU Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
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

<!-- form ���� -->
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
                    <C> id="MENU_ID"    width=200   name="�޴���"     align=left      LeftMargin=5                </C>
                '>
            </object>
            </comment><script> __ShowEmbedObject(__NSID__); </script>
        </td>
    </tr>
</table>
</form>

</body>

</html>