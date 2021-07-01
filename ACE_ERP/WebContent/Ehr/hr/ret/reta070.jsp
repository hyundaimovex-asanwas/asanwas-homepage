<!--*************************************************************************
* @source      : reta070.jsp                                                *
* @description : �������߰�����������Ȳ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/09            ����ȣ             �����ۼ�                                        *
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�������߰�����������Ȳ(reta070)</title>
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
                    + "F"   //����
                    + "T";  //�ݱ�
                    
        var today = getToday(); 
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.ret.a.reta070.cmd.RETA070CMD";
        var params = null;
        
        //STR - ����
        //INS - �Է�
        //UPT - ����
        var type = null;
        
        var gridFormat = "<C> id={CUROW}     width=40    align=center    name=NO         value={String(Currow)}</C>"
                       + "<C> id=DPT_NM      width=70    align=center    name=�μ�   Edit=None    </C>"
                       + "<C> id=JOB_NM      width=70    align=center    name=����   Edit=None     </C>"
                       + "<C> id=ENO_NO      width=70    align=center    name=���   Edit=None     </C>"
                       + "<C> id=ENO_NM      width=70    align=center    name=����    Edit=None    </C>"
                       + "<C> id=SEQ_NO      width=70    align=center    name=ȸ��                Value={Decode(SEQ_NO,'0','����','1','1��','2','2��','3','3��')}</C>"
                       + "<C> id=RAM_YMD     width=70    align=center    name=�߰�������    Edit=None    </C>"
                       + "<C> id=RTR_AMT     width=70    align=center    name=�������հ�    Edit=None    </C>"
                       + "<C> id=COMP        width=100   align=center    name=ȸ��δ��    Edit=None    </C>"
                       + "<C> id=COMP_PER    width=50    align=center    name=%    Edit=None    </C>";

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_SearchItemCheck()) return;
        
            var oFROM_YMD = document.getElementById("txtFROM_YMD");   
            var oTO_YMD = document.getElementById("txtTO_YMD");   
            var oENO_NO_SHR = document.getElementById("txtENO_NO_SHR");   
            
            
            params = "&S_MODE=SHR"
                   + "&FROM_YMD="+oFROM_YMD.value
                   + "&TO_YMD="+oTO_YMD.value
                   + "&ENO_NO_SHR="+oENO_NO_SHR.value;     
                   
            dsT_AC_RETMASTER.ClearData();
            dsBNK_INFO.ClearData();                   
            
            document.getElementById("grdT_AC_RETMASTER").Format = gridFormat;             
            cfStyleGrid(form1.grdT_AC_RETMASTER,0,"false","false");      // Grid Style ����
            
            //ds�� ��ȸ
            trT_AC_RETMASTER.KeyValue = "TR"
                                         + "(O:dsT_AC_RETMASTER=dsT_AC_RETMASTER"
                                         + ",O:dsBNK_INFO=dsBNK_INFO)";                           

            trT_AC_RETMASTER.action = dataClassName+params;
            trT_AC_RETMASTER.post();                         
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
            if (dsT_AC_RETMASTER.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETMASTER.GridToExcel("�������߰�����������Ȳ", '', 225);
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
            
            dsT_AC_RETMASTER.ClearData();
            dsBNK_INFO.ClearData();
            
            fnc_ClearInputElement(oElementList);  
            
            document.getElementById("grdT_AC_RETMASTER").Format = gridFormat;
            cfStyleGrid(form1.grdT_AC_RETMASTER,0,"false","false");      // Grid Style ����
            
            //��¥ �ʱ�ȭ
            document.getElementById("txtFROM_YMD").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtTO_YMD").value = getToday();            
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETMASTER.IsUpdated)  {
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
            document.getElementById("grdT_AC_RETMASTER").Format = gridFormat;
        
            //ù��° �μ� : �׸����                                        
            //�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    
            //�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)                
            cfStyleGrid2(form1.grdT_AC_RETMASTER,0,"false","false");      // Grid Style ����
            
            type = "STR";
            
            //��¥ �ʱ�ȭ
            document.getElementById("txtFROM_YMD").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";
            document.getElementById("txtTO_YMD").value = getToday();
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
        var oElementList = new Array(    "txtFROM_YMD"
                                        ,"txtTO_YMD"
                                        ,"txtENO_NO_SHR");        

        //�׸���� �޼���                                        
        var oElementMsgList = new Array( "������"
                                        ,"������"
                                        ,"���");     
                                        
        //���� �׸��
        var oExceptionList = new Array(  "txtENO_NO_SHR");                
                          
    </script>
</head>

    <!--**************************************************************************************
    *                                                                                        *
    *   Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)           *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 1. ��ȸ�� DataSet                                       |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETMASTER)                |
    | 3. ���Ǵ� Table List(T_AC_RETMASTER)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETMASTER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>   
    
    <Object ID="dsBNK_INFO" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
    </Object>      
    
    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETMASTER)                |
    | 3. ���Ǵ� Table List(T_AC_RETMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETMASTER" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName Value="toinb_dataid4">
    </Object>   
    
    <!-----------------------------------------------------+
    | 1. �ڷ� ����� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETMASTER)                |
    | 3. ���Ǵ� Table List(T_AC_RETMASTER)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETMASTER_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETMASTER Event="OnLoadCompleted(iCount)">

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETMASTER Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETMASTER Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>  

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETMASTER event="OnSuccess()">        
        if (dsT_AC_RETMASTER.CountRow == 0)    {
            fnc_Message(document.getElementById("resultMessage"),"MSG_02");
        } else {
            // ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
            fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AC_RETMASTER.CountRow);
        }    
    
        //�˻��� ���������� �̷�� ������ �ش� ����� ��ŭ �ʵ� ũ�⸦ �ø�
        var oGRID = document.getElementById("grdT_AC_RETMASTER");
        
        for(var i=1; i<=dsBNK_INFO.CountRow; i++) {
            oGRID.Format += "<C> id="+dsBNK_INFO.NameValue(i, "BNK_CD")+"      width=100    align=center    name='"+dsBNK_INFO.NameValue(i, "BNK_NM")+"'  </C>";
            oGRID.Format += "<C> id="+dsBNK_INFO.NameValue(i, "BNK_CD")+"_PER  width=50     align=center    name=%      Edit=None                       </C>";
        }
        
        // Grid Style ����
        cfStyleGrid(form1.grdT_AC_RETMASTER,0,"false","false");      
    </script>

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETMASTER event="OnFail()">
        cfErrorMsg(this);
    </script>
    
    
    <!-- ����Ÿ �׸��带 ���� Ŭ���Ҷ� -->
    <script for=grdT_AC_RETMASTER event=OnDblClick(Row,Colid)>
        if(Row < 1) {
            return;
        } else {
            var href_page = "/hr/ret/reta071.jsp"
                          + "?ENO_NO="+dsT_AC_RETMASTER.NameValue(Row, "ENO_NO")
                          + "&PIS_YY="+dsT_AC_RETMASTER.NameValue(Row, "PIS_YY")
                          + "&SEQ_NO="+dsT_AC_RETMASTER.NameValue(Row, "SEQ_NO")
                          + "&ROW="+Row;                  

            window.showModalDialog(href_page, "", "dialogWidth:540px; dialogHeight:470px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
            fnc_SearchList();
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�������߰�����������Ȳ</td>
                    <td align="right" class="navigator">HOME/���꼼��/�����������/<font color="#000000">�������߰�����������Ȳ</font></td>
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
					<col width="220"></col>
					<col width="70"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">���ؿ���</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtFROM_YMD" name="txtFROM_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtFROM_YMD','','100','108');"></a>
                        ~
                        <input type="text" id="txtTO_YMD" name="txtTO_YMD" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD_SHR','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD_SHR" name="imgAPY_YMD_SHR" width="21" height="20" border="0" align="absmiddle" onclick="javascript:calendarBtn('datetype1','txtTO_YMD','','210','108');"></a>                        
					</td>
                    <td align="right" class="searchState">�����ȣ</td>
                    <td class="padding2423">
                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) cfNumberCheck(); fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" style="ime-mode:disabled">
                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength="9" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"><img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
					<comment id="__NSID__">
					<object id="grdT_AC_RETMASTER" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
						<param name="DataID" value="dsT_AC_RETMASTER">
						<param name="Editable" value="true">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='

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
