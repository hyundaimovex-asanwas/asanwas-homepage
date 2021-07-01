<!--
***********************************************************************
* @source      : eist030.jsp
* @description : ������Ʈ ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/01/12            �̵���            	ERP�̻�						
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>������Ʈ ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >


        var today = gcurdate;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


			var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");

			
			dsT_TS_PROJECT.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist030.cmd.EIST030CMD&S_MODE=SHR&PIS_YM="+pis_ym;

    		dsT_TS_PROJECT.reset();

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

			if(!fnc_SaveItemCheck()) return;	//��ȿ�� üũ

			//var pis_ym = (document.getElementById("txtPIS_YM_SHR").value).replace(/-/g, "");
			//var eno_no = document.getElementById('txtENO_NO_SHR').value;			
			
			trT_TS_PROJECT.KeyValue = "tr01(I:dsT_TS_PROJECT=dsT_TS_PROJECT)";

			trT_TS_PROJECT.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist030.cmd.EIST030CMD&S_MODE=SAV";
																					            //+ "&PIS_YM="+pis_ym
																					            //+ "&ENO_NO="+eno_no;						

			//prompt(this, trT_TS_PROJECT.action);
			
			trT_TS_PROJECT.post();

			fnc_SearchList();        	
        	
        	
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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

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

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

            dsT_TS_PROJECT.AddRow();

/*			
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "PJT_CD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "PJT_NM") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "DPT_CD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "SEQ") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "FROM_YMD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "TO_YMD") = 1;
            dsT_TS_PROJECT.NameValue(dsT_TS_PROJECT.RowPosition, "USEYN") = 1;
*/

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



        }

        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {


        	window.close();

        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

        	
        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	return true;
        	
        	
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

            document.getElementById('txtPIS_YM_SHR').value = today.substring(0,7);
        
            //ǰ�ǹ�ȣ ��ȸ
            dsT_CM_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist030.cmd.EIST030CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_CM_TEAM.reset();
			
            document.getElementById('txtDPT_CD_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_CD");
            document.getElementById('txtDPT_NM_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_NM");  
            
    		//�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6050006" || gusrid == "2020009"){ 
            
	            document.getElementById('txtDPT_CD_SHR').value = "";
	            document.getElementById('txtDPT_NM_SHR').value = "";
	            
			}else{
				
	            document.getElementById('txtDPT_CD_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_CD");
	            document.getElementById('txtDPT_NM_SHR').value = dsT_CM_TEAM.NameValue(1,"DPT_NM");  			
							
			}

			cfStyleGrid_New(form1.grdT_TS_PROJECT,15,"true","true");      // Grid Style ����
			
			fnc_SearchList();
            
        }

		/********************
         * 15. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

		

		
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. ��ȸ�� DataSet								 |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_TS_PROJECT)   |
    | 3. ���Ǵ� Table List()		     |
    +------------------------------------------------>
    <Object ID="dsT_TS_PROJECT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			|
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_TS_PROJECT)	    |
    | 3. ���Ǵ� Table List()	            |
    +--------------------------------------------------->
    <Object ID ="trT_TS_PROJECT" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_TS_PROJECT Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_TS_PROJECT Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_TS_PROJECT Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
	    cfErrorMsg(this);

    </Script>

    <!-----------------------------+
    | Transaction Successful ó��  |
    +------------------------------>
    <script for=trT_TS_PROJECT event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��  |
    +--------------------------->
    <script for=trT_TS_PROJECT event="OnFail()">
        cfErrorMsg(this);
    </script>



<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAppend','','../../images/button/btn_AppendOver.gif',1)"><img src="../../images/button/btn_AppendOn.gif" name="imgAppend" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="ImgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>

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
									<col width="60"></col>
									<col width="100"></col>
									<col width="60"></col>
									<col width="*"></col>									
								</colgroup>
							<tr>
								<td align="right" class="searchState">�� ��&nbsp;</td>
								<td class="padding2423">
                                     <input type="text" id="txtPIS_YM_SHR" style="ime-mode:disabled" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
								</td>	
								
								<td align="right" class="searchState">��&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="9"  maxlength= "8"   style="ime-mode:disabled"   >
					                <input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="12" maxlength= "14"  >
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

<BR>

<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_TS_PROJECT" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
							<param name="DataID"					value="dsT_TS_PROJECT">
                            <param name="Editable"    				value="true">							
                            <param name="Format"					value="
								<C> id={currow}			width=30    name='NO'		    	align=center </C>
								<C> id='DPT_NM'	    	width=160	name='����'	        	align=center suppress=1</C>
								<C> id='PJT_CD'	    	width=140	name='������Ʈ�ڵ�'	    align=center show=false</C>								

								<C> id='PJT_NM'	    	width=300	name='������Ʈ��'	        align=left </C>

								<C> id='FROM_YMD'	    width=160	name='��������'	        align=center mask='XXXX-XX-XX'</C>								
								<C> id='TO_YMD'	    	width=160	name='��������'	        align=center mask='XXXX-XX-XX'</C>	
								<C> id='USEYN'	    	width=100	name='��뿩��'	        align=center EditStyle=Combo Data='Y:���,N:�̻��' AlwaysShowEditStyle=false </C>
									
																
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 




