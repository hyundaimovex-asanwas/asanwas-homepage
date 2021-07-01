	<!--*************************************************************************
	* @source      : guna016.jsp												*
	* @description : ���°�����Ȳ PAGE											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------			*
	* 2016/06/01      �̵���        ERP �̻�
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���°�����Ȳ</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

			//�����µ�� ���� ��ȸ
			var STR_YMD_SHR = document.getElementById("txtSTR_YMD_SHR").value;
			var END_YMD_SHR = document.getElementById("txtEND_YMD_SHR").value;
            var EMPL_DPT_CD = document.getElementById("hidEMPL_DPT_CD").value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;
            var ENO_NM_SHR = document.getElementById("txtENO_NM_SHR").value;


			//�������ڰ� ������ ��ȸ����.
			if(STR_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(STR_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtSTR_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� ������ ��ȸ����.
			if(END_YMD_SHR.trim().length == 0){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڸ� �Է��ϼ���.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}
			//�������ڰ� �߸��Ǿ����� ��ȸ����.
			if(END_YMD_SHR.trim().length != 10){
				if(event.type == "change"){
					return false;
				}else{
					alert("�������ڰ� �߸��Ǿ����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
				}
			}

			//�������ڰ� �������ں��� ũ�� �ʵȴ�.
			if(parseInt(END_YMD_SHR.replaceStr("-","")) < parseInt(STR_YMD_SHR.replaceStr("-",""))){
					alert("�������ڰ� �������ں��� �����ϴ�.");
					document.getElementById("txtEND_YMD_SHR").focus();
					return false;
			}
			
			trT_DI_CHANGE.KeyValue = "tr05(O:dsT_DI_CHANGE=dsT_DI_CHANGE)";
			
			trT_DI_CHANGE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.gun.a.guna016.cmd.GUNA016CMD"
                                   + "&S_MODE=SHR"
                                   + "&ENO_NO_SHR="+ENO_NO_SHR
                                   + "&STR_YMD_SHR="+STR_YMD_SHR
                                   + "&END_YMD_SHR="+END_YMD_SHR
                                   + "&EMPL_DPT_CD="+EMPL_DPT_CD;
			
			trT_DI_CHANGE.post();
			
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
            //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)

            if (dsT_DI_CHANGE.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_DI_CHANGE.GridToExcel("���°�����Ȳ", '', 225);


        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
        }



		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
        	dsT_DI_CHANGE.ClearData();
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			
        	window.close();
			
        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  					*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  						*
         ********************************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			document.getElementById("txtENO_NO_SHR").value=gusrid;
			document.getElementById("txtENO_NM_SHR").value=gusrnm;


            cfStyleGrid_New(form1.grdT_DI_CHANGE,15,"true","false");      // Grid Style ����
            
			var yyyy = gcurdate.substring(0,4);
            
			document.getElementById("txtSTR_YMD_SHR").value = yyyy + "-01-01";
			document.getElementById("txtEND_YMD_SHR").value = yyyy + "-12-31";
			

			if(gusrid == "6060002" || gusrid == "6070001" || gusrid == "6180001" || gusrid == "6180021"  || gusrid == "6180022" || gusrid == "2030007" || gusrid == "2070020" || gusrid == "2080003"){ 
				
				    fnc_ChangeStateElement(true, "ImgEnoNoSHR");
			    	fnc_ChangeStateElement(true, "txtENO_NO_SHR");
			    	fnc_ChangeStateElement(true, "txtENO_NM_SHR");

		    }else{

		            fnc_ChangeStateElement(false, "ImgEnoNoSHR");
		            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
		            fnc_ChangeStateElement(false, "txtENO_NM_SHR");

			}

			fnc_SearchList();
			
        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}


        /**
         * ����˾���ư Ŭ���� ���õ� ����� ������ ��ȸ�ؿ����� �Ѵ�.
         */
        function fnc_ClickEmpPopupSHR() {
            fnc_CommonEmpPopup("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if (document.getElementById("txtENO_NO_SHR").value  != "") {
                fnc_SearchEmpNoSHR();
            }
        }

        /**
         * ��� ������ ��ȸ �Ѵ�.
         * ��������� �˻�
         */
        function fnc_SearchEmpNmSHR() {
            //����� ã�ƿ��� �� ���� ��������
            fnc_GetCommonEnoNo("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");
            fnc_SearchEmpNoSHR();
        }
        /**
         * ��������� ��ȸ �Ѵ�.
         * ������� �˻�
         */
        function fnc_SearchEmpNoSHR() {
            var obj = new String;

            // ������ ��ü
            obj = fnc_GetCommonEnoNm("txtENO_NO_SHR", "txtENO_NM_SHR", "hidEMPL_DPT_CD", "3");

            if(obj != null && obj.eno_no != "") {
                document.getElementById("txtENO_NO_SHR").value      = obj.eno_no;
                document.getElementById("txtENO_NM_SHR").value      = obj.eno_nm;
            } else {
                document.getElementById("txtENO_NO_SHR").value      = "";
                document.getElementById("txtENO_NM_SHR").value      = "";
            }
        }
    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) 		     *
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet								   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(dsT_DI_CHANGE)			 	   |
    | 3. ���Ǵ� Table List(dsT_DI_CHANGE) 				 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!----------------------------------------------+
    | 1. ī�ǿ� DataSet                             |
    | 2. �̸� : dsT_DI_CHANGE_CP                  |
    | 3. Table List : dsT_DI_CHANGE                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_CHANGE_CP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_CHANGE)		       |
    | 3. ���Ǵ� Table List(T_DI_CHANGE)			       |
    +------------------------------------------------------>
	<Object ID="trT_DI_CHANGE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_CHANGE=dsT_DI_CHANGE)">
	</Object>


    <!-- ���� �޺��� ���� DataSet -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_H4"/>
       <jsp:param name="CODE_GUBUN"    value="H4"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_DI_CHANGE.CountRow);
        }

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_CHANGE event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_CHANGE event="OnFail()">
        cfErrorMsg(this);
    </script>

  </script>


    <!------------------------------+
    | �׸����� ROW�� ����Ŭ�� �Ҷ�  |
    +------------------------------->
	<script language=JavaScript for=grdT_DI_CHANGE event="OnDblClick(row,colid)">
		var GUN_GBN = dsT_DI_CHANGE.NameValue(row, "GUN_GBN");
		if(row < 1) {
			return;
		} else {

			//���õ� ROW�� dsT_DI_CHANGE_CP �����Ͽ� guna061�� dsT_DI_CHANGE_CP �Ѱ��ش�.
			cfCopyDataSet(dsT_DI_CHANGE, dsT_DI_CHANGE_CP, "copyHeader=yes,rowFrom="+row+",rowCnt=1");
			var str_ymd_shr = document.getElementById("txtSTR_YMD_SHR").value;
			var end_ymd_shr = document.getElementById("txtEND_YMD_SHR").value;
			var eno_no = dsT_DI_CHANGE.NameValue(row,"ENO_NO");
			var req_no = dsT_DI_CHANGE.NameValue(row,"REQ_NO");
			var app_yn_nm = dsT_DI_CHANGE.NameValue(row,"APP_YN_NM");
			var param = "str_ymd_shr="+str_ymd_shr+"&end_ymd_shr="+end_ymd_shr+"&eno_no="+eno_no+"&req_no="+req_no+"&app_yn_nm="+app_yn_nm;
			if(GUN_GBN == "C"){
				window.showModalDialog("../../../Ehr/hr/gun/guna012.jsp?MODE=READ&"+param, dsT_DI_CHANGE_CP, "dialogWidth:1050px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			}else if(GUN_GBN == "U"){
				window.showModalDialog("../../../Ehr/hr/gun/guna014.jsp?MODE=READ&"+param, dsT_DI_CHANGE_CP, "dialogWidth:1050px; dialogHeight:600px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			}

			fnc_SearchList();

		}
	</script>


	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">
    <input type="hidden" id="hidEMPL_DPT_CD">


	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"     name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="0" ��ellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0"  cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="30"></col>
							<col width="220"></col>
							<col width="30"></col>
							<col width="170"></col>
							<col width="30"></col>
							<col width=""></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">�Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtSTR_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtSTR_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtSTR_YMD_SHR','','108','113');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtEND_YMD_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fnc_CheckDate(this);cfCheckDate(this);cfCheckDateTerm('txtEND_YMD_SHR','txtSTR_YMD_SHR','txtEND_YMD_SHR');" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtEND_YMD_SHR','','224','113');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>

							<td class="searchState" align="right">���</td>
							<td class="padding2423" align="left">
								<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="7" maxlength= "7"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNoSHR()" onchange="fnc_SearchEmpNoSHR()">
                        		<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="10" maxlength= "14"onkeypress="javascript:if(event.keyCode==13) fnc_SearchEmpNmSHR()" onchange="fnc_SearchEmpNmSHR()">
                        		<img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoSHR" name="ImgEnoNoSHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_ClickEmpPopupSHR()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
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


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
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
	<!-- ���� ��ȸ �׸��� ���̺� ��-->


	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" value="dsT_DI_CHANGE">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"	width=40	name="NO"					align=center	value={String(Currow)}</C>
							<C> id="REQ_NO"		width=80	name="��Ϲ�ȣ"			align=center	Edit=none   show=false </C>
							<C> id="DPT_NM"		width=100   name="�Ҽ�"				align=center	Edit=none    </C>
							<C> id="JOB_NM"		width=80	name="����"				align=center	Edit=none    </C>
                            <C> id="ENO_NO"     width=80    name="���"         		align=center    Edit=none    </C>
                            <C> id="ENO_NM"     width=80    name="����"         		align=center    Edit=none    </C>
                            <C> id="REQ_YMD"    width=90    name="�������"         align=center    Edit=none   Mask="XXXX-XX-XX" </C>
                            
							<G> name="����" HeadBgColor="#dae0ee"
                            <C> id="OLD_YMD"    width=90    name="��������"         	align=center    Edit=none   Mask="XXXX-XX-XX" </C>
                            <C> id="OLD_GUN_NM" width=90    name="��û����"         align=center    Edit=none    </C>
							</G>
							
							<G> name="����" HeadBgColor="#dae0ee"
                            <C> id="NEW_YMD"    width=90    name="��������"         	align=center    Edit=none   Mask="XXXX-XX-XX" </C>
                            <C> id="NEW_GUN_NM" width=90    name="��û����"         align=center    Edit=none    </C>
							</G>
							
							<C> id="APP_YN_NM"  width=120   name="���翩��"    			 align=center    Edit=none   BgColor={Decode(APP_YN_NM,"�ΰ�","#FEB293")}  </C>
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

	<input type="hidden" id="txtDPT_CD">
	<input type="hidden" id="txtJOB_CD">
	</form>
	<!-- form �� -->
</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

