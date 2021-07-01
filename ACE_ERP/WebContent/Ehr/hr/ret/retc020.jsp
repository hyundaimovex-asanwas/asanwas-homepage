<!--*************************************************************************
* @source      : retc020.jsp                                                *
* @description : ����ȸ�����Է� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/03/23            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>
<%
    Configuration conf = Configuration.getInstance();
    
    String FILEURL = conf.get("framework.file.excel");
%>
<html>
<head>
    <title>����ȸ�����Է�(retc020)</title>
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
                    + "T"   //����
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "T"   //����
                    + "T";  //�ݱ�
                    
        var today = getToday(); 
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.c.retc020.cmd.RETC020CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_SearchItemCheck()) return;
        
            var oPIS_YY = document.getElementById("txtPIS_YY");   
            var oBNK_CD = document.getElementById("cmbBNK_CD");   
            
            params = "&S_MODE=SHR"
                   + "&PIS_YY="+oPIS_YY.value
                   + "&BNK_CD="+oBNK_CD.value;            
            
            dsT_AC_RETINSURANCE.dataid = dataClassName+params;
            dsT_AC_RETINSURANCE.reset();
        }   
        
        /**
         * EXCEL ��� ������ ���ε� ��Ű�� DS�� �߰� ���Ѽ� ��������
         */
        function fnc_FileUpload() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_SearchItemCheck()) return;        
        
            //file�� binding ��Ų��.
            if(!bindingFile()) return;
            
            var oPIS_YY = document.getElementById("txtPIS_YY");   
            var oBNK_CD = document.getElementById("cmbBNK_CD");               
            
            params = "&S_MODE=ULD"
                   + "&PIS_YY="+oPIS_YY.value
                   + "&BNK_CD="+oBNK_CD.value    
                   + "&BNK_NM="+oBNK_CD.options[oBNK_CD.selectedIndex].text;    
            
            //ds���� ���� ���ε�
            trFILE_UPLOAD.KeyValue = "TR_FILE"
                                   + "(I:dsFILE_UPLOAD=dsFILE_UPLOAD"                   //���ε��� ����
                                   + ",O:dsT_AC_RETINSURANCE=dsT_AC_RETINSURANCE)";     //��� ����Ʈ

            trFILE_UPLOAD.action = dataClassName+params;
            trFILE_UPLOAD.post();                                  
        }          
        
        /**
         * DataSet �� FILE �� ���ε� ��Ų��.
         */
        function bindingFile() {
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();
            
            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;
            
            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;            
            
            return true;
        }  

        /********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ                *
         ********************************************/
        function fnc_SearchItem() {
                dsT_CM_COMMON_BK.DataID = dataClassName+"&S_MODE=ITM_SHR";
                dsT_CM_COMMON_BK.Reset();           
        }

        /********************************************
         * 03. ���� �Լ�                                *
         ********************************************/
        function fnc_Save() {
            if (dsT_AC_RETINSURANCE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
            }
            
            //DataSet�� �Է»��·� ����
            dsT_AC_RETINSURANCE.UseChangeInfo = false;                 
                    
            trT_AC_RETINSURANCE.KeyValue = "TR_SAV(I:dsT_AC_RETINSURANCE=dsT_AC_RETINSURANCE, O:dsRESULT=dsRESULT)";
            trT_AC_RETINSURANCE.action = dataClassName+"&S_MODE=SAV";
            trT_AC_RETINSURANCE.post();

            //fnc_SearchList();          
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {
            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_AC_RETINSURANCE.CountRow < 1) {
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                alert("* ���� �� �ڷᰡ �����ϴ�!");
                return;
            }
            
            //DataSet�� �Է»��·� ����
            dsT_AC_RETINSURANCE.UseChangeInfo = false;       
            
            trT_AC_RETINSURANCE.KeyValue = "TR_SAV(I:dsT_AC_RETINSURANCE=dsT_AC_RETINSURANCE)";
            trT_AC_RETINSURANCE.Action = dataClassName+"&S_MODE=DEL";
            trT_AC_RETINSURANCE.post();       
            fnc_SearchList();    
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
            if (dsT_AC_RETINSURANCE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETINSURANCE.GridToExcel("����ȸ�����Է�", '', 225);
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
            
            dsT_AC_RETINSURANCE.ClearData();
            dsFILE_UPLOAD.ClearData();
            
            document.getElementById("cmbBNK_CD").selectedIndex = 0;
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETINSURANCE.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            frame = window.external.GetFrame(window);
            frame.CloseFrame();           
        }

        /********************************************
         * 12. �˻� ���� ��ȿ�� �˻�                     *
         ********************************************/
        function fnc_SearchItemCheck() {
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
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
            //����ȸ��� ��������
            fnc_SearchItem();
        
            var oSelect = null;
            var oOption = null;
        
            // �ٷα��� ���� �˻� �޺��ڽ� ����
            oSelect = document.getElementById("cmbBNK_CD");
            //ù��° ������ ������ ��� option ����
            for(i=oSelect.options.length-1; i>0; i--) {
                oSelect.remove(i);
            }            
            for(i = 1; i <= dsT_CM_COMMON_BK.CountRow; i++ ) {
                oOption       = document.createElement("OPTION");
                oOption.value = dsT_CM_COMMON_BK.NameValue(i,"CODE");
                oOption.text  = dsT_CM_COMMON_BK.NameValue(i,"CODE_NAME");
                oSelect.add(oOption);
            }            

            //ù��° �μ� : �׸����                                        
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)                
            cfStyleGrid(form1.grdT_AC_RETINSURANCE,0,"true","false");      // Grid Style ����
            
            // ���� ÷�ο� �����ͼ��� ��� ���� ����.
            dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            
            document.getElementById("txtPIS_YY").value = getTodayArray()[0];
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
        var oElementList = new Array(    "txtPIS_YY"
                                        ,"cmbBNK_CD");        

        //�׸���� �޼���                                        
        var oElementMsgList = new Array( "���ؿ���"
                                        ,"����ȸ�籸��");     
                                        
        //���� �׸��
        var oExceptionList = new Array(  );    
                      
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETINSURANCE)                |
    | 3. ���Ǵ� Table List(T_AC_RETINSURANCE)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINSURANCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>    
    
    <Object ID="dsT_CM_COMMON_BK" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      
    
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload" Value="True">
        <Param Name="UseChangeInfo" Value="True">
        <Param Name="ViewDeletedRow" Value="False">
    </Object>       
    
    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>        
    
    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETINSURANCE)                |
    | 3. ���Ǵ� Table List(T_AC_RETINSURANCE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINSURANCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>    
    
    <!-----------------------------------------------------+
    | 1. FILE UPLOAD��  Data Transacton                       |
    +------------------------------------------------------>    
    <Object ID="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETINSURANCE Event="OnLoadCompleted(iCount)">
        if (iCount == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
            alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINSURANCE.CountRow);
        }
    </Script>
    
    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }  
        }
    </Script>       

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINSURANCE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINSURANCE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>  

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINSURANCE event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        //alert("�۾��� �Ϸ� �Ͽ����ϴ�!");
    </script>
    
    <script for=trFILE_UPLOAD event="OnSuccess()">
        document.getElementById("resultMessage").innerText = "����÷�ΰ� �Ϸ�Ǿ����ϴ�."; 
    </script>    

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINSURANCE event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    <script for=trFILE_UPLOAD event="OnFail()">
        cfErrorMsg(this);
    </script>    
    

    <!-----------------------------------------------------+
    | Grid Head Check event ó��                                   |
    +------------------------------------------------------>    
    <script language="javascript" for=grdT_AC_RETINSURANCE event=OnHeadCheckClick(Col,Colid,bCheck)>
        for(var i=1; i<=dsT_AC_RETINSURANCE.CountRow; i++) {
            dsT_AC_RETINSURANCE.NameValue(i, "STATUS") = bCheck;
        }
        
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ȸ�����Է�</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����������/<font color="#000000">����ȸ�����Է�</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">    <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgClear','','/images/button/btn_CancelOver.gif',1)"> <img src="/images/button/btn_CancelOn.gif" name="ImgClear"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExcel','','/images/button/btn_ExcelOver.gif',1)"> <img src="/images/button/btn_ExcelOn.gif"  name="imgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
					<col width="120"></col>
					<col width="80"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">���ؿ���</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YY" name="txtPIS_YY" style="ime-mode:disabled" size="5" maxlength="4" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype3','txtPIS_YY','','134','108');"></a>                        
					</td>
					<td class="searchState" align="right">����ȸ�籸��</td>
					<td class="padding2423" align="left">
                        <select id="cmbBNK_CD" name="cmbBNK_CD">
                            <option value="">�����ϼ���</option>
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
                        <td width="80" style="padding-right:5px; padding-top:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnExcelform','','/images/button/btn_ExcelformOver.gif',1)"><img src="/images/button/btn_ExcelformOn.gif" name="btnExcelform" border="0" onclick="cfDownload('retc020.xls', '<%=FILEURL %>/retc020.xls');"></a>
                        </td>
                        <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                        </td>
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
					<comment id="__NSID__">
					<object id="grdT_AC_RETINSURANCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RETINSURANCE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"    width=40		align=center	    name="NO"         value={String(Currow)}</C>
                            <C> id=PIS_YY       width=60        align=center    name=���ؿ���           Edit=None</C>
                            <C> id=BNK_NM       width=90        align=center    name=����ȸ��            Edit=None</C>
                            <C> id=STATUS       width=70        align=center    name=����                 HeadCheckShow=true      EditStyle=CheckBox  CheckBoxText=ENO_NM    Pointer=Hand</C>
                            <C> id=CET_NO       width=110       align=center    name=�ֹι�ȣ            Edit=None</C>
                            <C> id=HIRG_YMD     width=70        align=center    name=�Ի���              Edit=None</C>
                            <C> id=RAM_YMD      width=70        align=center    name=�߰�������          Edit=None</C>
                            <C> id=PAY_AMT      width=90        align=right     name=���ر޿�            Edit=None  rightmargin=10</C>
                            <C> id=EXP_AMT      width=90        align=right     name=�߰��              Edit=None rightmargin=10</C>
                            <C> id=RES_AMT      width=90        align=right     name=����������          Edit=None   rightmargin=10</C>
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
