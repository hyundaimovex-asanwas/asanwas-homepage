	<!--*************************************************************************
	* @source      : eist050.jsp												*
	* @description : �ΰǺ� ��� ���� Upload PAGE								 	*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2017/02/16            �̵���         	        �����ۼ�					        *
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>
<%
    Configuration conf = Configuration.getInstance();
    String FILEURL = conf.get("framework.file.excel");
%>

<html>
<head>
<title>�ΰǺ� ��� ���� Upload</title>
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
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  														 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">


        var today = gcurdate;
        
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

            //�˻�����
            var PIS_YM = document.getElementById("txtPIS_YM").value;

            //�����ͼ� ����
            dsT_TS_LABORCOST.UseChangeInfo = true;
            dsT_TS_LABORCOST.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=SHR&PIS_YM="+PIS_YM;
            dsT_TS_LABORCOST.Reset();

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

            var PIS_YM    	= document.getElementById("txtPIS_YM").value;
            
            if(confirm("�����Ͻðڽ��ϱ�?")){           
            	

				// save
				trT_TS_LABORCOST.KeyValue = "tr01(I:dsT_TS_LABORCOST=dsT_TS_LABORCOST, O:dsRESULT=dsRESULT)";
				trT_TS_LABORCOST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=SAV&PIS_YM="+PIS_YM;
				trT_TS_LABORCOST.post();

            }				
				
        }

		/********************************************
         * 03. ó�� �Լ�								*
         ********************************************/
        function fnc_Conduct() {

            //�˻�����
            var PIS_YM  = document.getElementById("txtPIS_YM").value;

            if(confirm("ó���Ͻðڽ��ϱ�?")){

					//Ʈ����� ����
					trT_TS_LABORCOST.KeyValue = "SVL(I:SAV=dsT_TS_LABORCOST)";
					trT_TS_LABORCOST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=SAV_01&PIS_YM="+PIS_YM;
					trT_TS_LABORCOST.Post();					
					
			}
            
			fnc_SearchList();
			
        }



		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {

            // ���� �� �ڷᰡ �ִ��� üũ�ϰ�
            if (dsT_TS_LABORCOST.CountRow < 1) {
            	
                fnc_Message(document.getElementById("resultMessage"), "MSG_05");
                
                return;
            }
            
            var PIS_YM  = document.getElementById("txtPIS_YM").value;

            if(confirm("��ü �����Ͻðڽ��ϱ�?")){
            	
				trT_TS_LABORCOST.KeyValue = "tr01(I:dsT_TS_LABORCOST=dsT_TS_LABORCOST)";
				trT_TS_LABORCOST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=DEL&PIS_YM="+PIS_YM;
				trT_TS_LABORCOST.post();
				
			}
            
			fnc_SearchList();
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

        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {

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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {

  			document.getElementById("resultMessage").innerText = ' ';

        	dsT_TS_LABORCOST.ClearData();

        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {

			if (dsT_TS_LABORCOST.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			
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

         	if (!dsT_TS_LABORCOST.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

			cfStyleGrid_New(form1.grdT_TS_LABORCOST,15,"true","true");      // Grid Style ����

            document.getElementById("txtPIS_YM").value = gcurdate.substring(0,7);  //getTodayArray()[0]+"-"+getTodayArray()[1];
            
            fnc_SearchList();

        }

		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}




        /*****************************
         * 16. �������� ���ε� ó��  *
         ****************************/
         function fnc_FileUpload() {

            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;

            oFile_url = fcFILE_UPLOAD.Value;
            oFile_name = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            // �ش� Dataset�� Header�� ������ Header ����
            if (dsFILE_UPLOAD.CountColumn < 1) {
                dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");
            }

            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.ClearData();
            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(1, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(1, "FILE_NAME") = oFile_name;

            if(dsFILE_UPLOAD.NameValue(1, "FILE_URL") != ""){

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_TS_LABORCOST=dsT_TS_LABORCOST, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.eis.t.eist050.cmd.EIST050CMD&S_MODE=ULD";
                trFILE_UPLOAD.post();
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
    | 1. ��ȸ �� ����� DataSet								|
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_WL_CARDUP)			|
    | 3. ���Ǵ� Table List(T_WL_CARDUP) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_TS_LABORCOST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_CM_PERSON)			   |
    | 3. ���Ǵ� Table List(T_CM_PERSON)				   |
    +------------------------------------------------------>
	<Object ID="trT_TS_LABORCOST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_TS_LABORCOST=dsT_TS_LABORCOST,I:dsT_TS_LABORCOST=dsT_TS_LABORCOST)">
	</Object>


    <!-- ��� result -->
    <Object ID="dsRESULT" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"      value='÷������'>
        <param name="Enable"    value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload"  value="true">
    </object>

    <!-- Ʈ������ ������Ʈ ���� [���� ÷�ο�] -->
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name="KeyName"   value="dataid">
    </Object>

    <Script For=dsRESULT Event="OnLoadCompleted(iCount)">
        if (iCount == 1) {
            //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
            if(dsRESULT.NameString(0, "RESULT_MSG") != "") {
                fnc_ShowError(dsRESULT.NameString(0, "RESULT_MSG"));
            }
        }
    </Script>


	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_TS_LABORCOST Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

			for(i=1;i<=iCount;i++){
                dsT_TS_LABORCOST.UserStatus(i) = 1;
            }
        }
    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_TS_LABORCOST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsT_TS_LABORCOST Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_TS_LABORCOST event="OnSuccess()">
	        fnc_SearchList();
    </script>


	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trT_TS_LABORCOST event="OnFail()">
        alert(trT_TS_LABORCOST.ErrorMsg);
    </script>
    <script for=trFILE_UPLOAD event="OnFail()">
        alert(trFILE_UPLOAD.ErrorMsg);
    </script>

 	<!-----------------------------------------------------+
    | Row �߰��� �ٸ������� position �ű涧 ó��				   |
    +------------------------------------------------------>
	<script language=JavaScript for=dsT_TS_LABORCOST event=CanRowPosChange(row)>
	
		if ( dsT_TS_LABORCOST.NameValue(row,"ENO_NO") == "" ) {
			
			alert("[ " + grdT_TS_LABORCOST.GetHdrDispName('-3','ENO_NO') + " ]�� �ʼ� �Է»����Դϴ�");
			
			return false;
			
		}

	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

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
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConduct','','../../images/button/btn_ConductOver.gif',1)"><img src="../../images/button/btn_ConductOn.gif" name="imgConduct" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Conduct()"></a>
				&nbsp;&nbsp;
            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">  <img src="../../images/button/btn_SaveOn.gif"     name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDelete','','../../images/button/btn_DeleteOver.gif',1)"><img src="../../images/button/btn_DeleteOn.gif" name="imgDelete" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Delete()"></a>
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
                                <col width="70"></col>
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش���</td>
								<td class="padding2423">
                                    <input id="txtPIS_YM" size="7" maxlength="7" onkeypress="javascript:if(event.keyCode==13) cfCheckNumber(); " onkeyup="cfDateHyphen(this);" style="ime-mode:disabled"  onblur="javascript:if(this.value != '' && !cfDateExpr(this.value)) { alert('��¥���Ŀ� �����ʽ��ϴ�.'); this.value='';} ">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YM','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgPIS_YM"  name="imgPIS_YM" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype2','txtPIS_YM','','10','116');"></a>
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

                        <td width="80" align="right" style="padding-right:5px; padding-bottom:2px;">
                            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('btnUPLOAD','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="btnUPLOAD" width="80" height="20" border="0" align="absmiddle" onClick="fnc_FileUpload()"></a>
                        </td>
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
					<object id="grdT_TS_LABORCOST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:520px;">
						<param name="DataID" 				value="dsT_TS_LABORCOST">
						<param name="Editable" 				value="false">
						<param name="DragDropEnable" 		value="true">
						<param name="SortView" 				value="Left">
                        <param name="SuppressOption"    	value="1">							
						<param name="ViewSummary"  			value="1">								
						<param name="Format" 				value="						
							<C> Name='�Ҽ�'				ID=TEAM_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=center, Edit=none, sort=true SumBgColor=#C3D0DB </C>
							<C> Name='����'				ID=JOB_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB </C>
							<C> Name='���'				ID=ENO_NO		HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB </C>
							<C> Name='����'				ID=ENO_NM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55 align=center,	Edit=none, sort=true SumBgColor=#C3D0DB SumText='�Ѱ�'</C>
							<C> Name='�޿�'				ID=SAL_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>							
							<C> Name='����\\�޿�'			ID=RET_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='4��\\����'			ID=INS_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='�߽Ĵ�'				ID=LUN_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='����\\ī��'			ID=WEL_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>							
							<C> Name='����\\ī��'			ID=O7_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='���\\����'			ID=BUS_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='����\\������'		ID=PARK_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='����\\������'		ID=OIL_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C> Name='�հ�'				ID=SUM_AMT		HeadAlign=Center HeadBgColor=#B9D4DC Width=70 align=right,	Edit=none, sort=true SumBgColor=#C3D0DB SumText=@sum</C>

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

