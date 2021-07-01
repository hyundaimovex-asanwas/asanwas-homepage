<!--
***********************************************************************
* @source      : etcb071.jsp
* @description : ������Ȳ ����ó�� - ���缼�λ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2009/10/20      ������        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>
<%
	String eno_no = box.getString("SESSION_ENONO");         //ǰ���ڻ��
%>
<html>
<head>
	<title>������Ȳ ����ó�� - ���缼�λ���(etcb071)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->

	<script language="javascript">

		var btnList = 'FFFFFFFT';

        var dsTemp = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
			//alert(dsTemp.NameValue(1,"REQ_NO"));
            //���缼�λ��� ��ȸ(�����û)
            if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SHR_01&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
                dsT_DI_CHANGE.reset();
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="C"){//���ϱ���
                dsT_DI_CHANGE.dataid = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SHR_02&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&ENO_NO="+dsTemp.NameValue(1,"ENO_NO");
                dsT_DI_CHANGE.reset();
            }

        }

		/********************************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  			*
         ********************************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 03. ���� �Լ�							*
         ********************************************/
        function fnc_Save() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 04. ���� �Լ�							*
         ********************************************/
        function fnc_Delete() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 05. �μ� �Լ�  							*
         ********************************************/
        function fnc_Print() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 06. ���� ���� �Լ�  						*
         ********************************************/
        function fnc_ToExcel() {
			// ������ ��ȯ �� �ڷᰡ �ִ��� üũ�ϰ�
			// �ڷḦ ������ ����(��Ʈ �� �ٲ� �ּ���)
        }

		/********************************************
         * 07. �ű� �Լ� 							*
         ********************************************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 08. �߰� �Լ� 							*
         ********************************************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 09. ���� �Լ� 							*
         ********************************************/
        function fnc_Remove() {

        	//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  						*
         ********************************************/
        function fnc_Clear() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  					*
         ********************************************/
        function fnc_Exit() {

			window.close();

        }

		/********************************************
         * 12. �˻� ���� ��ȿ�� �˻�  				*
         ********************************************/
        function fnc_SearchItemCheck() {
	        //�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 13. ���� ��ȿ�� üũ  					*
         ********************************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         ********************************************/
        function fnc_OnLoadProcess() {


            if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "���ϱ���";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"REQ_YMD");
                document.getElementById("txtGUN_GBN").value = "�����û";
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="R"){
                //document.getElementById("txtGUN_YMD").value = dsTemp.NameValue(1,"GUN_YMD");
                document.getElementById("txtGUN_GBN").value = "��ü�ٹ�";
            }
            if(dsTemp.NameValue(1,"APP_TIME")!=""){
                document.getElementById("txtUPT_YMD").value = dsTemp.NameValue(1,"APP_TIME");
            }else{
                document.getElementById("append_btn").style.display = "";
            }
			// �����ڸ� ��ư�� Ȱ��ȭ
            if(dsTemp.NameValue(1,"ENO_NO")!= "<%=eno_no%>"){
                document.getElementById("append_btn").style.display = "none";
            }else{
                document.getElementById("append_btn").style.display = "";
            }

            var nowDate = getToday().replace("-","").replace("-","");
            //var gunDate = (document.getElementById("txtGUN_YMD").value).replace("-","").replace("-","");
/*
			//���ϱ��´� ���� 9�� �������� ���簡��(�ӽ� �ּ�, ����� �븮, 20070905)
            if(dsTemp.NameValue(1,"GUN_GBN")=="C" && (new Date().getHours() >= "9" || nowDate != gunDate) ){
			   document.getElementById("append_btn").style.display = "none";

			//���º���� 30�� �������� ���簡��(�ӽ� �ּ�, ����� �븮, 20070905)
			}else if(dsTemp.NameValue(1,"GUN_GBN")=="U" && parseInt(cfDateDiff(gunDate, nowDate)) >30){
				document.getElementById("append_btn").style.display = "none";
			}
*/
            fnc_ChangeGrid();//�׸��� ���� ó��

			cfStyleGrid(form1.grdT_DI_CHANGE,0,"false","false");      // Grid Style ����

            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

        /*************************
         * 16. �׸��� ���� ó��  *
         ************************/
		function fnc_ChangeGrid() {

			if(dsTemp.NameValue(1,"GUN_GBN")=="C"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=100	name="�Ҽ�"		align=center	</C> '
                							+ '<C> id="JOB_NM"	width=70	name="����"		align=center    </C> '
                							+ '<C> id="ENO_NO"	width=70	name="���"		align=center	</C> '
                							+ '<C> id="ENO_NM"	width=100	name="����"		align=center	</C> '
                							+ '<C> id="GUN_CD"	width=100	name="����"	    align=center	VALUE={DECODE(GUN_CD,"()","",GUN_CD)}</C>   '
                							+ '<C> id="PIS_YYMMDD"	width=100	name="��������"	align=center	Mask="XXXX-XX-XX"	</C> '
                							+ '<C> id="REMARK"	width=140	name="����"	    align=left	    </C>';
            }else if(dsTemp.NameValue(1,"GUN_GBN")=="U"){
                form1.grdT_DI_CHANGE.FORMAT = '<C> id="DPT_NM"	width=80	name="�Ҽ�"		align=center	</C>  '
                                            + '<C> id="JOB_NM"	width=70	name="����"		align=center    </C>  '
                                            + '<C> id="ENO_NO"	width=50	name="���"		align=center	</C>  '
                                            + '<C> id="ENO_NM"	width=60	name="����"		align=center	</C>  '
                                            + '<G> name="����������"  HeadBgColor="#F7DCBB"                       '
											+ '    <C> id="REQ_YMD"	    width=80	name="������"	align=center Mask="XXXX-XX-XX"  </C> '
                                            + '    <C> id="BF_GUN_CD"	width=80	name="����"	align=center  VALUE={DECODE(BF_GUN_CD,"()","",BF_GUN_CD)}  </C> '
                                            + '    <C> id="BF_REMARK"	width=100	name="����"	align=left	    </C> '
                                            + '</G>'
                                            + '<G> name="�����ı���"  HeadBgColor="#F7DCBB"                       '
                                            + '<C> id="GUN_CD"		width=80	name="����"	align=center  VALUE={DECODE(GUN_CD,"()","",GUN_CD)} 	</C>  '
											+ '<C> id="CHN_YMD"	    width=80	name="������"	align=center  Mask="XXXX-XX-XX" </C> '
                                            + '<C> id="REASON"		width=100	name="����"	align=left	    </C>  '
                                            + '</G>';
            }

		}

        /********************************************
         * 17. ����, �Ⱒ ��ư ó��					*
         ********************************************/
		function fnc_Append(yn_var) {

            var msg = "";
			
            if(yn_var == "Y"){
                msg = "����ó����";
            }else{
				if(document.getElementById("txtREMARK").value == ""){
					alert("�ΰ������ �Է��ϼ���");
					document.getElementById("txtREMARK").focus();
					return false;
				}
                msg = "�ΰ�ó����";
            }

            if (confirm(msg+" �Ͻðڽ��ϱ�?")) {

				dsT_DI_CHANGE.UserStatus(1) = 1;

				trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_CHANGE=dsT_DI_CHANGE)";
				//trT_DI_APPROVAL.action = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_YMD="+document.getElementById("txtGUN_YMD").value+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO");
				trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.etc.b.etcb071.cmd.ETCB071CMD&S_MODE=SAV&APP_YN="+yn_var+"&GUN_GBN="+dsTemp.NameValue(1,"GUN_GBN")+"&GUN_DPT="+dsTemp.NameValue(1,"GUN_DPT")+"&PENO_NO="+dsTemp.NameValue(1,"PENO_NO")+"&SEQ_NO="+dsTemp.NameValue(1,"SEQ_NO")+"&REQ_NO="+dsTemp.NameValue(1,"REQ_NO")+"&REMARK="+document.getElementById("txtREMARK").value;
				trT_DI_APPROVAL.post();

            }

            window.close();

		}

    </script>
</head>

	<!--**************************************************************************************
    *                                                                                        *
    *	Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)*
    *                                                                                        *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_DI_CHANGE)		   |
    | 3. ���Ǵ� Table List(T_DI_CHANGE) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_DI_CHANGE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

    <!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_DI_APPROVAL)	   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL) 			   |
    +------------------------------------------------------>
	<Object ID="trT_DI_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����													 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����	   |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_DI_CHANGE Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
        document.getElementById("append_btn").style.display = "none";
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--**************************************************************************************
*                                       												 *
*	BODY START																			 *
*                                       												 *
***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">

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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">������Ȳ ����ó�� - ���缼�λ���</td>
					<td align="right" class="navigator">HOME/��������/���հ���/<font color="#000000">������Ȳ ����ó�� - ���缼�λ���</font></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="left">
				�����ϱ��� 9�� ������, ���º����� 30�� �������� ���簡 �����մϴ�.
			</td>
			<td height="35" class="paddingTop5" align="right">
                <span id="append_btn" style="display:none">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)">  <img src="/images/button/btn_ApprovalOn.gif"   name="imgApproval" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)">  <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');"></a>
                </span>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

<table width="800px" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
	<!-- ���� �Է� ���̺� ���� -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="110"></col>
                    <col width="140"></col>
					<col width="110"></col>
                    <col width="140"></col>
					<col width="110"></col>
					<col width="*"></col>
				</colgroup>
				<tr>
					<td align="center" class="creamBold">���±���</td>
					<td class="padding2423">
                        <input id="txtGUN_GBN" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">�����Ͻ�</td>
					<td class="padding2423">
                        <input id="txtUPT_YMD" style="width:100%;text-align:center;" class="input_ReadOnly" readonly>
                    </td>
					<td align="center" class="creamBold">�������</td>
					<td class="padding2423">
                        <input id="txtREMARK" style="width:100%;text-align:left;">
                    </td>
				</tr>
            </table>
            </td>
	</table>
	<!-- ���� �Է� ���̺� �� -->
</tr>
</table>

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td  width="100%" align="left" class="paddingTop5">
			<!-- ��ȸ ���� ���̺� ���� -->
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="bottom" class="searchState"><span id="resultMessage">&nbsp;</span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ��ȸ ���� ���̺� �� -->
			</td>
		</tr>
		<tr>
			<td class="paddingTop8" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_DI_CHANGE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:300px;">
						<param name="DataID" value="dsT_DI_CHANGE">
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