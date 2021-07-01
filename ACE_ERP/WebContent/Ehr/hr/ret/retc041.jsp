<!--*************************************************************************
* @source      : reta071.jsp                                                *
* @description : �б⺰���ڹ߻�������� PAGE                                    *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/09            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�߰�����������Ȳ���(retc041)</title>
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
        //�Ѱܿ� �ĸ����Ͱ��� ����
        var vPIS_YY = '<%=request.getParameter("PIS_YY") %>';
        var vBNK_CD = '<%=request.getParameter("BNK_CD") %>';
        var vBNK_NM = '<%=request.getParameter("BNK_NM") %>';
        var vROW    = '<%=request.getParameter("ROW") %>';
    
        //����Ű ����
        var btnList = "T"   //��ȸ
                    + "F"   //�ű�
                    + "T"   //����
                    + "T"   //���
                    + "T"   //����
                    + "F"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
                    
        var today = getToday(); 
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.c.retc041.cmd.RETC041CMD";
        var params = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            params = "&S_MODE=SHR"
                   + "&PIS_YY="+vPIS_YY
                   + "&BNK_CD="+vBNK_CD;     
                   
            dsT_AC_RETINTEREST.ClearData();            
            
            dsT_AC_RETINTEREST.dataid = dataClassName+params;
            dsT_AC_RETINTEREST.reset();                         
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
            if(!fnc_SaveItemCheck()) return;
        
            params = "&S_MODE=SAV";               
        
            //ds�� ����
            trT_AC_RETINTEREST.KeyValue = "TR(I:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";                           
            trT_AC_RETINTEREST.action = dataClassName+params;
            trT_AC_RETINTEREST.post();   
        }

        /********************************************
         * 04. ���� �Լ�                                *
         ********************************************/
        function fnc_Delete() {
            if(!confirm(
                    "������:"
                    +dsT_AC_RETINTEREST.NameString(dsT_AC_RETINTEREST.RowPosition, "BNK_NM")
                    +"��������:"
                    +dsT_AC_RETINTEREST.NameString(dsT_AC_RETINTEREST.RowPosition, "BASIC_YMD")
                    +" �� �ڷḦ �����Ͻðڽ��ϱ�?")) {
                return;                
            }
        
            params = "&S_MODE=DEL";    
            
            dsT_AC_RETINTEREST.DeleteRow(dsT_AC_RETINTEREST.RowPosition);           
        
            //ds�� ����
            trT_AC_RETINTEREST.KeyValue = "TR(I:dsT_AC_RETINTEREST=dsT_AC_RETINTEREST)";                           
            trT_AC_RETINTEREST.action = dataClassName+params;
            trT_AC_RETINTEREST.post();          
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
            if (dsT_AC_RETINTEREST.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETINTEREST.GridToExcel("�߰�����������Ȳ���", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {
            dsT_AC_RETINTEREST.AddRow();
            
            dsT_AC_RETINTEREST.NameValue(dsT_AC_RETINTEREST.RowPosition, "PIS_YY") = vPIS_YY;
            dsT_AC_RETINTEREST.NameValue(dsT_AC_RETINTEREST.RowPosition, "BNK_CD") = vBNK_CD;
            dsT_AC_RETINTEREST.NameValue(dsT_AC_RETINTEREST.RowPosition, "BNK_NM") = vBNK_NM;
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
            
            dsT_AC_RETINTEREST.ClearData();
            
            fnc_ClearInputElement(oElementList);  
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
            return fnc_CheckElement(oElementList, oElementMsgList, oExceptionList);
        }

        /********************************************
         * 13. ���� ��ȿ�� üũ                        *
         ********************************************/
        function fnc_SaveItemCheck() {
            
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
            cfStyleGrid(form1.grdT_AC_RETINTEREST,0,"false","false");      // Grid Style ����
            
            document.getElementById("txtBNK_NM").value = vBNK_NM;
            
            //ó�� �ε��Ҷ� ����Ʈ ��������
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
        var elementList = new Array ( "txtINTEREST"
                                    , "txtBASIC_YMD"
                                    , "imgAPY_YMD_SHR"
                                     );
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETINTEREST)                |
    | 3. ���Ǵ� Table List(T_AC_RETINTEREST)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINTEREST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>   
    
    <Object ID="dsBNK_INFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      

    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>    
    
    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETINTEREST)                |
    | 3. ���Ǵ� Table List(T_AC_RETINTEREST)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINTEREST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETINTEREST Event="OnLoadCompleted(iCount)">
        if (dsT_AC_RETINTEREST.CountRow == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINTEREST.CountRow);
        }  
    </Script>
    
    <Script For=dsBNK_INFO Event="OnLoadCompleted(iCount)">
        if (dsBNK_INFO.CountRow > 0)    {
            fnc_BindingCommonCode(dsBNK_INFO, "cmbBNK_CD");
        }  
    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_AC_RETINTEREST Event="OnDataError()">

        //Dataset���� Error ó��
        if (this.ErrorCode == 50018) {
            alert("�ش� �ʼ��Է��׸�[�����/��������] �Է� �� ���� �۾��� �����մϴ�.");
        }
        else if (this.ErrorCode == 50019) {
            
        }
        else {
            cfErrorMsg(this);
        }

    </Script>
    

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETINTEREST event="OnSuccess()">      
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINTEREST event="OnFail()">
        alert("���� ����翡 ���� �������ڸ� ����Ͻ� �� �����ϴ�.");
    </script>
    
    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |
    +--------------------------->
    <script for=dsT_AC_RETINTEREST event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(row > 0) {
            fnc_EnableElementAll(elementList);
        
            if(dsT_AC_RETINTEREST.RowStatus(row) != "1") {
                fnc_ChangeStateElement(false, "txtBASIC_YMD");
                fnc_ChangeStateElement(false, "imgAPY_YMD_SHR");
            }
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
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="25" background="/images/common/barBg.gif">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�б⺰ ���ڹ߻�����</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����������/<font color="#000000">�б⺰ ���ڹ߻�����</font></td>
                </tr>
            </table>
            </td>
        </tr>
    </table>
    <!-- Ÿ��Ʋ �� ���̺� �� -->

    <!-- ��ư ���̺� ���� -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddnew','','/images/button/btn_AddnewOver.gif',1)"><img src="/images/button/btn_AddnewOn.gif" name="imgAddnew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','/images/button/btn_SaveOver.gif',1)">  <img src="/images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>                
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->
    
    <!-- ���� �Է� ���̺� ���� -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="50"></col>
                        <col width="100"></col>
                        <col width="60"></col>
                        <col width="100"></col>                                            
                        <col width="60"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">�����</td>
                        <td class="padding2423">
                            <input id="txtBNK_NM" name="txtBNK_NM" size="14" class="input_ReadOnly" readonly>
                        </td>
                        <td class="creamBold" align="center">�߻�����</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtINTEREST" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
                                <param name=Alignment               value=2>
                                <param name=Border                  value=true>
                                <param name=ClipMode                value=true>
                                <param name=DisabledBackColor       value="#EEEEEE">
                                <param name=Enable                  value=true>
                                <param name=IsComma                 value=true>
                                <param name=Language                value=0>
                                <param name=MaxLength               value=8>
                                <param name=Numeric                 value=true>
                                <param name=NumericRange            value=0~+:0>
                                <param name=ShowLiteral             value=false>
                                <param name=Visible                 value=true>
                            </object></comment><script> __ShowEmbedObject(__NSID__); </script>                             
                        </td>                                            
                        <td class="creamBold" align="center">��������</td>
                        <td class="padding2423">
                            <input type="text" id="txtBASIC_YMD" name="txtFROM_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtBASIC_YMD','','100','108');"></a>                        
                        </td>                                            
                    </tr>                                                                            
                </table>                             
                    
            </td>
        </tr>
    </table>
    <!-- ���� �Է� ���̺� �� -->    

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="500" border="0" cellspacing="0" cellpadding="0">
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
	<table width="500" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AC_RETINTEREST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:260px;">
						<param name="DataID" value="dsT_AC_RETINTEREST">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value="
                            <C> id='{currow}'       width=50    name='NO'           align=center       SubBgColor='#99FFCC'</C>
                            <C> id=BNK_NM       width=150       align=center        name=������       Suppress='2'</C>
                            <C> id=INTEREST     width=140       align=right         name=�߻�����       rightmargin='10'</C>
                            <C> id=BASIC_YMD    width=140       align=center        name=��������       </C>
						">
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

<object id="bndT_AC_RETINTEREST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETINTEREST">
    <Param Name="BindInfo", Value='
        <C>Col=BNK_CD               Ctrl=cmbBNK_CD              Param=value     </C>
        <C>Col=INTEREST             Ctrl=txtINTEREST            Param=text      </C>
        <C>Col=BASIC_YMD            Ctrl=txtBASIC_YMD           Param=value     </C>
    '>
</object>
