<!--*************************************************************************
* @source      : bona060.jsp                                                *
* @description : ����ǥó�� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>����ǥó��(bona060)</title>
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
                    + "F"   //����
                    + "T"   //���
                    + "F"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
                    
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.bon.a.bona060.cmd.BONA060CMD";
        var params = null;
    

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;     
                   
                   

            fnc_DisableElementAll(procBtnList);
            fnc_ClearInputElement(oRsList, new Array(), "");
            
            dsT_CP_WORKLOG.ClearData();
            
            dsT_CP_WORKLOG.dataid = dataClassName+params;
            dsT_CP_WORKLOG.reset();
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

        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_CP_WORKLOG.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_CP_WORKLOG.GridToExcel("����ǥó��", '', 225);
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
            dsT_CP_WORKLOG.ClearData();
            dsRESULT.ClearData();
            fnc_ClearInputElement(oRsList, new Array(), "");
            
            
            document.getElementById("cmbOCC_CD").selectedIndex = 0;
            document.getElementById("cmbSEQ_NO").selectedIndex = 0;
            
            //��ư�� �ʱ�ȭ
            fnc_DisableElementAll(procBtnList);
            
            //�Է�â �ݱ�
            fnc_DisableElementAll(inputElementList);
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_CP_WORKLOG.IsUpdated)  {
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
            
            //�⵵ �ʱ�ȭ
            document.getElementById("txtPIS_YM").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            
            //��ư�� �ʱ�ȭ
            fnc_DisableElementAll(procBtnList);
            
            //�Է�â �ݱ�
            fnc_DisableElementAll(inputElementList);
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
        var oElementList = new Array(    "txtPIS_YM"
                                        ,"cmbOCC_CD"
                                        ,"txtPAY_YMD"
                                        ,"txtAPY_YMD");        

        //�׸���� �޼���                                        
        var oElementMsgList = new Array( "�ش���"
                                        ,"�ٷα���"
                                        ,"��������"
                                        ,"��ǥó��");     
                                        
        //���� �׸��
        var oExceptionList = new Array(  "txtPAY_YMD", "txtAPY_YMD");    
        var oExceptionList2= new Array(  "txtRE_PIS_YM");    
        
        //�Է��Ҷ� ���Ǵ� element�� (�⺻�� ��� ���ϰ� �ݾ� ����)
        var inputElementList = new Array("txtPAY_YMD"
                                        ,"txtAPY_YMD"
                                        ,"imgPAY_YMD"
                                        ,"imgAPY_YMD");

        
        //�۾� ���� �׸��
        var oRsList = new Array(         "txtPAY_YMD"
                                        ,"txtAPY_YMD"
                                        ,"txtWRK_NO1"
                                        ,"txtWRK_NO2"
                                        ,"txtPRO_STS"
                                        ,"txtPRO_STS_MSG");
        
        //��ư��                                
        var procBtnList = new Array(     "btnPROC1"                                        
                                        ,"btnPROC2"
                                        ,"btnPROC3"
                                        ,"btnPROC4"
                                        ,"btnPROC5");
        
        /**
         * DataSet�� �ʱ�ȭ ��Ŵ
         */
        function clearDS() {
            dsT_CP_WORKLOG.ClearData();
        }  
        
        /**
         * 1:�۾� OPEN
         */
        function fnc_proc1() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 0) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oPAY_YMD    = document.getElementById("txtPAY_YMD");
            var oAPY_YMD    = document.getElementById("txtAPY_YMD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("�۾� OPEN�� �Ͻðڽ��ϱ�? ") == false) return;
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC1"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&PAY_YMD="+oPAY_YMD.value.replace(/-/g, '')
                   + "&APY_YMD="+oAPY_YMD.value.replace(/-/g, '')
                   + "&SEQ_NO="+oSEQ_NO.value;   

            dsRESULT.ClearData();
            
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();                      
        }           
        
        /**
         * 2:�Ϲݰ�����(��)
         */
        function fnc_proc2() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }                        
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("�Ϲݰ����� (��) ��ǥ������ �Ͻðڽ��ϱ�? ") == false) return;
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC2"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;     

            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();         
        }        
        
        /**
         * 3:�ҵ漼/��Ÿ
         */
        function fnc_proc3() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("�ҵ漼/��Ÿ ��ǥ������ �Ͻðڽ��ϱ�? ") == false) return;
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC3"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;          

            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();        
        }
        
        /**
         * 4:�۾� CLOSE
         */
        function fnc_proc4() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }
        
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("��ǥ���� �۾��� CLOSE �Ͻðڽ��ϱ�? ") == false) return;
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC4"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;     
                   
            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();                
        }
        
        /**
         * 5:���۾�
         */
        function fnc_proc5() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList2)) return;
            if(dsT_CP_WORKLOG.CountRow != 1) {
                alert("��ȸ�� ���� ���ּ���.");
                return;
            }
        
            var oPRO_STS    = document.getElementById("txtPRO_STS");
            var oPIS_YM     = document.getElementById("txtPIS_YM");   
            var oOCC_CD     = document.getElementById("cmbOCC_CD");
            var oSEQ_NO     = document.getElementById("cmbSEQ_NO");
            
            if (confirm("��ó�� �۾��� �Ͻðڽ��ϱ�? ") == false) return;
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=PROC5"
                   + "&PRO_STS="+oPRO_STS.value
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&OCC_CD="+oOCC_CD.value
                   + "&SEQ_NO="+oSEQ_NO.value;          

            dsRESULT.ClearData();
            
            trT_CP_WORKLOG.KeyValue = "SVL(O:dsRESULT=dsRESULT)";
            trT_CP_WORKLOG.action = dataClassName+params;
            trT_CP_WORKLOG.post();         
        }
        

                    
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_WORKLOG)                |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CP_WORKLOG" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>  
    
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      
     
    
    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_WORKLOG)                |
    | 3. ���Ǵ� Table List(T_CP_WORKLOG)                      |
    +------------------------------------------------------>
    <Object ID="trT_CP_WORKLOG" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_CP_WORKLOG Event="OnLoadCompleted(iCount)">
        var oPRO_STS        = document.getElementById("txtPRO_STS");
        var oPRO_STS_MSG    = document.getElementById("txtPRO_STS_MSG");
    
        if(iCount == 0) {
            //alert("�ش� �ڷᰡ �������� �ʽ��ϴ�.");
            fnc_EnableElementAll(inputElementList);
            fnc_ChangeStateElement(true, "btnPROC1");
        } else if(iCount == 1) {
            oPRO_STS.value      = dsT_CP_WORKLOG.NameString(1, "PRO_STS");                               //�۾���Ȳ
            oPRO_STS_MSG.value  = dsT_CP_WORKLOG.NameString(1, "PRO_STS_MSG");

            document.getElementById("txtPAY_YMD").value = dsT_CP_WORKLOG.NameString(1, "PAY_YMD");  //��������
            document.getElementById("txtAPY_YMD").value = dsT_CP_WORKLOG.NameString(1, "APY_YMD");  //��ǥ�ۼ�����
            
            document.getElementById("txtWRK_NO1").value = dsT_CP_WORKLOG.NameString(1, "WRK_NO1");  //�Ϲݰ�����(��)
            document.getElementById("txtWRK_NO2").value = dsT_CP_WORKLOG.NameString(1, "WRK_NO2");  //�ҵ漼/��Ÿ
            
            //��ư�� �ʱ�ȭ
            fnc_DisableElementAll(procBtnList);
            if(oPRO_STS.value != 4) {
                fnc_ChangeStateElement(true, procBtnList[oPRO_STS.value]);
            }
            if(oPRO_STS.value != 1 && oPRO_STS.value != 4) {
                fnc_ChangeStateElement(true, procBtnList[4]);
            }        
        }
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        var oPRO_STS        = document.getElementById("txtPRO_STS");
        var oPRO_STS_MSG    = document.getElementById("txtPRO_STS_MSG");
    
        if(iCount == 0) {
            //alert("�ش� �ڷᰡ �������� �ʽ��ϴ�.");
        } else {
            //��� �޼��� �����ֱ�
            alert(dsRESULT.NameString(1, "RTN_MSG")+"\n���� �ӽ���ǥ���̺� ��� ���� ���� �ʿ�(HDAC_USER)");
            
            if(dsRESULT.NameString(1, "RTN_CD") == "0") {
                //��ȸ�� ���������� �̷�� ������ �ٽ� worklog�� ��ȸ��Ŵ
                fnc_SearchList();
            }        
        }    
    </Script>    

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
    <Script For=dsRESULT Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>    

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_CP_WORKLOG Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>  
    
    <Script For=dsRESULT Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>      

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnSuccess()">

    </script> 

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_CP_WORKLOG event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ǥó��</td>
                    <td align="right" class="navigator">HOME/�������/�󿩰���/<font color="#000000">����ǥó��</font></td>
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
                    <col width="70"></col>
                    <col width="110"></col>
                    <col width="70"></col>
                    <col width="130"></col>
                    <col width="150"></col>
                    <col width="*"></col>
                </colgroup>
                <tr>    
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD" id="cmbOCC_CD" onchange="clearDS()">
                            <option value="A">�繫��</option>
                            <option value="M">�ù���</option>
                        </select>
                    </td>      
                    <td class="searchState" align="right">�ش���</td>
                    <td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM" name="txtPIS_YM" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" onfocusout="clearDS()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype2','txtPIS_YM','','134','108');"></a>                        
                    </td>      
                    <td class="padding2423" align="left">
                        <select id="cmbSEQ_NO" name="cmbSEQ_NO">
                            <option value="1" selected>1����</option>
                            <option value="2">2����</option>
                        </select>
                    </td>        
                    <td class="padding2423" align="left"></td>                                                    
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->


    <!-- ���� �Է� ���̺� ���� -->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="80"></col>
                        <col width="170"></col>
                        <col width="80"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td align="center" class="creamBold">��������</td>
                        <td class="padding2423">
                            <input id="txtPAY_YMD" name="txtPAY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgPAY_YMD" id="imgPAY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtPAY_YMD','','75','112');"></a>
                        </td>
                        <td align="center" class="creamBold">��ǥ����</td>
                        <td class="padding2423">
                            <input id="txtAPY_YMD" name="txtAPY_YMD" size="12" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPAY_YMD','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" name="imgAPY_YMD" id="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype1','txtAPY_YMD','','75','112');"></a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">��ǥ��ȣ</td>
                        <td class="padding2423" colspan="3">
                            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                                <tr>
                                    <td rowspan="2" width="20">
                                    <td><b>�Ϲݰ����� (��)</b></td>
                                    <td><b>�ҵ漼/��Ÿ</b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>������ȣ&nbsp;<input id="txtWRK_NO1" name="txtWRK_NO1" type="text" class="input_ReadOnly" readonly></td>
                                    <td>������ȣ&nbsp;<input id="txtWRK_NO2" name="txtWRK_NO2" type="text" class="input_ReadOnly" readonly></td>
                                    <td></td>
                                </tr>
                            </table>
                        </td>
                    </tr>                    
                    <tr>
                        <td align="center" class="creamBold">�۾���Ȳ</td>
                        <td  class="padding2423" colspan="3">
                            <input id="txtPRO_STS" name="txtPRO_STS" style="width:5%"  class="input_ReadOnly" readonly>
                            <input id="txtPRO_STS_MSG" name="txtPRO_STS_MSG" style="width:94%"  class="input_ReadOnly" readonly>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="creamBold">�۾�����</td>
                        <td  class="padding2423" colspan="3">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC1" style="cursor:hand;width:140pt;height:25pt;" value=" �۾� OPEN " onclick="fnc_proc1()">
                                        <input type="button" id="btnPROC2" style="cursor:hand;width:140pt;height:25pt;" value=" �Ϲݰ����� (��) " onclick="fnc_proc2()">
                                        <input type="button" id="btnPROC3" style="cursor:hand;width:140pt;height:25pt;" value=" �ҵ漼/��Ÿ " onclick="fnc_proc3()">
                                    </td>
                                </tr>
                                <tr height="50">
                                    <td align="center" class="padding2423">
                                        <input type="button" id="btnPROC4" style="cursor:hand;width:140pt;height:25pt;" value=" �۾� COLSE " onclick="fnc_proc4()">
                                        <input type="button" id="btnPROC5" style="cursor:hand;width:285pt;height:25pt;" value=" ���۾�" onclick="fnc_proc5()">                              
                                    </td>
                                </tr>
                            </table>                    
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- ���� �Է� ���̺� �� -->
    

    </form>
    <!-- form �� -->

</body>
</html>


<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
