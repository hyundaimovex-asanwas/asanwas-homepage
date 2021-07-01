<!--
*****************************************************************************
* @source      : code050.jsp                                                    *
* @description : �ٷμҵ漼�� ���μ��� PAGE                                 *
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION                                 *
*----------------------------------------------------------------------------
* 2015/07/07      ������        �����ۼ�                                                     *
*****************************************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���μҵ漼����û</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--**************************************************************************************
    *                                                                                        *
    *   �ڹٽ�ũ��Ʈ �Լ� ����κ�                                                                   *
    *                                                                                        *
    ***************************************************************************************-->

    <script language="javascript">


        var today = gcurdate;

        /********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ                *
         ********************************************/
        function fnc_SearchList() {

            if (document.getElementById("txtENO_NO_SHR").value == "") {
                alert("���/������ ���� �Է��Ͻ� ���� �۾��Ͽ� �ֽñ� �ٶ��ϴ�.");
                document.getElementById("txtENO_NM_SHR").focus();

                return;
            }

            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code050.cmd.CODE050CMD&S_MODE=SHR&ENO_NO="+document.getElementById("txtENO_NO_SHR").value;
            dsT_CM_PERSON.Reset();

            if (document.getElementById("txtENO_NO_SHR").disabled == false) {
                document.getElementById("txtENO_NM_SHR").focus();
            }
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
            
            //�н����庯��, count�ʱ�ȭ
            trT_CM_PERSON.KeyValue = "tr01(I:dsT_CM_PERSON=dsT_CM_PERSON)";
            
            trT_CM_PERSON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code050.cmd.CODE050CMD&S_MODE=SAV&ENO_NO="+document.getElementById("txtENO_NO_SHR").value+"&LUN_CHK="+document.getElementById("gcrdo_LUN_CHK").codevalue;

            trT_CM_PERSON.post();
            
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


        }

        /********************************************
         * 11. ȭ�� ����(�ݱ�)                        *
         ********************************************/
        function fnc_Exit() {
        	
            if ( dsT_CM_PERSON.IsUpdated)  {
                if (!fnc_ExitQuestion())  return;
            }
            
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


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�         *
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;

		    //�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
			if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "6180022" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2080003" && gusrid != "2140002" ){ 

	         	fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	         	fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	         	fnc_ChangeStateElement(false, "ImgEnoNo");

			  }

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
        //���� �׸��
        var oExceptionList = new Array(  );

        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopup() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD");

        }
         /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */

        function fnc_GetNm() {
                fnc_GetEnoNm('txtENO_NO_SHR', 'txtENO_NM_SHR','1','0');

        }

        function fnc_Getcd() {
                fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR','1');
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                  |
    +------------------------------------------------------>
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>

    <!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                       |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)                |
    | 3. ���Ǵ� Table List(T_CM_PERSON)                      |
    +------------------------------------------------------>

    <Object ID="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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


    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
    
        if (iCount == 0)    {

        } else {

        }
    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����            |
    +------------------------------------------------------>

    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>


    <!-----------------------------------------------------+
    | Transaction Successful ó��                                |
    +------------------------------------------------------>


    <script for=trT_CM_PERSON event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>


    <!-----------------------------------------------------+
    | Transaction Failure ó��                                   |
    +------------------------------------------------------>

    <script for=trT_CM_PERSON event="OnFail()">
          cfErrorMsg(this);
    </script>


    <!--**************************************************************************************
    *                                                                                        *
    *   BODY START                                                                           *
    *                                                                                        *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

    <!-- Ķ���� ������-->
    <div class="calendar" id="ifrmcal" style="DISPLAY:none">
        <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
    </div>

    <!-- form ���� -->
    <form name="form1">


    <!-- ��ư ���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    <img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
            </td>
        </tr>
    </table>
    <!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" class="blueTable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <colgroup>
                                    <col width="200"></col>
                                    <col width="80"></col>
                                    <col width="140"></col>
                                    <col width=""></col>
                                </colgroup>
                                <tr>
                                    <td align="right" class="searchState">���&nbsp;</td>
                                    <td class="padding2423">
                                        <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9"  maxlength= "8"   onkeypress="javascript:if(event.keyCode==13) {fnc_GetNm();fnc_SearchList();}" onchange="fnc_GetNm();fnc_SearchList();" style="ime-mode:disabled"   >
                                        <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength= "14"  onkeypress="javascript:if(event.keyCode==13) {fnc_Getcd();fnc_SearchList();}" onchange="fnc_Getcd();fnc_SearchList();"  >
                                        <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopup();fnc_SearchList();" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
                                        <input type="hidden" id="hidEMPL_DPT_CD">
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!-- power Search���̺� �� -->

    <!-- ��ȸ ���� ���̺� ���� -->
    <table width="1000" border="0" cellspacing="0" cellpadding="0">
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

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td>
	            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
	                <colgroup>
	                    <col width="60"></col>
	                    <col width="80"></col>
	                    <col width="60"></col>
	                    <col width="120"></col>
	                    <col width="60"></col>
	                    <col width="70"></col>
	                    <col width="60"></col>
	                    <col width="70"></col>
	                    <col width="60"></col>
	                    <col width=""></col>
	                </colgroup>
	                <tr>
	                    <td align="center" class="blueBold">�ҵ漼 ¡������ </td>
	                    <td class="padding2423">
	                        <object id=gcrdo_LUN_CHK  classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="height:100; width:300">
								<param name=Cols	value=3>
								<param name=Format	value="1^80%,2^100%,3^120%">
							</object>

	                    </td>                     
	                </tr>
	            </table>
	        </td>
	    </tr>
        <tr>
          <td>
          <br><b>&nbsp;&nbsp;�� 2015�� 07������ �ٷμҵ漼�� ���� ������ ����.<br>
                 &nbsp;&nbsp;�� �� �� �����ϸ� �ش� �����⵵���� ���� �Ұ�.<br>
                 &nbsp;&nbsp;�� 80% ����: �ſ� ��õ¡�������� �����Ƿ� �������� �� �߰����� �� ������ �߻��� Ȯ���� ����.<br>
                 &nbsp;&nbsp;��100% ����: ������ ����.<br>
                 &nbsp;&nbsp;��120% ����: �ſ� ��õ¡�������� ������ �������� �� ȯ�޼����� �߻��� Ȯ���� ����.
             </b>
          </td>
        </tr>
	</table>
	<!-- ���� �Է� ���̺� �� -->


    <!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->


<object id="bndT_CM_PERSON" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=LUN_CHK          Ctrl=gcrdo_LUN_CHK        Param=codevalue    </C>
    '>
</object>
