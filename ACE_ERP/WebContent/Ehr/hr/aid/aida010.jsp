	<!--*************************************************************************
	* @source      : aida010.jsp												*
	* @description : ������ݽ�û������ PAGE / �����ݽ�û���� PAGE(POP_UP)		    *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2016/04/28            �̵���            	ERP �̻�									*
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.DateUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>������ݽ�û��</title>
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

		var year = gcurdate.substring(0,4);

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			
			//������ݽ�û��  ���� ��ȸ
			var REQ_YMD_STDT_SHR = document.getElementById("txtREQ_YMD_STDT_SHR").value;
			var REQ_YMD_ENDT_SHR = document.getElementById("txtREQ_YMD_ENDT_SHR").value;
            var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value;

    		//�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
			if(gusrid != "6060002" && gusrid != "2030007" && gusrid != "6180001" && gusrid != "6180022" && gusrid != "3200018" && gusrid != "4180009"){ 
            

	            if(ENO_NO_SHR == "") {
	                alert("����� ������ �ּ���.");
	                document.getElementById("txtENO_NO_SHR").focus();
	                return;
	            }

			}
	            
			var AID_STS_SHR = document.getElementById("cmbAID_STS_SHR").value;

			dsT_AD_AIDAPP.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SHR&REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"+&AID_STS_SHR="+AID_STS_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
			dsT_AD_AIDAPP.reset();
            document.form1.print_flag.value = "Y";
        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			 	*
         ********************************************/
        function fnc_SearchItem() {

        }

		/********************************************
         * 03. ���� �Լ�								*
         ********************************************/
        function fnc_Save() {
			if ( !fnc_SaveItemCheck() ) {
				return;
			}

			// save
			trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)";
			trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=SAV";
			trT_AD_AIDAPP.post();
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
	        fnc_Remove();
        }

		/********************************************
         * 05. �μ� �Լ�  								*
         ********************************************/
        function fnc_Print() {
			//������ݽ�û��  ���� ��ȸ
            if ( document.form1.print_flag.value == "Y" ) {
                var f = document.form1;

                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                var day = date.getDate();
                var s_year  = String(year);
                var s_month = String(month);
                var s_day = String(day);
                var TODAY_VAL = s_year + "�� " + s_month + "�� " + s_day + "��";

                var REQ_YMD_STDT_SHR = document.getElementById("txtREQ_YMD_STDT_SHR").value;
                var REQ_YMD_ENDT_SHR = document.getElementById("txtREQ_YMD_ENDT_SHR").value;

                var WORK_NO1 = document.getElementById("txtWORK_NO1").value;    //������ȣ
                var HLP1_AMT = document.form1.medHLP1_AMT.Text;                     //������
                var HLP2_AMT = document.form1.medHLP2_AMT.Text;                     //������

                var REQ_NO  = document.getElementById("txtREQ_NO").value;           //��û��ȣ
                var AID_YMD = document.getElementById("txtAID_YMD").value;          //�߻�����
                var HIR_YMD = document.getElementById("txtHIR_YMD").value;          //�Ի���
                var DPT_NM  = document.getElementById("txtDPT_NM").value;           //�μ�
                var JOB_NM  = document.getElementById("txtJOB_NM").value;           //����
                var ENO_CD  = document.getElementById("txtENO_NO").value;           //��û��
                var ENO_NM  = document.getElementById("txtENO_NM").value;           //��û��
                var AID_CD  = document.form1.cmbAID_CD.options[document.form1.cmbAID_CD.selectedIndex].text;  //��û����(select)
                var AID_NM  = document.getElementById("txtAID_NM").value;           //�����
                var LSE_YY  = document.getElementById("txtLSE_YY").value;           //�ټӳ��
                var LSE_MM  = document.getElementById("txtLSE_MM").value;           //�ټӿ���
                var ABA_CD  = document.form1.cmbABA_CD.options[document.form1.cmbABA_CD.selectedIndex].text;  //�����(select)
                var ACC_NO  = document.getElementById("txtACC_NO").value;           //���¹�ȣ
                var REC_NM  = document.getElementById("txtREC_NM").value;           //������

                var param = "REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"&TODAY_VAL="+TODAY_VAL;
                param += "&REQ_NO="+REQ_NO+"&AID_YMD="+AID_YMD+"&HIR_YMD="+HIR_YMD+"&DPT_NM="+DPT_NM+"&JOB_NM="+JOB_NM+"&ENO_CD="+ENO_CD+"&ENO_NM="+ENO_NM;
                param += "&AID_CD="+AID_CD+"&AID_NM="+AID_NM+"&LSE_YY="+LSE_YY+"&LSE_MM="+LSE_MM+"&ABA_CD="+ABA_CD+"&ACC_NO="+ACC_NO+"&REC_NM="+REC_NM;
                param += "&REQ_YMD_STDT_SHR="+REQ_YMD_STDT_SHR+"&REQ_YMD_ENDT_SHR="+REQ_YMD_ENDT_SHR+"&WORK_NO1="+WORK_NO1+"&HLP1_AMT="+HLP1_AMT+"&HLP2_AMT="+HLP2_AMT;

                var url = "aida010_PV.jsp?" + param;
                window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");
                return;
            } else {
                alert("��ȸ�� �μ� �����մϴ�.");
            }
        }

		/********************************************
         * 06. ���� ���� �Լ�  							*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {

            var url = "../../../Ehr/hr/aid/aida011.jsp?REQ_NO=&TYPE=TYPE1";
            //window.showModalDialog(url, dsT_AD_AIDAPP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
			cfWinOpen(url,"�����",1100,650);
			
            fnc_SearchList();
            
		}

		/********************************************
         * 08. �߰� �Լ� 								*
         ********************************************/
        function fnc_Append() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 09. ���� �Լ� 								*
         ********************************************/
        function fnc_Remove() {
			
	        if (dsT_AD_AIDAPP.CountRow < 1) {
	        	
				fnc_Message(document.getElementById("resultMessage"),"MSG_05");
                alert("���� �� �ڷᰡ �����ϴ�!");
                return;
                
            }else{
            	
           		var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n";
           		
            	tmpMSG += "��û��     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "ENO_NM")+"\n";
            	tmpMSG += "��û����  = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_CD")+"\n";
            	tmpMSG += "�����     = "+dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "AID_NM")+"\n";

	            if( confirm(tmpMSG) ){
	            	
					var REQ_NO = dsT_AD_AIDAPP.nameValue(dsT_AD_AIDAPP.RowPosition, "REQ_NO");

					dsT_AD_AIDAPP.DeleteRow(dsT_AD_AIDAPP.RowPosition);
					// �Ķ���� �߰�
					trT_AD_AIDAPP.Parameters = "REQ_NO="+REQ_NO;

					trT_AD_AIDAPP.KeyValue = "tr01(I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)";
					trT_AD_AIDAPP.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.aid.a.aida010.cmd.AIDA010CMD&S_MODE=DEL";
					trT_AD_AIDAPP.post();
					
				}
			}
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {
			
	        document.getElementById("resultMessage").innerText = ' ';

			// �޺��ڽ� �⺻ ����
			document.form1.cmbAID_STS_SHR.selectedIndex = 0;

        	dsT_AD_AIDAPP.ClearData();

            document.getElementById("txtREQ_YMD_STDT_SHR").value = getTodayArray()[0]+"-"+getTodayArray()[1]+"-01";

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
			
         	if ( !dsT_AD_AIDAPP.isUpdated ) {
         		
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
				
                return false;
			}
         	
			return true;
			
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

            document.getElementById("txtREQ_YMD_STDT_SHR").value = "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, -1, 0),"yyyy-MM-dd") %>";
            document.getElementById("txtREQ_YMD_ENDT_SHR").value =  "<%=DateUtil.getConvertDateFormat(DateUtil.getAfterDate(0, 0, 0),"yyyy-MM-dd") %>";

            cfStyleGrid_New(form1.grdT_AD_AIDAPP,0,"false","false");      // Grid Style ����


            document.getElementById("txtENO_NO_SHR").value = gusrid;
            document.getElementById("txtENO_NM_SHR").value = gusrnm;


    		//�����ڰ� �ƴϸ� ��� �˻��� ���� ���Ѵ�.
			if(gusrid != "6060002" && gusrid != "4180009" && gusrid != "6180022" && gusrid != "6180001" && gusrid != "2030007" && gusrid != "2070020" && gusrid != "3200018" && gusrid != "4180009"){ 

	            fnc_ChangeStateElement(false, "txtENO_NO_SHR");
	            fnc_ChangeStateElement(false, "txtENO_NM_SHR");
	            fnc_ChangeStateElement(false, "ImgEnoNoShr");

    		}


            //�����Ҷ� ����ڷ� �⺻���� ��ȸ
            document.getElementById("cmbAID_STS_SHR").value = "S";
            
            fnc_SearchList();
            
        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			
			fnc_HotKey_Process(btnList, event.keyCode);
			
		}

		/********************************************
         * ��¥ ���� ��ȿ�� üũ                           			*
         ********************************************/
        function fncCheckDate(obj) {
			
            if (obj.value == '') return;
            
            if(!cfDateExpr(obj.value)) {
            	
                alert('��ȿ�� ��¥�� �ƴմϴ�.');
                obj.focus();
                
            }
            
        }

 		/********************************************
         * ��û���ڿ��� ��Ŀ�� ������ ��û���ڿ� ��       		*
         ********************************************/
		function cfCheckDateTermAIDA010(p_obj,p_stdt,p_endt) {
			if( document.getElementById(p_stdt).value != '' && document.getElementById(p_endt).value != '' ) {
				if( cfDateDiff(document.getElementById(p_stdt).value.replace(/\-/g,''),document.getElementById(p_endt).value.replace(/\-/g,'')) < 0 ) {
					alert("�߻����ڰ� ��û���ں��� Ů�ϴ�.");
					document.getElementById(p_obj).value = '';
				}
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_AD_AIDAPP)			 	   |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_AD_AIDAPP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_AD_AIDAPP)			       |
    | 3. ���Ǵ� Table List(T_AD_AIDAPP)				       |
    +------------------------------------------------------>
	<Object ID="trT_AD_AIDAPP" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_AD_AIDAPP=dsT_AD_AIDAPP,I:dsT_AD_AIDAPP=dsT_AD_AIDAPP)">
	</Object>

    <!-- ���� �޺��� ���� DataSet -->
    <!-- ����  -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_R5"/>
       <jsp:param name="CODE_GUBUN"    value="R5"/>
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
	<Script For=dsT_AD_AIDAPP Event="OnLoadCompleted(iCount)">
		if (iCount == 0)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_AD_AIDAPP.CountRow);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_AD_AIDAPP Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_AD_AIDAPP event="OnFail()">
        alert(trT_AD_AIDAPP.ErrorMsg);
    </script>

    <!-----------------------------------------------------+
    | ��û �� ������ ��ȸ�Ҷ�                                   |
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_AD_AIDAPP event=OnDblClick(row,colid)>

        var url = "../../../Ehr/hr/aid/aida011.jsp?REQ_NO="+dsT_AD_AIDAPP.NameString(row, "REQ_NO")+"&TYPE=TYPE2";
        
		//window.showModalDialog(url, dsT_AD_AIDAPP, "dialogWidth:870px; dialogHeight:500px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
		
		cfWinOpen(url,"�����",1100,650);
		
        //fnc_SearchList();
		
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

	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_NewApplicationOver.gif',1)"><img src="../../images/button/btn_NewApplicationOn.gif" name="imgAddNew" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

	<!-- power Search���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0" id="searchTable">
		<tr>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="60"></col>
							<col width="240"></col>
							<col width="60"></col>
							<col width="80"></col>
							<col width="60"></col>
							<col width="*"></col>
						</colgroup>
						<tr>
							<td class="searchState" align="right">��û�Ⱓ</td>
							<td class="padding2423" align="left">
								<input type="text" id="txtREQ_YMD_STDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR1','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtREQ_YMD_STDT_SHR','','97','359');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR1" width="21" height="20" border="0" align="absmiddle"></a>
								 ~
								<input type="text" id="txtREQ_YMD_ENDT_SHR" style="ime-mode:disabled" size="10" maxlength="10" onblur="fncCheckDate(this);" onkeypress="if (event.keyCode == 13) fnc_SearchList(); else cfDateHyphen(this);cfCheckNumber();">
								<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('img_YMD_SHR2','','../../images/button/btn_HelpOver.gif',1)" onclick="calendarBtn('datetype1','txtREQ_YMD_ENDT_SHR','','212','359');"><img src="../../images/button/btn_HelpOn.gif" name="img_YMD_SHR2" width="21" height="20" border="0" align="absmiddle"></a>
							</td>
							<td align="right" class="searchState">��ȸ����</td>
							<td class="padding2423" align="left">
								<select id="cmbAID_STS_SHR" style="WIDTH: 60px" onchange="fnc_SearchList()">
									<option value="">���</option>
									<option value="A">����</option>
									<option value="S">���</option>
									<option value="O">����</option>
									<option value="R">�ΰ�</option>
									<option value="C">�ݼ�</option>
									<option value="D">��ǥ</option>
									<option value="E">����</option>
								</select>
							</td>
                            <td align="right" class="searchState">�� ��&nbsp;</td>
                            <td class="padding2423">
                                <input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');">
                                <input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');">
                                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO_SHR','txtENO_NM_SHR');"></a>
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
						<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_AD_AIDAPP" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
						<param name="DataID" value="dsT_AD_AIDAPP">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{CUROW}"		width="40"		name="NO"			align="center"	value={String(Currow)}</C>
							<C> id="REQ_NO"			width="100"		name="��û��ȣ"		align="center"	Edit=none</C>
							<C> id="AID_CD_NM"		width="200"		name="��û����"		align="left"	Edit=none	LeftMargin="10"</C>
							<C> id="AID_YMD"		width="120"		name="�߻�����"		align="center"	Edit=none</C>
							<C> id="ENO_NM"			width="120"		name="��û��"			align="center"	Edit=none</C>
							<C> id="REQ_YMD"		width="120"		name="��û����"		align="center"	Edit=none</C>
							<C> id="SPL_YMD"		width="120"		name="��������"		align="center"	Edit=none</C>
							<C> id="AID_STS_NM"		width="120"		name="����"			align="left"	Edit=none	LeftMargin="10"</C>
						'>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
        <input type="hidden" name="print_flag" value="N">
	</table>
	<!-- ���� ��ȸ �׸��� ���̺� ��-->

	</form>
	<!-- form �� -->

</body>
</html>


<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_AD_AIDAPP ���� ���̺� -->
	<object id="bndT_AD_AIDAPP" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_AD_AIDAPP">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO			Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO			Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM		Param=value</C>
			<C>Col=AID_YMD			Ctrl=txtAID_YMD		Param=value</C>
			<C>Col=CET_NO			Ctrl=txtCET_NO		Param=value</C>
			<C>Col=HIR_YMD			Ctrl=txtHIR_YMD		Param=value</C>
			<C>Col=RET_YMD			Ctrl=txtRET_YMD		Param=value</C>
			<C>Col=OCC_CD			Ctrl=txtOCC_CD		Param=value</C>
			<C>Col=DPT_CD			Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD			Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM		Param=value</C>
			<C>Col=LSE_YY			Ctrl=txtLSE_YY		Param=value</C>
			<C>Col=LSE_MM			Ctrl=txtLSE_MM		Param=value</C>
			<C>Col=ABA_CD			Ctrl=cmbABA_CD		Param=value</C>
			<C>Col=ACC_NO			Ctrl=txtACC_NO		Param=value</C>
			<C>Col=REC_NM			Ctrl=txtREC_NM		Param=value</C>
			<C>Col=AID_CD			Ctrl=cmbAID_CD		Param=value</C>
			<C>Col=AID_NM			Ctrl=txtAID_NM		Param=value</C>
			<C>Col=AID_RPT			Ctrl=hidAID_RPT		Param=value</C>
			<C>Col=REQ_YMD			Ctrl=txtREQ_YMD		Param=value</C>
			<C>Col=HLP1_AMT			Ctrl=medHLP1_AMT	Param=text</C>
			<C>Col=HLP2_AMT			Ctrl=medHLP2_AMT	Param=text</C>
			<C>Col=SUM_AMT			Ctrl=medSUM_AMT		Param=text</C>
			<C>Col=WORK_NO1			Ctrl=txtWORK_NO1	Param=value</C>
			<C>Col=SPL_YMD			Ctrl=txtSPL_YMD		Param=value</C>
			<C>Col=AID_STS			Ctrl=cmbAID_STS		Param=value</C>
			<C>Col=RET_RSN			Ctrl=txtRET_RSN		Param=value</C>
			<C>Col=AID_CET			Ctrl=txtAID_CET		Param=value</C>
			<C>Col=DEC1_NM			Ctrl=txtDEC1_NM		Param=value</C>
			<C>Col=DEC1_YMD			Ctrl=txtDEC1_YMD	Param=value</C>
			<C>Col=DEC2_NM			Ctrl=txtDEC2_NM		Param=value</C>
			<C>Col=DEC2_YMD			Ctrl=txtDEC2_YMD	Param=value</C>
		">
	</object>
