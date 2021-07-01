<!--*************************************************************************
* @source      : reta071.jsp                                                *
* @description : �߰�����������Ȳ��� PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/09            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�߰�����������Ȳ���(reta071)</title>
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
        var vENO_NO = '<%=request.getParameter("ENO_NO") %>';
        var vPIS_YY = '<%=request.getParameter("PIS_YY") %>';
        var vSEQ_NO = '<%=request.getParameter("SEQ_NO") %>';
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
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta071.cmd.RETA071CMD";
        var params = null;
        
        //STR - ����
        //INS - �Է�
        //UPT - ����
        var type = null;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            params = "&S_MODE=SHR"
                   + "&ENO_NO="+vENO_NO
                   + "&PIS_YY="+vPIS_YY
                   + "&SEQ_NO="+vSEQ_NO;     
                   
            dsT_AC_RETINSURANCE.ClearData();            
            
            dsT_AC_RETINSURANCE.dataid = dataClassName+params;
            dsT_AC_RETINSURANCE.reset();                         
        } 
        
        /**
         * ����ȸ�� ��� ����Ʈ�� �����´�.
         */  
        function fnc_Search_bnk() {
            params = "&S_MODE=SHR_BNK"
                   + "&ENO_NO="+vENO_NO
                   + "&PIS_YY="+vPIS_YY;     
                   
            dsBNK_INFO.ClearData();            
            
            dsBNK_INFO.dataid = dataClassName+params;
            dsBNK_INFO.reset();                         
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
            trT_AC_RETINSURANCE.KeyValue = "TR(I:dsT_AC_RETINSURANCE=dsT_AC_RETINSURANCE)";                           

            trT_AC_RETINSURANCE.action = dataClassName+params;
            trT_AC_RETINSURANCE.post();   
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
            if (dsT_AC_RETINSURANCE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETINSURANCE.GridToExcel("�߰�����������Ȳ���", '', 225);
        }

        /********************************************
         * 07. �ű� �Լ�                                *
         ********************************************/
        function fnc_AddNew() {
            dsT_AC_RETINSURANCE.AddRow();
            
            dsT_AC_RETINSURANCE.NameValue(dsT_AC_RETINSURANCE.RowPosition, "ENO_NO") = vENO_NO;
            dsT_AC_RETINSURANCE.NameValue(dsT_AC_RETINSURANCE.RowPosition, "PIS_YY") = vPIS_YY;
            dsT_AC_RETINSURANCE.NameValue(dsT_AC_RETINSURANCE.RowPosition, "SEQ_NO") = vSEQ_NO;
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
            var bnk_cd;
            var bnk_nm;
            var res_amt     = 0;
            var paid_amt    = 0;
            
            //�ݾ� ����
            for(var i=1; i<=dsBNK_INFO.CountRow; i++) {
                bnk_cd      = dsBNK_INFO.NameValue(i, "CODE");
                bnk_nm      = dsBNK_INFO.NameValue(i, "CODE_NAME");
                res_amt     = parseInt(dsBNK_INFO.NameValue(i, "RES_AMT"));
                
                for(var j=1; j<=dsT_AC_RETINSURANCE.CountRow; j++) {
                    if(dsT_AC_RETINSURANCE.NameValue(j, "BNK_CD") == bnk_cd)
                        paid_amt += parseInt(dsT_AC_RETINSURANCE.NameValue(j, "PAID_AMT"));
                }
                
                if(res_amt < paid_amt) {
                    alert("["+bnk_nm+"] �� ����ݾ�("+formatNumber(paid_amt)+")�� �����ݾ�("+formatNumber(res_amt)+")���� Ů�ϴ�.\n�ݾ��� Ȯ���� �ּ���");
                    return false;
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
            cfStyleGrid(form1.grdT_AC_RETINSURANCE,0,"false","false");      // Grid Style ����
            
            var obj = new String;
            document.getElementById("txtENO_NO").value = vENO_NO;
            // ������ ��ü
            obj = fnc_GetEnoNm("txtENO_NO");
            if(document.getElementById("txtENO_NO").value != "") {
                document.getElementById("txtENO_NM").value      = obj.eno_nm;
                document.getElementById("txtDPT_NM").value      = obj.dpt_nm;
                document.getElementById("txtJOB_NM").value      = obj.job_nm;
            }
            
            //ó�� �ε��Ҷ� ����Ʈ ��������
            fnc_Search_bnk();   //���� �ڵ� ��ȸ
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
        var elementList = new Array ( "cmbBNK_CD"
                                    , "txtPAID_AMT"
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETINSURANCE)                |
    | 3. ���Ǵ� Table List(T_AC_RETINSURANCE)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETINSURANCE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETINSURANCE)                |
    | 3. ���Ǵ� Table List(T_AC_RETINSURANCE)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETINSURANCE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
        if (dsT_AC_RETINSURANCE.CountRow == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETINSURANCE.CountRow);
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
    <Script For=dsT_AC_RETINSURANCE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_AC_RETINSURANCE Event="OnDataError()">

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
    <script for=trT_AC_RETINSURANCE event="OnSuccess()">      
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        fnc_SearchList();
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETINSURANCE event="OnFail()">
        alert("���� ����翡 ���� �������ڸ� ����Ͻ� �� �����ϴ�.");
    </script>
    
    <!--------------------------+
    | ����Ÿ �׸��带 ���������� ó��  |
    +--------------------------->
    <script for=dsT_AC_RETINSURANCE event=OnRowPosChanged(row)>
        fnc_DisableElementAll(elementList);
        if(row > 0) {
            fnc_EnableElementAll(elementList);
        
            if(dsT_AC_RETINSURANCE.RowStatus(row) != "1") {
                fnc_ChangeStateElement(false, "cmbBNK_CD");
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�߰�����������Ȳ���</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����������/<font color="#000000">�߰�����������Ȳ���</font></td>
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
                        <col width="90"></col>
                        <col width="110"></col>
                        <col width="90"></col>
                        <col width="*"></col>                                            
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">�����ȣ</td>
                        <td class="padding2423">
                            <input id="txtENO_NO" name="txtENO_NO" size="14" class="input_ReadOnly" readonly>
                        </td>
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <input id="txtENO_NM" name="txtENO_NM" size="14" class="input_ReadOnly" readonly>
                        </td>                                            
                    </tr>
                    <tr>
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <input id="txtDPT_NM" name="txtDPT_NM" size="14" class="input_ReadOnly" readonly>
                        </td>                    
                        <td class="creamBold" align="center">��&nbsp;&nbsp;&nbsp;��</td>
                        <td class="padding2423">
                            <input id="txtJOB_NM" name="txtJOB_NM" size="14" class="input_ReadOnly" readonly>
                        </td>
                    </tr>                                                                               
                </table>                             
                    
            </td>
        </tr>
    </table>
    <table width="500" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
            
                <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                    <colgroup>
                        <col width="50"></col>
                        <col width="140"></col>
                        <col width="40"></col>
                        <col width="90"></col>                                            
                        <col width="40"></col>
                        <col width="*"></col>
                    </colgroup>
                    <tr>
                        <td class="creamBold" align="center">�����</td>
                        <td class="padding2423">
                            <select name="cmbBNK_CD" id="cmbBNK_CD">
                                <option value="">�����ϼ���</option>
                            </select>
                        </td>
                        <td class="creamBold" align="center">����<br>�ݾ�</td>
                        <td class="padding2423">
                            <comment id="__NSID__"><object id="txtPAID_AMT" classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F style="width:80px">
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
                        <td class="creamBold" align="center">����<br>����</td>
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
					<object id="grdT_AC_RETINSURANCE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:500px;height:260px;">
						<param name="DataID" value="dsT_AC_RETINSURANCE">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value="
                            <C> id='{currow}'       width=30    name='NO'           align=center       SubBgColor='#99FFCC'</C>
                            <C> id=BNK_CD       width=120       align=center        name=������                                         EditStyle=Lookup    Data='dsBNK_INFO:CODE:CODE_NAME'   HeadBgColor='#F7DCBB'   Suppress='2'</C>
                            <C> id=BNK_CD       width=110       align=right         name=�����ݾ�       rightmargin='10' EditStyle=Lookup    Data='dsBNK_INFO:CODE:RES_AMT'     HeadBgColor='#F7DCBB'   Suppress='1'</C>
                            <C> id=PAID_AMT     width=110       align=right         name=����ݾ�       rightmargin='10'</C>
                            <C> id=BASIC_YMD    width=110       align=center        name=��������       </C>
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

<object id="bndT_AC_RETINSURANCE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_AC_RETINSURANCE">
    <Param Name="BindInfo", Value='
        <C>Col=BNK_CD               Ctrl=cmbBNK_CD              Param=value     </C>
        <C>Col=PAID_AMT             Ctrl=txtPAID_AMT            Param=text      </C>
        <C>Col=BASIC_YMD            Ctrl=txtBASIC_YMD           Param=value     </C>
    '>
</object>
