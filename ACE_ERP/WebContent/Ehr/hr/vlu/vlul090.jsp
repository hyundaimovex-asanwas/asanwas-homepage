<!--
***********************************************************************
* @source      : vlul090.jsp
* @description : ��ǥ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2014/04/13      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
<title>��ǥ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/style_new.css" rel="stylesheet" type="text/css">
<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/mdi_common.js"></script>
<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var year    = getToday().substring(0,4);

        var dsTemp = window.dialogArguments;

        var EVL_ENO_NO = "";
        var EVL_ENO_NM = "";

        if(dsTemp != "Modal") {
        	EVL_ENO_NO = "<%=box.get("SESSION_ENONO")%>";
        	EVL_ENO_NM = "<%=box.get("SESSION_ENONM")%>";
		} else {
			EVL_ENO_NO = "<%=request.getParameter("ENO_NO")%>";
			EVL_ENO_NM = "<%=request.getParameter("ENO_NM")%>";
		}        
        
        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var STATUS  = document.getElementById("selSTATUS").value;

			dsT_EVL_APPROVAL.ClearAll();
            dsT_EVL_APPROVAL.DataId = "/servlet/GauceChannelSVL?cmd=hr.vlu.l.vlul090.cmd.VLUL090CMD&S_MODE=SHR&STATUS=" + STATUS
            										+"&ENO_NM="+document.getElementById("txtEVL_ENO_NM").value+"&EVL_ENO_NO=" + document.getElementById("txtEVL_ENO_NO").value;
            dsT_EVL_APPROVAL.Reset();
        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {


        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {



        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {


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

            if (dsT_EVL_APPROVAL.CountRow < 1) {
                alert(fnc_GetMSG("MSG_09"));
                return;
            }

            grdT_EVL_APPROVAL.GridToExcel("��ǥ����", '', 225);

        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {


        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {


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

			/*document.getElementById("txtENO_NO_SHR").value     = '';
            document.getElementById("txtENO_NM_SHR").value     = '';
            document.getElementById("txtDPT_CD_SHR").value     = '';
            document.getElementById("txtDPT_NM_SHR").value     = '';
            document.getElementById("txtKIJUN_YMD_SHR").value  = '';*/


            document.getElementById("resultMessage").innerText = ' ';


            // DataSet Clear
            dsT_EVL_APPROVAL.ClearData();
        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {

            if(dsTemp != "Modal"){
	            frame = window.external.GetFrame(window);
	            frame.CloseFrame();
            }else{
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

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  			*
         *******************************************/
        function fnc_OnLoadProcess() {

			// DATASET �ʱ�ȭ
            fnc_Clear();

			cfStyleGrid_New(grdT_EVL_APPROVAL, 0, "false", "false");  // Grid Style ����
			
            document.getElementById("txtEVL_ENO_NO").value = EVL_ENO_NO;
            document.getElementById("txtEVL_ENO_NM").value = EVL_ENO_NM;

<%
    //�������� ��� �⵵, ��� �˻� Ȱ��ȭ
    if(!box.getString("SESSION_ROLE_CD").equals("1001") && !box.getString("SESSION_ROLE_CD").equals("1002")) {
%>

			document.getElementById("txtEVL_ENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_ENO_NO").readOnly = true;	  		
			document.getElementById("txtEVL_ENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_ENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";
<%
	}else{
%>
			document.getElementById("txtEVL_ENO_NO").className = "";
	  		document.getElementById("txtEVL_ENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtEVL_ENO_NM").className = "";
	  		document.getElementById("txtEVL_ENO_NM").readOnly = false;

<%
    }%>

    		fnc_SearchList();
        }


        
        function fnc_GetNm() {
            fnc_GetEnoNm('txtEVL_ENO_NO', 'txtEVL_ENO_NM','0','0');
            fnc_SearchList()

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtEVL_ENO_NM','txtEVL_ENO_NO');
	            fnc_SearchList()
	    }        
        

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_APPROVAL) |
    | 3. ���Ǵ� Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
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
    <Script For=dsT_EVL_APPROVAL Event="OnLoadCompleted(iCount)">

        if (iCount == 0)    {

            document.getElementById("resultMessage").innerText = fnc_GetMSG("MSG_15");

        } else {

            document.getElementById("resultMessage").innerText = iCount + fnc_GetMSG("MSG_16");
        }

    </Script>

    <Script For=dsT_EVL_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_EVL_APPROVAL Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | grdT_EVL_APPROVAL OnClick ó��							        |
    +------------------------------------------------------>
    <script language="javascript"  for=grdT_EVL_APPROVAL event=OnDblClick(row,colid)>

		if(row > 0) {	// header�� ����Ŭ�� �������

			if(dsT_EVL_APPROVAL.NameValue(row,"STATUS") != "") {	// �̻�Ű��� �� �� ����
				var url = "/hr/vlu/vlul080.jsp?ENO_NO=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NO") + "&ENO_NM=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NM") + "&STATUS=" + dsT_EVL_APPROVAL.NameValue(row,"STATUS");
				window.showModalDialog(url, "Modal", "dialogWidth:960px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
				fnc_SearchList();
				dsT_EVL_APPROVAL.RowPosition = row;
			} else {
				alert("��ǥ ��� ���Դϴ�. ��ǥ��� ���� ������ �����մϴ�.");
			}
		}

	</script>


<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();" oncontextmenu="return false">

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar2.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<div class="evl_container"><!-- evl_container ����-->

	<div class="info_title"><!-- info_title ����-->
		<h3 class="info_title_h3">��ǥ����</h3>
		<p class="info">HOME &gt; �λ���  &gt; KPI ��ǥ���� &gt; <strong>��ǥ����</strong></p>
	</div><!-- //info_title ��-->

	<div class="btn_group_right" ><!-- btn_group ����-->
		<ul class="list">
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','/images/button/btn_SearchOver.gif',1)"><img src="/images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a></li>
			<li><a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image5','','/images/button/btn_ExitOver.gif',1)"><img src="/images/button/btn_ExitOn.gif" name="Image5" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a></li>
		</ul>
	</div><!-- //btn_group ��-->
   <br><br>
	<div class="inquiry"><!-- inquiry ����-->
		<form action="" method="post" >
			<fieldset>
				<legend>��ǥ����</legend>
					<p>���� :
					<span>
						<select id="selSTATUS" name="selSTATUS" onchange="fnc_SearchList();">
							<option value="A">��ü</option>
							<option value="R">�̰�</option>
							<option value="N">�ΰ�</option>
							<option value="Y">����Ϸ�</option>
						</select>
					</span>
					&nbsp;&nbsp;���� :
					<span>
						<input type="text" id="txtEVL_ENO_NO" name="txtEVL_ENO_NO" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_GetNm()" onchange="fnc_GetNm()" /><input type="text" style="display:none" />
						<input type="text" id="txtEVL_ENO_NM" name="txtEVL_ENO_NM" size="10" maxlength="10" class="input_ReadOnly"  onkeypress="javascript:if(event.keyCode==13) fnc_Getcd()" onchange="fnc_Getcd()" /><input type="text" style="display:none" />
						<img src="/images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtEVL_ENO_NO','txtEVL_ENO_NM','hidEMPL_DPT_CD','1','');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','/images/button/btn_HelpOver.gif',1)"style="cursor:hand;">
						<input type="hidden" id="hidEMPL_DPT_CD">					
					</span>
					</p>
			</fieldset>
		</form>
	</div><!-- // inquiry ��-->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table summary="��ǥ����" class="grid_table"><!-- evl_table ����-->
	    <tr align="center">
	        <td>
	            <comment id="__NSID__">
	            <object id="grdT_EVL_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:900px;height:340px;" >
	                <param name="DataID"                  value="dsT_EVL_APPROVAL">
	                <param name="HiddenHScroll"		 value="true">
	                <param name="Format"                  value="
                        <C> id=HEAD_NM         width=200   	name='����'        			align=center Edit=None </C>
                        <C> id=DPT_NM          	width=200   	name='�Ҽ�'        			align=center Edit=None </C>
                        <C> id=JOB_NM          	width=100   	name='����'		   			align=center Edit=None </C>
                        <C> id=ENO_NO          	width=100   	name='���'        			align=center Edit=None </C>
                        <C> id=ENO_NM          	width=100   	name='����'        			align=center Edit=None </C>
                        <C> id=STATUS_NM    	width=200   	name='����'       			align=center Edit=None </C>
	                ">
	            </object>
	            </comment><script> __ShowEmbedObject(__NSID__); </script>
	        </td>
	    </tr>
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->

	<!-- ��ȸ ���� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop8">
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	                <tr>
	                    <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
	                </tr>
	            </table>
	        </td>
	    </tr>
	</table>
	<!-- ��ȸ ���� ���̺� ���� -->


</div><!-- //evl_container �� -->



</body>
</html>
