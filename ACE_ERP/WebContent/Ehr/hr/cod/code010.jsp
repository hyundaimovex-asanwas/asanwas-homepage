<!--
    ************************************************************************************
    * @Source         : code010.jsp                                                     *
    * @Description    : ����������ȸ PAGE                                              *
    * @Developer Desc :                                                                    *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                         *
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�									     *
    ************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<%

	//String ROLE_CD      = box.getString("SESSION_ROLE_CD");

    //ROLE_CD�� IT���� ����
    boolean itMaster = false;

    //if(ROLE_CD.equals("1001")) {
    //	itMaster = true;
    //}



%>


<html>
    <head>
    <title>����������ȸ</title>
	<jsp:include page="/Ehr/common/include/head.jsp"/>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<%
    //Configuration conf = Configuration.getInstance();

    //String FILEURL = conf.get("framework.file.upload.pds");
    //String p_eno_no = request.getParameter("") != null ? request.getParameter("") : ls_UserId;
    //String p_mode = request.getParameter("mode") != null ? request.getParameter("mode") : "";
    
%>

    <!--
    ******************************************************
    * �ڹٽ�ũ��Ʈ �Լ� ����κ�
    ******************************************************
    -->
    <script language="javascript" >


        var imgBox  = null;        // ���ε�� ���� �����ֱ�

        var dsTemp = window.dialogArguments;
        var p_eno_no = gusrid;
        var p_mode = "";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            dsT_CM_ACCESS.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.e.code010.cmd.CODE010CMD&S_MODE=SHR_ACC";
            dsT_CM_ACCESS.Reset();        	
        	
            dsT_CM_PERSON.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.c.pirc010.cmd.PIRC010CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_PERSON.Reset();

            //�з»��� ��ȸ
            dsT_CM_SCHOOL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira016.cmd.PIRA016CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_SCHOOL.Reset();

            //�������� ��ȸ
            dsT_CM_FAMILY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira018.cmd.PIRA018CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_FAMILY.Reset();

            //�Ի��� ��� ��ȸ
            dsT_CM_BHISTORY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira024.cmd.PIRA024CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_BHISTORY.Reset();            
            
            //�Ի��� ��� ��ȸ
            dsT_CM_AHISTORY.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira025.cmd.PIRA025CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_AHISTORY.Reset();

            //�ڰ� ���� ��ȸ
            dsT_CM_QUALIFICATION.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira020.cmd.PIRA020CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_QUALIFICATION.Reset();

            //��ȸ���� ��ȸ
            dsT_CM_SERVICE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira034.cmd.PIRA034CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_SERVICE.Reset();

            //������� ��ȸ
            dsT_CM_REWARD.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira026.cmd.PIRA026CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            dsT_CM_REWARD.Reset();

           //������� ��ȸ
            //dsT_CM_GRADE.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.a.pira035.cmd.PIRA035CMD&S_MODE=SHR&ENO_NO="+p_eno_no;
            //dsT_CM_GRADE.Reset();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

            dsT_CM_PERSON.ClearData();

            // ������ �ʱ�ȭ�� ȣ��
            fnc_ViewFrameTab(1);

        }

        /********************************************
         * 11. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {
        	
            if(p_mode == "read") {
            	
                window.close();
                
            } else {
            	
            	window.close();
            	
            }
            
        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //param ���� ����(�˾����� �Ѿ���� ���)
            if(dsTemp != null) {
                p_eno_no    = dsTemp.eno_no;
                p_mode      = dsTemp.mode;

                //�˾��� ������û ��ư�� �ʺ��δ�.
	            document.getElementById("imgRequest").style.display = "none";
            }

            document.getElementById("imgSearch").style.display = "none";

            //imgBox = new Image(document.form1.viewImage);

            // ���� �ʱ�ȭ�� ȣ��
            fnc_ViewFrameTab(1);

            fnc_SearchList();

            photo.src = "../../../Ehr/photo/" + p_eno_no + ".jpg";    
            
            cfStyleGrid_New(grdT_CM_AHISTORY, 0,"false","false");
            cfStyleGrid_New(grdT_CM_BHISTORY, 0,"false","false");            
            cfStyleGrid_New(grdT_CM_FAMILY, 0,"false","false");
            cfStyleGrid_New(grdT_CM_QUALIFICATION, 0,"false","false");
            cfStyleGrid_New(grdT_CM_SCHOOL, 0,"false","false");
            cfStyleGrid_New(grdT_CM_SERVICE, 0,"false","false");
            cfStyleGrid_New(grdT_CM_REWARD, 0,"false","false");
            cfStyleGrid_New(grdT_CM_GRADE, 0,"false","false");
            
        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/

        var old_i = 0;                 // �� ��ȣ
        var old_u = 0;                 // �����ǹ�ȣ
        var old_enono = '';            // ���(��Ŭ���� ���� �Էµ� ����� ���ϱ� ����)


        /*******************************************************
         * ��ȭ����� ������ ȣ��� ���� jsp ������ �ѷ��ش�.  *
         *******************************************************/
        function fnc_ViewFrameTab(u) {

            var iframe = document.getElementById("iframe_tab_"+u);
            
            var gubun = "1";//���ѿ� ���� ���� ����(�Ұ���)�� ���� ����(pirc011, pira018)

            // ������ �ٸ� ���� Ŭ���� ��� ����ȭ���� ������ �ʰ�, ���ο� ȭ���� ����
            if (old_u != u && old_u != 0) {

                document.getElementById('view_tab_'+old_u).style.display='none';
            }

            document.getElementById('view_tab_'+u).style.display='inline';

            if(iframe != undefined) {
            	
                if (iframe.src == "about:blank") {

                  iframe.src = iframe.load_src + "?ENO_NO="+p_eno_no + "&GUBUN="+gubun + "&mode="+p_mode+"&srcid=code010";
                }
                else {

                    // ����� ����Ǵ� ��� ���� �������� ���� ������ �ٽ� �������� ����
                    //����
                    if (iframe.contentWindow.document.getElementById("ENO_NO").value != p_eno_no) {

                        iframe.contentWindow.document.getElementById("ENO_NO").value = p_eno_no;
                        iframe.contentWindow.fnc_SearchList();
                    }
                }
            }

            old_u=u;

        }

        /*************************************************************************
         * ������ ���ε� ���丮�� �̹����� �ѷ��ִ� User Defined Object
         * - usage : var obj = new Image(�̹����ױ���ID);
         *               obj.setImage("������ �̹��������� ��ġ�� ���ϸ�");
         *************************************************************************/
        function Image(imgTag) {
        	 
            var imgTag = imgTag;
            
            var action = "../../../servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
            var imgUrl = "";
            this.setImage = function(imgBox) {
                imgUrl = imgBox;
                imgTag.src = action + "&IMAGE=" +imgUrl;
            }

        }

        function fnc_code020Popup(){

            window.showModalDialog("../../hr/cod/code020.jsp", "Modal", "dialogWidth:1050px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

        }


    </script>
</head>


    <!--********************************************************************
    * ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
    *********************************************************************-->

    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    
    <Object ID="dsT_CM_ACCESS" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
        
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_AHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_BHISTORY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_FAMILY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_QUALIFICATION" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_SCHOOL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

   <Object ID="dsT_CM_SERVICE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_CAREER" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_REWARD" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_GRADE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        var ENO_NO  = "";
        var FILEURL = "";

        ENO_NO = dsT_CM_PERSON.NameValue(1, "ENO_NO");
        
        
        //
		
		
        //imgBox.setImage(FILEURL);

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� 
<form name="form1">
-->

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRequest','','../../images/button/btn_RequestOver.gif',1)"><img src="../../images/button/btn_RequestOn.gif" name="imgRequest" width="80" height="20" border="0" align="absmiddle" onClick="fnc_code020Popup()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="below">
                <tr>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>
            <table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream" frame="vsides">
                <colgroup>
                    <col width="140"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                    <col width="75 "></col>
                    <col width="145"></col>
                </colgroup>
                <tr>
                    <td align="center" rowSpan="4">
					<img id="photo" src="photo.src" border="0" width="136" height="170" style="position: relative; top: 2px"/></td>     
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input type=hidden id="REG_NO">
                        <input id="txtENO_NO" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtENO_NM"  class="input_ReadOnly" readonly style="width:100%">
                    </td>
                    <td align="center" class="blueBold">���ڼ���</td>
                    <td class="padding2423">
                        <input id="txtNAM_CHI"  class="input_ReadOnly" readonly style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">�������</td>
                    <td class="padding2423">
                        <input id="txtBIR_YMD" style="width:100%"  class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                         <input id="txtBIR_TAG" class="input_ReadOnly" readonly style="width:100%">
                    </td>
                    <td align="center" class="blueBold">��������</td>
                    <td class="padding2423">
                        <input id="txtNAM_ENG" class="input_ReadOnly" readonly style="width:100%">
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtDPT_CD" style="width:30%" maxlength="20"  class="input_ReadOnly"  readonly> <input id="txtDPT_NM" style="width:65%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtJOB_CD" style="width:30%" maxlength="20"  class="input_ReadOnly"  readonly> <input id="txtJOB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                    </td>
                    <td align="center" class="blueBold">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHOB_CD" style="width:30%" maxlength="20"  class="input_ReadOnly"  readonly> <input id="txtHOB_NM" style="width:65%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="blueBold">��&nbsp;��&nbsp;��</td>
                    <td class="padding2423">
                        <input id="txtHIR_YMD" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">�� ȥ ��</td>
                    <td class="padding2423">
                        <input id="txtWED_YMD" style="width:100%" class="input_ReadOnly" readonly>
                    </td>
                    <td align="center" class="blueBold">������</td>
                    <td class="padding2423">
                        <input id="txtPER_JOB" style="width:100%" class="input_ReadOnly"  readonly>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<!-- ���� �Է� ���̺� �� -->

<!-- �⺻���� ���� -->
<table width="1000" height="394" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
    <tr><td align="center">
        <input type=hidden id="ENO_NO" size="10">
        <!-- �� ��ư ���̺� ���� -->
        <table width="996" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="paddingTop5">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
                        <tr>
                            <td align="left">
                                <input type=button id="btn2" value="�⺻����"      onclick="fnc_ViewFrameTab(1)">
                                <input type=button id="btn3" value="��������"      onclick="fnc_ViewFrameTab(2)">
                                <input type=button id="btn4" value="�Ի������"    onclick="fnc_ViewFrameTab(3)">
                                <input type=button id="btn5" value="�Ի��İ��"    onclick="fnc_ViewFrameTab(4)">
                                <input type=button id="btn6" value="�ڰݸ���"      onclick="fnc_ViewFrameTab(5)">
                                <input type=button id="btn7" value="�з»���"      onclick="fnc_ViewFrameTab(6)">                                
                                <input type=button id="btn8" value="��ȸ����"      onclick="fnc_ViewFrameTab(7)">
                      	        <input type=button id="btn9" value="�������"      onclick="fnc_ViewFrameTab(8)">
                          		<!--  <input type=button id="btn9" value="�������"      onclick="fnc_ViewFrameTab(9)">	  -->
                                <input type=hidden id="ENO_NO" size="10">
                            </td>
                        <tr>
                    </table>
                </td>
            </tr>
        </table>
        <!-- �� ��ư ���̺� �� -->

        <!-- �λ�⺻2 ���� -->
        <div id="view_tab_1" style="width:996;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
        <iframe id="iframe_tab_1" src="about:blank" load_src="../../hr/cod/code011.jsp" frameborder="0" width="100%" height="100%" marginwidth="2" marginheight="2" scrolling="no" allowtransparency="true"></iframe>
        </div>
        <!-- �λ�⺻2 �� -->

        <!-- �������� ���� -->
        <div id="view_tab_2" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>��������</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_FAMILY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_FAMILY">
                                        <param name="Format"                  value="
			                                <C> id={currow}        width=35   name='����'         align=center </C>
			                                <C> id=REL_NM          width=100   name='����'         align=center </C>
			                                <C> id=ENO_NM          width=100   name='����'         align=center </C>
			                                <C> id=BIR_YMD         width=100  name='�������'     align=center mask='XX-XX-XX'</C>
			                                <C> id=EDGR_NM         width=130   name='�з�'         align=center  </C>
			                                <C> id=OCC_NAM         width=160   name='�ٹ�ó'                    </C>
			                                <C> id=JOB_CD          width=100   name='����'                      </C>
			                                <C> id=DPD_TAG1        width=100   name='�ξ翩��'     align=center value={Decode(DPD_TAG,'O','�ξ�','X','�̺ξ�','')} </C>
			                                <C> id=HIU_TAG1        width=100   name='�Ǻ�����'     align=center value={Decode(HIU_TAG,'O','�ξ�','X','�̺ξ�','')} </C>,'�̺ξ�','')} </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- �������� �� -->

        <!-- �Ի������ ���� -->
        <div id="view_tab_3" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>�Ի��İ��</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_BHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_BHISTORY">
                                        <param name="Format"                  value="
			                                <C> id={currow}        width=45   name='����'         align=center </C>
			                                <C> id=CMP_NAM         width=150  name='ȸ���'                    </C>
			                                <C> id=STR_YMD         width=80   name='�Ի���'       align=center </C>
			                                <C> id=END_YMD         width=80   name='�����'       align=center </C>
			                                <C> id=DPT_NAM         width=150   name='�Ҽ�'                      </C>
			                                <C> id=JOB_CD          width=80   name='����'        align=center  </C>
			                                <C> id=CHG_JOB         width=200  name='������'                  </C>
			                                <C> id=REMARK          width=140  name='���'                      </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- �Ի������ �� -->

        <!-- �Ի��İ�� ���� -->
        <div id="view_tab_4" style="width:800;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>�Ի��İ��</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_AHISTORY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_AHISTORY">
                                        <param name="Format"                  value="
                                            <C> id={currow}        width=30   name='����'         align=center </C>
                                            <C> id=STR_YMD         width=80   name='������'       align=center </C>
                                            <C> id=END_YMD         width=80   name='������'       align=center </C>
                                            <C> id=APP_NM          width=100  name='�߷ɱ���'     align=center  </C>
                                            <C> id=DPT_NM          width=120  name='�Ҽ�'                      </C>
                                            <C> id=TEAM_NM         width=150   name='��'              			 </C>
                                            <C> id=JOB_NM          width=70   name='����'           align=center  </C>
                                            <C> id=DUTY_NM         width=70   name='��å'                      </C>
                                            <C> id=REMARK          width=130  name='���'                      </C>
                                            <C> id=JCD_NM          width=95   name='��������'    align=center  </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- �Ի��İ�� �� -->

        <!-- �ڰݸ��� ���� -->
        <div id="view_tab_5" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>�ڰݸ���</strong>
                    </td>
                </tr>
            </table>
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_QUALIFICATION" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_QUALIFICATION">
                                        <param name="Format"                  value="
                                            <C> id={currow}        width=35   name='����'         align=center </C>
                                            <C> id=QUA_NM          width=170   name='�ڰݸ���'                  </C>
                                            <C> id=GAN_YMD         width=100   name='�����'       align=center </C>
                                            <C> id=CHG_YMD         width=100   name='������'       align=center </C>
                                            <C> id=DUE_YMD         width=100   name='������'       align=center </C>
                                            <C> id=QUA_NO          width=150   name='������ȣ'                  </C>
                                            <C> id=APP_ADM         width=150   name='����ó'                    </C>
                                            <C> id=ETG_YN1         width=120   name='��������'     align=center value={Decode(ETG_YN,'O','����','X','������','')} </C>

                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- �ڰݸ��� �� -->

        <!-- �з»��� ���� -->
        <div id="view_tab_6" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>�з»���</strong>
                    </td>
                </tr>
            </table>
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_SCHOOL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_SCHOOL">
                                        <param name="Format"                  value="
			                                <C> id=EDGR_CD         width=45   name='�ڵ�'         align=center </C>
			                                <C> id=EDGR_NM         width=120   name='�з±���'    align=center  </C>
			                                <C> id=GURS_YMD        width=100   name='�� �� ��'     align=center </C>
			                                <C> id=GURE_YMD        width=100   name='�� �� ��'     align=center </C>
			                                <C> id=SCH_NAM         width=200   name='�б�'       align=center </C>
			                                <C> id=MAJ_NM          width=120   name='����'      align=center </C>
			                                <C> id=MAJ_NM2         width=120   name='��������'     align=center</C>
			                                <C> id=GRD_NM          width=120   name='��������'     align=center  </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- �з»��� �� -->

        <!-- ��ȸ���� ���� -->
        <div id="view_tab_7" style="width:1000;height:364;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>��ȸ����</strong>
                    </td>
                </tr>
            </table>
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_SERVICE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
                                        <param name="DataID"                  value="dsT_CM_SERVICE">
                                        <param name="Format"                  value="
                                          <C> id={currow}        	width=40   name='����'         align=center  </C>
                                          <C> id=STR_YMD         	width=100   name='�� ��'        align=center  </C>
                                          <C> id=ATT_NM          	width=150  name='�� ��'                      </C>
                                          <C> id=ATT_OFFICE      	width=150  name='������'                   </C>
                                          <C> id=ATT_SBJ         	width=400  name='��系��'                   </C>
                                          <C> id=ATT_HOUR        	width=85   name='�ð�'         align=center  </C>
                                         ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- ��ȸ���� �� -->




        <!-- ��� ���� ����-->
        <div id="view_tab_8" style="width:1000;height:394;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="788" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>�������</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
			                        <comment id="__NSID__">
			                        <object id="grdT_CM_REWARD" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:300px;">
			                            <param name="DataID"                    value="dsT_CM_REWARD">
			                            <param name="Format"                    value="
			                                <C> id={currow}        width=30     name='����'           align=center </C>
			                                <C> id=REPU_YMD        width=100     name='�������'       align=center </C>
			                                <C> id=REPU_CD1        width=150    name='�������'       align=center value={Decode(REPU_CD,'1','����(�系)','2','����(���)','3','¡��(�系)','')} </C>

			                                <C> id=REPU_TNM        width=150     name='�������'                    </C>
			                                <C> id=SYC_NAM         width=170     name='����ó'                      </C>
			                                <C> id=REPU_RMK        width=170    name='�������'                    </C>
			                                <C> id=REMARK3         width=155    name='���'                        </C>
			                            ">
			                        </object>
			                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
         </div>
        <!-- ��� ���� �� -->



        <!-- �����Ȳ ����  -->

        <div id="view_tab_9" style="width:1000;height:394;border-style:solid;border-color:#999999;border-width:1;display:none;">
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8" height="25">
                        <img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
                        <strong>�������</strong>
                    </td>
                </tr>
            </table>
            <table width="988" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        <table border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
			                        <comment id="__NSID__">
			                        <object id="grdT_CM_GRADE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:988px;height:363px;">
			                            <param name="DataID"                    value="dsT_CM_GRADE">
			                            <param name="Format"                    value="
			                                <C> id={currow}       width=30     name='����'          	 	align=center </C>
			                                <C> id=EVAYM          width=100    name='������'      		 align=center mask='XXXX-XX'</C>
			                                <C> id=GRADE3         width=315    name='����������'       align=center </C>
			                                <C> id=GRADE4         width=315    name='����������'       align=center </C>
			                            ">
			                        </object>
			                        </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
         </div>

        <!--�����Ȳ �� -->

    </td></tr>
</table>
<!-- �λ�⺻2 �� -->


</form>
<!-- form �� -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- �޼����������� ���̺� -->
<object id="bnd" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
    <Param Name="DataID",   Value="dsT_CM_PERSON">
    <Param Name="BindInfo", Value='
        <C>Col=ENO_NO         	Ctrl=txtENO_NO      Param=value Disable=disabled</C>
        <C>Col=ENO_NM         	Ctrl=txtENO_NM      Param=value </C>
        <C>Col=NAM_CHI        	Ctrl=txtNAM_CHI     Param=value </C>
        <C>Col=NAM_ENG        Ctrl=txtNAM_ENG     Param=value </C>
        <C>Col=BIR_YMD        	Ctrl=txtBIR_YMD     Param=value </C>
        <C>Col=BIR_TAG        	Ctrl=txtBIR_TAG     Param=value </C>
        <C>Col=HIR_YMD        Ctrl=txtHIR_YMD     Param=value </C>
        <C>Col=DPT_CD         Ctrl=txtDPT_CD      Param=value </C>
        <C>Col=DPT_NM         Ctrl=txtDPT_NM      Param=value </C>
        <C>Col=JOB_CD         Ctrl=txtJOB_CD      Param=value </C>
        <C>Col=JOB_NM         Ctrl=txtJOB_NM      Param=value </C>
        <C>Col=HOB_CD         Ctrl=txtHOB_CD      Param=value </C>
        <C>Col=HOB_NM         Ctrl=txtHOB_NM      Param=value </C>
        <C>Col=WED_YMD        Ctrl=txtWED_YMD     Param=value </C>
        <C>Col=PER_JOB        	Ctrl=txtPER_JOB     Param=value </C>
    '>
</object>