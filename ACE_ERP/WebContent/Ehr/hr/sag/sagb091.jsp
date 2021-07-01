<!--
***********************************************************************
* @source      : sagb091.jsp
* @description : ���缼�λ��� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/02/26      ���뼺        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp" %>

<html>
<head>
	<title>���缼�λ���(sagb091)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<script language="javascript">

		var btnList = 'FFFFFFFT';
        var param = window.dialogArguments;

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        
            trT_CP_NIGHTDUTY.KeyValue = "shr(O:dsT_DI_APPROVAL=dsT_DI_APPROVAL, O:dsT_CP_NIGHTDUTY=dsT_CP_NIGHTDUTY)";
            trT_CP_NIGHTDUTY.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb091.cmd.SAGB091CMD"
                                        + "&S_MODE=SHR"
                                        + "&PIS_YM="    +param.gun_ymd
                                        + "&DPT_CD="    +param.gun_dpt
                                        + "&SEQ_NO="    +param.seq_no
                                        + "&GRP_NO="    +param.grp_no
                                        + "&SAGB="      +param.sagb;
            trT_CP_NIGHTDUTY.post();

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
            fnc_HiddenElement("imgApproval");
            fnc_HiddenElement("imgRejection");
        
            

			cfStyleGrid(form1.grdT_CP_NIGHTDUTY,0,"false","false");      // Grid Style ����

            //�ش����� ���� �׸��� �÷����� �ٲ��.            
            fnc_ChangeGrid();

            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
		
			fnc_HotKey_Process(btnList, event.keyCode);
			
		}




        /**
         * �׸��� ���� ó��
         */
        function fnc_ChangeGrid() {
        
            //�Էµ����ʹ� ���� �������̹Ƿ� ������ ǥ���ؾ� ��
            var PIS_YM_SHR= param.gun_ymd;
            var preDate   = new Date(PIS_YM_SHR.substring(0,4), PIS_YM_SHR.substring(5,7)-2, "01");
            var prePIS_YY = preDate.getFullYear();
            var prePIS_MM = lpad((preDate.getMonth()+1),2,"0");
            var lastDay   = fnc_covNumber(fnc_Lastday(prePIS_YY, prePIS_MM));

            grdFormat = "<FC> id={currow}       width=30    name='NO'           align=center                               </FC>" 
                      + "<FC> id='DPT_NM'       width=80    name='�Ҽ�'           align=left      Edit=none   leftMargin='10'</FC>" 
                      + "<FC> id='JOB_NM'       width=50    name='����'           align=left      Edit=none   leftMargin='10'</FC>" 
                      + "<FC> id='ENO_NO'       width=60    name='���'           align=center    Edit=none                  </FC>" 
                      + "<FC> id='ENO_NM'       width=60    name='����'           align=center    Edit=none                  </FC>" 
                      + "<C> id='PIS_YM'        width=70    name='�ش���'     align=center    Edit=none                  </C>"  
                      + "<C> id='DUTY_CNT'      width=70    name='�����ϼ�'     align=right     Edit=none                  </C>"  
                      + "<C> id='DUTY_AMT'      width=70    name='��������'     align=right     Edit=none                  </C>"  
                      + "<C> id='REMARK'        width=100   name='���'           align=left      Edit=none                  </C>"  
                      + "<G> name='"+prePIS_YY+"�� "+prePIS_MM+"�� ��û��' HeadBgColor='#F7DCBB'";
                      
            for(var i=1; i<=lastDay; i++) 
                grdFormat+= "    <C> id='AT"+i+"_CD'    width=20    name='"+i+"'    align=center    Edit=none   bgcolor={Decode(AT"+i+"_CD,'Y','#F2AC47','#FEEFEF')}     </C>" 

            grdFormat+= "</G>";
                                            
            form1.grdT_CP_NIGHTDUTY.Format = grdFormat;

            //ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
            //����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
            cfStyleGrid(form1.grdT_CP_NIGHTDUTY,15,"true","false");      // Grid Style ����

        }



        /**
         * ó�� ��ư
         */
        function fnc_Append(app_yn) {
            
            if (dsT_DI_APPROVAL.CountRow < 1) {
                alert("ó���� �ڷᰡ �����ϴ�!");
                document.getElementById("resultMessage").innerText = "* ó���� �ڷᰡ �����ϴ�!";
                return;
            }
            
            //�������� ����
            if(param.gunc == "020") {
            
                var text = "[�Ҽ�:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                         + "�ش���:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+", "
                         + "�����:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PENO_NM")+"] "
                         + "�� �ڷḦ "+(app_yn == "Y" ? "����" : "�ΰ�")+" �Ͻðڽ��ϱ�?";
                if (!confirm(text)) return;
            
            
                dsT_DI_APPROVAL.NameString(1, "APP_TAG") = app_yn;
            } else {
            
                var text = "[�Ҽ�:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "PDPT_NM")+", "
                         + "�ش���:"+dsT_DI_APPROVAL.NameString(dsT_DI_APPROVAL.RowPosition, "GUN_YMD")+"] "
                         + "�� �ڷḦ "+(app_yn == "Y" ? "����" : "�ΰ�")+" �Ͻðڽ��ϱ�?";
                if (!confirm(text)) return;
                
                
                for(var i=1; i<=dsT_DI_APPROVAL.CountRow; i++)
                    dsT_DI_APPROVAL.NameString(i, "APP_TAG") = app_yn;
            }
            
            
            trT_DI_APPROVAL.KeyValue = "tr01(I:dsT_DI_APPROVAL=dsT_DI_APPROVAL)";
            trT_DI_APPROVAL.action   = "/servlet/GauceChannelSVL?cmd=hr.sag.b.sagb090.cmd.SAGB090CMD&S_MODE=SAV";
            trT_DI_APPROVAL.post();
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
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CP_NIGHTDUTY)		   |
    | 3. ���Ǵ� Table List(T_CP_NIGHTDUTY) 			 	   |
    +------------------------------------------------------>
	<Object ID="dsT_CP_NIGHTDUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>
    
    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_DI_APPROVAL                     |
    | 3. Table List : T_DI_APPROVAL                 |
    +----------------------------------------------->
    <Object ID="dsT_DI_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CP_NIGHTDUTY)		   |
    | 3. ���Ǵ� Table List(T_CP_NIGHTDUTY)			       |
    +------------------------------------------------------>
	<Object ID="trT_CP_NIGHTDUTY" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
    
	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton					   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_DI_APPROVAL)		   |
    | 3. ���Ǵ� Table List(T_DI_APPROVAL)			       |
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
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadCompleted(iCount)">
		if (iCount < 1)    {
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			//alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
		} else {
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			fnc_Message(document.getElementById("resultMessage"),"MSG_03",iCount);
        }
    </Script>

    <Script For=dsT_DI_APPROVAL Event="OnLoadCompleted(iCount)">

        if(iCount > 0) {
            var today   = fnc_covNumber(getToday());
    
            //CHECK_DATE!!!
            
            //����Ⱓ
            var appFrom = fnc_covNumber(param.gun_ymd+"11");
            var appTo   = fnc_covNumber(param.gun_ymd+"15");
            
            var app_yn  = dsT_DI_APPROVAL.NameString(1, "PAPP_YN");
            
            
            //������ ����Ⱓ�̸�
            /*
            test test test
            if(appFrom <= today
                    && today <= appTo) {
            */
                //����϶�
                if(app_yn == "R") {
                    fnc_ShowElement("imgApproval");
                    fnc_ShowElement("imgRejection");
                }
            /*
            test test test
            }
            */
        }
        
    </Script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<Script For=dsT_CP_NIGHTDUTY Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    
	<Script For=dsT_DI_APPROVAL Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>
    

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_DI_APPROVAL event="OnSuccess()">
		fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
        alert("ó���� �Ϸ� �Ǿ����ϴ�.");
        window.close();
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
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">���缼�λ���</td>
					<td align="right" class="navigator">HOME/���°���/���ϱٹ�/���ϱٹ�����ó��/<font color="#000000">���缼�λ���</font></td>
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
                <img src="/images/button/btn_ApprovalOn.gif"    name="imgApproval"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('Y');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgApproval','','/images/button/btn_ApprovalOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
                <img src="/images/button/btn_RejectionOn.gif"   name="imgRejection" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Append('N');" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRejection','','/images/button/btn_RejectionOver.gif',1)" style="cursor:hand; visibility:hidden; position:absolute; display:none;">
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

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
    </table>
        
    <!-- ���� ��ȸ �׸��� ���̺� ����-->
    <table width="800" border="0" cellspacing="0" cellpadding="0">
    	<tr>
    		<td style="padding-top:2px;" colspan="2">
    		<table border="0" cellspacing="0" cellpadding="0">
    			<tr align="center">
    				<td>
    				<comment id="__NSID__">
    				<object id="grdT_CP_NIGHTDUTY" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:800px;height:260px;">
    					<param name="DataID" value="dsT_CP_NIGHTDUTY">
    					<param name="Editable" value="false">
    					<param name="DragDropEnable" value="true">
    					<param name="SortView" value="Left">
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