<!--*************************************************************************
* @source      : taxa211.jsp                                                *
* @description : ���漼������Ȳ���� �� PAGE                                         *
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
    <title>���漼������Ȳ���� ��(taxa211)</title>
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
        var btnList = "F"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����(ó��)
                    + "F"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "T"   //����
                    + "T";  //�ݱ�
                    
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa210.cmd.TAXA210CMD";
        var params = null;
        
        //�Ѿ�� ���� ó��
        var PIS_YY = "<%=request.getParameter("PIS_YY") %>";
        var PIS_MM = "<%=request.getParameter("PIS_MM") %>";
        var DPT_CD = "<%=request.getParameter("DPT_CD") %>";
    

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            
            params = "&S_MODE=SHR_DTL"
                   + "&PIS_YY="+PIS_YY
                   + "&PIS_MM="+PIS_MM
                   + "&DPT_CD="+DPT_CD;     
            
            dsT_AC_ETCPAY.dataid = dataClassName+params;
            dsT_AC_ETCPAY.reset();
        }   
        
        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
            
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
            //������ȿ�� �˻�                   
            if(dsT_AC_ETCPAY.CountColumn == 0) {
                alert("��ȸ�� ���� �Ͻñ� �ٶ��ϴ�");
                return;
            }
            if(!fnc_SaveItemCheck()) return;
            
            params = "&S_MODE=SAV_DTL"
                   + "&PIS_YY="+PIS_YY
                   + "&PIS_MM="+PIS_MM
                   + "&DPT_CD="+DPT_CD;
        
            trT_AC_ETCPAY.KeyValue = "SAV(I:dsSAVE=dsT_AC_ETCPAY)";
            trT_AC_ETCPAY.action = dataClassName+params;
            trT_AC_ETCPAY.post();
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AC_ETCPAY.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
            }
            
            var RowPosition = dsT_AC_ETCPAY.RowPosition;
            
 
             
            params = "&S_MODE=DEL_DTL"
                   + "&PIS_YY="+PIS_YY
                   + "&PIS_MM="+PIS_MM
                   + "&DPT_CD="+DPT_CD;
                   
            // Ư�� �÷��� ������ ���� ���θ� ���� ����.(�÷��� ���� �ٲ㼭 ����ϼ���)
            if (confirm("[" + RowPosition + ":" + dsT_AC_ETCPAY.ColumnString(RowPosition,2) + ":" + dsT_AC_ETCPAY.ColumnString(RowPosition,4) + "]�� �ڷḦ �����Ͻðڽ��ϱ�?") == false) return;
            dsT_AC_ETCPAY.DeleteRow(RowPosition);                 
        
            trT_AC_ETCPAY.KeyValue = "SAV(I:dsDEL=dsT_AC_ETCPAY)";
            trT_AC_ETCPAY.action = dataClassName+params;
            trT_AC_ETCPAY.post();     
        }

        /********************************************
         * 05. �μ� �Լ�                                *
         ********************************************/
        function fnc_Print() {

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_ETCPAY.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_ETCPAY.GridToExcel("���漼������Ȳ���� ��", '', 225);
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

            //���ڰ��� ���ε�
            var toDays = getTodayArray();
            document.getElementById("txtSTR_YMD_SHR").value = toDays[0]+"-"+toDays[1];
            document.getElementById("txtEND_YMD_SHR").value = toDays[0]+"-"+toDays[1];
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            window.close();       
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
            var oDataSet        = document.getElementById("dsT_AC_ETCPAY");
            var oGrid           = document.getElementById("grdT_AC_ETCPAY");
            var oElementValue   = null;
            var saveStatus      = null;
        
            //ds�� ���Ե� row ������ ������
            for(i=1; i<=oDataSet.CountRow; i++){
                //ds �Է� Ÿ���� insert ���� update������ ������
                //1:Insert
                //3:Update
                saveStatus = oDataSet.RowStatus(i);
        
                //�Է»��°� insert, update �϶� �׿� �׸�� ����
                if(saveStatus == 1 || saveStatus == 3) {
                    oElementValue = oDataSet.NameString(i, "ADD_TAG");   //�׸� �� ��������
                    if(!(oElementValue == "0" || oElementValue == "1")) {
                        alert(i+": ���� ���� 0�̰ų� 1�̿��� �մϴ�.");
                        oDataSet.RowPosition = i;
                        oGrid.SetColumn("ADD_TAG");
                        return false;
                    }
                    
                    oElementValue = oDataSet.NameString(i, "AMOUNT");
                    if(parseInt(oElementValue) <1 || parseInt(oElementValue) == 0) {
                        alert(i+": �ݾ��� ������ 0�� ������ �� �����ϴ�.");
                        oDataSet.RowPosition = i;
                        oGrid.SetColumn("AMOUNT");
                        return false;                        
                    }
                }
            }
            
            return true;            
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {   
            //ù��° �μ� : �׸����                                        
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)                
            cfStyleGrid(form1.grdT_AC_ETCPAY,0,"true","false");      // Grid Style ����

            fnc_SearchList();
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
        //���� ���ǵǾ� �ִ� �׸��
        var oElementList = new Array(    "ADD_TAG"
                                        ,"AMOUNT");                                               

        //�׸���� �޼���                                        
        var oElementMsgList = new Array( "����"
                                        ,"�ݾ�");     
                                        
        //���� �׸��
        var oExceptionList = new Array();    
                    
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
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
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
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("* �۾��� �Ϸ� �Ͽ����ϴ�!");
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
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���漼������Ȳ���� ��</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">���漼������Ȳ���� ��</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->    
    
    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                    </tr>
                </table>
            </td>
            <td class="paddingTop8" align="right"> ���� (0:��ȯ�޺�&nbsp;&nbsp;&nbsp;1:�̳��α�)</td>
        </tr>
    </table>
    <!-- ��ȸ ���� ���̺� �� -->    
    
    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="540" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <table border="0" cellspacing="0" cellpadding="0">
                <tr align="center">
                    <td>
                    <comment id="__NSID__">
                    <object id="grdT_AC_ETCPAY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:540px;height:350px;">
                        <param name="DataID" value="dsT_AC_ETCPAY">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"        width=60    align=center    name="NO"         value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM        width=150        align=center        name=" ��  �� "        Edit=none    Suppress=2</C>
                            <C> id=SAL_NM        width=110        align=center        name=" ��  �� "        Edit=none    Suppress=1</C>
                            <C> id=ADD_TAG       width=90         align=center        name="����"        </C>
                            <C> id=AMOUNT        width=110        align=right    rightmargin=10        name=" ��  �� "        </C>
                        '>
                    </object>
                    </comment><script> __ShowEmbedObject(__NSID__); </script>
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
