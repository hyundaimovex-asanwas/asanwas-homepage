<!--*************************************************************************
* @source      : taxa220.jsp                                                *
* @description : ��õ¡�����곻�� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/26            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="common.util.DateUtil" %>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>��õ¡�����곻��(taxa220)</title>
    <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/general.css" rel="stylesheet" type="text/css">
    <script language=javascript src="/common/common.js"></script>
    <script language=javascript src="/common/input.js"></script>
    <script language=javascript src="/common/mdi_common.js"></script>
    <script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "F"   //����(ó��)
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�          

        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa220.cmd.TAXA220CMD";
        var params = null;


        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            var pis_ym      = document.getElementById("txtPIS_YM_SHR").value.split("-");
            var oDPT_CD     = document.getElementById("cmbDPT_CD_SHR");
            
            if(oPIS_YM.value == "") {
                alert("�ش����� ����ֽ��ϴ�.");
                oPIS_YM.focus();
                return;
            }            

            params = "&S_MODE=SHR"
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1]
                   + "&DPT_CD="+oDPT_CD.value;

            trT_AC_ETCPAY.KeyValue = "SAV(O:dsT_AC_ETCPAY=dsT_AC_ETCPAY)";
            trT_AC_ETCPAY.action = dataClassName+params;
            trT_AC_ETCPAY.post();     
        }        

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");
            if(oPIS_YM.value == "") 
                return;
                
            var pis_ym      = oPIS_YM.value.split("-");
            
            params = "&S_MODE=SHR_DPT"
                   + "&PIS_YY="+pis_ym[0]
                   + "&PIS_MM="+pis_ym[1];
        
            //�Ҽ� �ڵ带 �����´�.
            dsT_CM_COMMON_DPT.dataid = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD"+params;
            dsT_CM_COMMON_DPT.reset();   
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
            
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {

        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {
            var PIS_YYMM = document.getElementById("txtPIS_YM_SHR").value;
            var DPT_CD = document.getElementById("txtDPT_CD_SHR").value;

            var url = "taxa220_PV.jsp?PIS_YYMM="+PIS_YYMM + "&DPT_CD=" + DPT_CD;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
            return;
        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("��õ¡�����곻��", '', 225);  
        }


        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {

        }

        /********************************************
         * 08. �߰� �Լ�                                *
         ********************************************/
        function fnc_Append() {

        }

        /********************************************
         * 09. ���� �Լ�                                *
         ********************************************/
        function fnc_Remove() {

        }

        /********************************************
         * 10. �ʱ�ȭ �Լ�                           *
         ********************************************/
        function fnc_Clear() {
            document.getElementById("resultMessage").innerText = ' ';

            dsT_AC_ETCPAY.ClearData();
            
            document.getElementById("cmbDPT_CD_SHR").selectedIndex = 0;
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_ETCPAY.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {

        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {
            //ù��° �μ� : �׸����
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"false","false");      // Grid Style ����

            document.getElementById("txtPIS_YM_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM") %>";
            
            //�ڵ� ��ȸ
            fnc_SearchItem();
        }

        /********************************************
         * 15. ����Ű ó��                           *
         ********************************************/
        function fnc_HotKey() {
            fnc_HotKey_Process(btnList, event.keyCode);
        }

        /********************************************
         * 16. Form�� Active �� �� ó�� �� ��          *
         ********************************************/
        function fnc_FormActive(strID, winstat) {

        }

        /********************************************
         * ��Ÿ �Լ�              *
         ********************************************/
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_ETCPAY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <Object ID="dsT_CM_COMMON_DPT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_ETCPAY)                |
    | 3. ���Ǵ� Table List(T_AC_ETCPAY)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_ETCPAY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>


    <!--**************************************************************************************
    *                                                                                        *
    *   Component���� �߻��ϴ� Event ó����                                                       *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����                  |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>
    <Script For=dsT_CM_COMMON_DPT Event="OnLoadCompleted(iCount)">
        if (iCount > 0)    {
            fnc_ConstructCommonCode("dsT_CM_COMMON_DPT", "cmbDPT_CD_SHR", "", "�� ü");
        }
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_ETCPAY Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnSuccess()">

    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_ETCPAY event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
    <!-- ���� ������ ���� -->
    <iframe name="file_down" marginwidth="0" marginheight="0" frameborder="0" width="0" height="0" scrolling="no" ></iframe>

    <!-- Ķ���� ������-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form ���� -->
    <form name="form1">

    <!-- Ÿ��Ʋ �� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">��õ¡�����곻��</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">��õ¡�����곻��</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

    <!-- power Search���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td align="center" class="greenTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <colgroup>
                    <col width="80"></col>
                    <col width="100"></col>
                    <col width="80"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>
                    <td class="searchState" align="right">�ش���&nbsp;</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="fnc_SearchItem()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>
                    </td>
                    <td class="searchState" align="right">�Ҽ�&nbsp;</td>
                    <td class="padding2423" align="left">
                        <select id="cmbDPT_CD_SHR">
                        </select>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->

    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID4__">
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_AC_ETCPAY">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <FC> id="{CUROW}"            width=30        align=center        name="NO"         value={String(Currow)}    HeadBgColor="#F7DCBB"</FC>
                            <FC> id=DPT_NM               width=90        align=center        name="����"        HeadBgColor="#F7DCBB"</FC>
                            <G> name="����������"    HeadBgColor="#F7DCBB"
                                <C> id=NO_RTN           width=90        align=right    rightmargin=10        name="��ȯ�� (A)"        HeadBgColor="#F7DCBB"</C>
                                <C> id=NO_PAY           width=90        align=right    rightmargin=10        name="�̳��� (B)"        HeadBgColor="#F7DCBB"</C>
                            </G>
                            <X> name="�ݿ���õ¡����"      HeadBgColor="#F7DCBB"
                                <R>
                                    <G> name="���μҵ��(C) = (D+E+F)"           HeadBgColor="#F7DCBB"
                                        <C> id=LAB_AMT      width=90        align=right    rightmargin=10        name="�ٷμҵ� (D)"        HeadBgColor="#F7DCBB"</C>
                                        <C> id=RET_AMT      width=90        align=right    rightmargin=10        name="�����ҵ� (E)"        HeadBgColor="#F7DCBB"</C>
                                        <C> id=SO_AMT       width=90        align=right    rightmargin=10        name="��Ÿ�ҵ� (F)"        HeadBgColor="#F7DCBB"</C>
                                    </G>
                                    <C> id=YAC_AMT       width=140       align=right    rightmargin=10        name="����������ȯ�޺� (G)"        HeadBgColor="#F7DCBB"</C>
                                </R>
                            </X>
                            <G> name="��������"                 HeadBgColor="#F7DCBB"
                                <C> id=NO_YAC           width=140       align=right    rightmargin=10        name="�������� ��ȯ�޺�(H)"        HeadBgColor="#F7DCBB"</C>
                                <C> id=MON_RTN          width=140       align=right    rightmargin=10        name="���ȯ��(I) (A+B+C+G)"        HeadBgColor="#F7DCBB"</C>
                                <C> id=NO_MON           width=130       align=right    rightmargin=10        name="��ȯ�ޱ� (J)=(H+I)"        HeadBgColor="#F7DCBB"</C>
                            </G>
                            <X> name="�ݿ� ��õ¡�� ���μ���"     HeadBgColor="#F7DCBB"
                                <R>
                                    <G> name="�� �� �� ��"      HeadBgColor="#F7DCBB"
                                        <C> id=RETURN       width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                        <C> id=PAY          width=90        align=right    rightmargin=10        name="��  ��"        HeadBgColor="#F7DCBB"</C>
                                    </G>
                                </R>
                            </X>
                            <X> name="��� ��������"          HeadBgColor="#F7DCBB"
                                <R>
                                    <G> name="���νǼ�(���)" HeadBgColor="#F7DCBB"
                                        <C> id=CAL_RTN      width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                        <C> id=CAL_PAY      width=90        align=right    rightmargin=10        name="�߰�����"        HeadBgColor="#F7DCBB"</C>
                                    </G>
                                    <G> name="���νǼ�(�ݾ�)" HeadBgColor="#F7DCBB"
                                        <C> id=AMT_RTN      width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                        <C> id=AMT_PAY      width=90        align=right    rightmargin=10        name="�߰�����"        HeadBgColor="#F7DCBB"</C>
                                    </G>
                                    <G> name="�������"     HeadBgColor="#F7DCBB"
                                        <C> id=PGM_RTN      width=90        align=right    rightmargin=10        name="�� ȯ ��"        HeadBgColor="#F7DCBB"</C>
                                        <C> id=PGM_PAY      width=90        align=right    rightmargin=10        name="�߰�����"        HeadBgColor="#F7DCBB"</C>
                                    </G>
                                </R>
                            </X>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID4__); </script>
                    </td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- ���� ��ȸ �׸��� ���̺� ��-->

    </form>
    <!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->