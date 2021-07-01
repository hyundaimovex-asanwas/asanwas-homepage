<!--*************************************************************************
* @source      : taxa050.jsp                                                *
* @description : �ҵ�����׸���Ȳ PAGE                                         *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2007/04/11            ����ȣ             �����ۼ�    
* 2007/04/28            ���м�             �����ۼ�   
***********************************************************************--*-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>


<html>
<head>
    <title>�ҵ�����׸���Ȳ(taxa050)</title>
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
                    + "T"   //����
                    + "T"   //�μ�
                    + "F"   //����
                    + "T";  //�ݱ�
                    
        var dataClassName = "/servlet/GauceChannelSVL?cmd=hr.tax.a.taxa050.cmd.TAXA050CMD";
        var params = null;
    

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;
        
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");   
            var oDED_CD     = document.getElementById("cmbDED_CD");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");
            var oORDER_TYPE = document.getElementById("cmbORDER_TYPE");
            
            
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "&S_MODE=SHR"
                   + "&PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&DED_CD="+oDED_CD.value
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&OCC_CD="+oOCC_CD.value
                   + "&DTP_CD="+oDTP_CD.value
                   + "&ORDER_TYPE="+oORDER_TYPE.value;     
            
            dsT_AC_RETACC.dataid = dataClassName+params;
            dsT_AC_RETACC.reset();
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
            //�˻���ȿ�� �˻�                   
            if(!fnc_CheckElement(oElementList, oElementMsgList, oExceptionList)) return;
        
            var oPIS_YM     = document.getElementById("txtPIS_YM_SHR");   
            var oDED_CD     = document.getElementById("cmbDED_CD");
            var oSAL_GBN    = document.getElementById("cmbSAL_GBN_SHR");
            var oOCC_CD     = document.getElementById("cmbOCC_CD_SHR");
            var oDTP_CD     = document.getElementById("txtDPT_CD_SHR");
            var oDPT_NM     = document.getElementById("txtDPT_NM_SHR");
            var oORDER_TYPE = document.getElementById("cmbORDER_TYPE");
            
            var oDED_NM     = document.form1.cmbDED_CD.options[document.form1.cmbDED_CD.selectedIndex].text;
            //��¥ ��������
            var dayArray = oPIS_YM.value.split("-");
            dayArray[2] = fnc_Lastday(dayArray[0], dayArray[1]);
            
            params = "PIS_YM="+dayArray[0] + dayArray[1]
                   + "&PIS_YY="+dayArray[0]
                   + "&PIS_MM="+dayArray[1]
                   + "&DED_CD="+oDED_CD.value
                   + "&SAL_GBN="+oSAL_GBN.value
                   + "&OCC_CD="+oOCC_CD.value
                   + "&DTP_CD="+oDTP_CD.value
                   + "&ORDER_TYPE="+oORDER_TYPE.value   
                   + "&DED_NM="+oDED_NM
                   + "&DPT_NM="+oDPT_NM.value;    

			var url = "taxa050_PV.jsp?"+params;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
        }

        /********************************************
         * 06. ���� ���� �Լ�                             *
         ********************************************/
        function fnc_ToExcel() {
            if (dsT_AC_RETACC.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }
            form1.grdT_AC_RETACC.GridToExcel("�ҵ�����׸���Ȳ", '', 225);
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
            
            dsT_AC_RETACC.ClearData();
            
            fnc_ClearInputFieldAll(new Array("cmbORDER_TYPE"));
            
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;      
            document.getElementById("cmbDED_CD").selectedIndex = 1; 
        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
            if (dsT_AC_RETACC.IsUpdated)  {
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
            cfStyleGrid(form1.grdT_AC_RETACC,0,"false","false");      // Grid Style ����
            fnc_BindingCommonCode(dsT_CM_COMMON_U5, "cmbDED_CD");
            
            document.getElementById("txtPIS_YM_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1];
            document.getElementById("cmbSAL_GBN_SHR").selectedIndex = 1;      
            document.getElementById("cmbDED_CD").selectedIndex = 1;      
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
        var oElementList = new Array(    "txtPIS_YM_SHR"
                                        ,"cmbSAL_GBN_SHR"
                                        ,"cmbDED_CD"
                                        ,"cmbOCC_CD_SHR"
                                        ,"txtDPT_CD_SHR"
                                        ,"cmbORDER_TYPE");                                               

        //�׸���� �޼���                                        
        var oElementMsgList = new Array( "������"
                                        ,"���걸��"
                                        ,"�����׸�"
                                        ,"�ٷα���"
                                        ,"�Ҽ�"
                                        ,"��±���");     
                                        
        //���� �׸��
        var oExceptionList = new Array(  "cmbOCC_CD_SHR"
                                        ,"txtDPT_CD_SHR");    
    
        function fnc_DEDchange(ded_nm) {
   //         alert(document.form1.cmbDED_CD.options[document.form1.cmbDED_CD.selectedIndex].text);

            
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                  |
    +------------------------------------------------------>
    <Object ID="dsT_AC_RETACC" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
        <Param Name="UseChangeInfo"     Value="True">
        <Param Name="ViewDeletedRow"    Value="False">
        <param name=SubsumExpr          value="total">
    </Object>     
     
    <!-----------------------------------------------------+
    | 1. ���� �޺��� ���� DataSet                               |
    +------------------------------------------------------>    
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_U5"/>
       <jsp:param name="CODE_GUBUN"    value="U5"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>     
    
    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AC_RETACC)                |
    | 3. ���Ǵ� Table List(T_AC_RETACC)                      |
    +------------------------------------------------------>
    <Object ID="trT_AC_RETACC" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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
    <Script For=dsT_AC_RETACC Event="OnLoadCompleted(iCount)">
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
    <Script For=dsT_AC_RETACC Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��     |
    +------------------------------------------------------>
    <Script For=dsT_AC_RETACC Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>  

    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnSuccess()">

    </script> 

    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>
    <script for=trT_AC_RETACC event="OnFail()">
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
                    <td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">�ҵ�����׸���Ȳ</td>
                    <td align="right" class="navigator">HOME/���꼼��/���꼼��/<font color="#000000">�ҵ�����׸���Ȳ</font></td>
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
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','/images/button/btn_PrintOver.gif',1)"> <img src="/images/button/btn_PrintOn.gif"  name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>
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
                    <col width="90"></col>
                    <col width="150"></col>
                    <col width="60"></col>
                    <col width="180"></col>                                            
                    <col width="90"></col>
                    <col width="*"></col>
				</colgroup>
				<tr>
					<td class="searchState" align="right">������</td>
					<td class="padding2423" align="left">
                        <input type="text" id="txtPIS_YM_SHR" name="txtPIS_YM_SHR" style="ime-mode:disabled" size="8" maxlength="7" onblur="fnc_CheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAPY_YMD','','/images/button/btn_HelpOver.gif',1)" ><img src="/images/button/btn_HelpOn.gif" id="imgAPY_YMD" name="imgAPY_YMD" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM_SHR','','134','108');"></a>                        
					</td>      

                    <td class="searchState" align="right">���걸��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbSAL_GBN_SHR" id="cmbSAL_GBN_SHR">
                            <option value=""></option>
                            <option value="8">��������</option>
                            <option value="9">����������</option>
                        </select>
                    </td>                
                    <td align="right" class="searchState">�����׸�</td>
                    <td class="padding2423">
                        <select name="cmbDED_CD" id="cmbDED_CD" onChange="fnc_DEDchange(this.text)">
                            <option value=""></option>
                        </select>
                    </td>                                                          
				</tr>
                <tr>
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <select name="cmbOCC_CD_SHR" id="cmbOCC_CD_SHR">
                            <option value=""></option>
                            <option value="A">�繫��</option>
                            <option value="M">�ù���</option>
                        </select>
                    </td>                 
                    <td class="searchState" align="right">��&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423" align="left">
                        <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();">
                        <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image10','','/images/button/btn_HelpOver.gif',1)">
                            <img src="/images/button/btn_HelpOn.gif" name="Image10" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
                        </a>
                    </td>                
                    <td align="right" class="searchState">��±���</td>
                    <td class="padding2423">
                        <select name="cmbORDER_TYPE">
                            <option value="DPT">�μ���</option>
                            <option value="ENO">�����</option>
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
                    <comment id="__NSID__">
                    <object id="grdT_AC_RETACC" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:350px;">
                        <param name="DataID" value="dsT_AC_RETACC">
                        <param name="Editable" value="true">
                        <param name="DragDropEnable" value="true">
                        <param name="SortView" value="Left">
                        <param name="Format" value='
                            <C> id="{CUROW}"        width=60    align=center    name="NO"         value={String(Currow)}    SubSumText=""</C>
                            <C> id=DPT_NM       width=100       align=center        name="��  ��"         </C>
                            <C> id=ENO_NO       width=100       align=center        name="��  ��"         </C>
                            <C> id=ENO_NM       width=100       align=center        name="��  ��"         </C>
                            <C> id=JOB_NM       width=100       align=center        name="��  ��"         SubSumText="��  ��"</C>
                            <C> id=TDED_AMT     width=100       align=right     rightmargin=10        name="�������ݾ�"   </C>
                            <C> id=DED_AMT      width=100       align=right     rightmargin=10        name="�����ݾ�"       </C>
                            <C> id=REMARK       width=120       align=center        name="��  ��"           </C>
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
