	<!--*************************************************************************
	* @source      : pirg010.jsp												*
	* @description : ����ȭ������ PAGE 											*
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
	* 2007/01/09            ä����            	�����ۼ�										*
	***********************************************************************--*-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%
    Configuration conf = Configuration.getInstance();

    String DIR_PATH = conf.get("framework.file.upload.pds");
%>
<html>
<head>
	<title>����ȭ������(pirg010)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="/css/style.css" rel="stylesheet" type="text/css">
	<link href="/css/general.css" rel="stylesheet" type="text/css">
	<script language=javascript src="/common/common.js"></script>
	<script language=javascript src="/common/input.js"></script>
	<script language=javascript src="/common/mdi_common.js"></script>
	<script language="javascript" src="/common/calendar/calendar.js"></script>

	<!--**************************************************************************************
	*																						 *
    *	�ڹٽ�ũ��Ʈ �Լ� ����κ�  																 *
    *																						 *
    ***************************************************************************************-->

	<script language="javascript">

		var btnList = 'TFFTFTFT';
		var img = null;  // ���� �����ֱ�

		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
       		trFILE_SEARCH.KeyValue = "tr01(O:dsFILE_SEARCH_SV=dsFILE_SEARCH_SV, O:dsFILE_SEARCH_TP=dsFILE_SEARCH_TP)";
			trFILE_SEARCH.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=SHR";
			trFILE_SEARCH.post();
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
            if(!confirm("�����Ͻ� ���� ��θ� �ø��ðڽ��ϱ�?")) {
                return false;
            }
            dsFILE_SEARCH_TP.UseChangeInfo = "false";

			trFILE_UPLOAD.KeyValue = "tr01(I:dsFILE_SEARCH_TP=dsFILE_SEARCH_TP)";
			trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=SAV";
			trFILE_UPLOAD.post();
        }

        /**
         * ������ ���� �ٿ�
         */
        function fnc_Down() {
            var vFILE_NAME  = dsFILE_SEARCH_SV.NameValue(dsFILE_SEARCH_SV.RowPosition,"FILE_NAME");
            var vFILE_URL   = dsFILE_SEARCH_SV.NameValue(dsFILE_SEARCH_SV.RowPosition,"FILE_URL");

            cfDownload(vFILE_NAME, vFILE_URL);
        }

		/********************************************
         * 04. ���� �Լ�								*
         ********************************************/
        function fnc_Delete() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
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
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

		/********************************************
         * 07. �ű� �Լ� 								*
         ********************************************/
        function fnc_AddNew() {
			//�̰��� �ش� �ڵ��� �Է� �ϼ���
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
        	dsFILE_UPLOAD.ClearData();
        	dsFILE_SEARCH_SV.ClearData();
        	dsFILE_SEARCH_TP.ClearData();

            img.setImage("/images/common/none.jpg");
        }

		/********************************************
         * 11. ȭ�� ����(�ݱ�)  						*
         ********************************************/
        function fnc_Exit() {
			if (dsFILE_UPLOAD.IsUpdated)  {
				if (!fnc_ExitQuestion())  return;
			}
			frame = window.external.GetFrame(window);
			frame.CloseFrame();
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
  			//�̰��� �ش� �ڵ��� �Է� �ϼ���
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {
        	img = new Image(document.form1.viewImage);

			cfStyleGrid(form1.grdFILE_SEARCH_TP,0,"false","false");      // Grid Style ����
			cfStyleGrid(form1.grdFILE_SEARCH_SV,0,"false","false");      // Grid Style ����

			// ���� ÷�ο� �����ͼ��� ��� ���� ����.
	        dsFILE_UPLOAD.setDataHeader("FILE_NAME:STRING, FILE_URL:URL");

			fnc_SearchList();
        }


		/********************************************
         * 15. ����Ű ó�� 							*
         ********************************************/
		function fnc_HotKey() {
			fnc_HotKey_Process(btnList, event.keyCode);
		}

		/********************************************
         * 16. Form�� Active �� �� ó�� �� �� 			*
         ********************************************/
		function fnc_FormActive(strID, winstat) {
			//if (winstat == "activate") {fnc_SearchList();}   //Form�� Active �� �� ���� ����ȸ ó��
		}

		/**
		 * ������ ���ε� ���丮�� �̹����� �ѷ��ִ� User Defined Object
		 * - usage : var obj = new Image(�̹����ױ���ID);
		 *               obj.setImage("������ �̹��������� ��ġ�� ���ϸ�");
		 **/
		function Image(imgTag) {
			var imgTag = imgTag;
			var action = "/servlet/JspChannelSVL?cmd=com.shift.gef.generic.cmd.RetrieveGenericImageCMD";
			var imgUrl = "";
			this.setImage = function(img) {
				imgUrl = img;
				imgTag.src = action + "&IMAGE=" +imgUrl;
			}
		}


        /**
         * ���ο� ������ �߰� �Ѵ�.
         */
		function fnc_AddFile() {
            var oFile_url = null;
            var oFile_name = null;

            fcFILE_UPLOAD.Open();

            oFile_url   = fcFILE_UPLOAD.Value;
            oFile_name  = oFile_url.substring(oFile_url.lastIndexOf("\\") + 1, oFile_url.length);

            
            //Ȯ���� Ŭ���ߴ��� ���� ����
            if(fcFILE_UPLOAD.SelectState != true)
                return false;   

            var tmp     = fcFILE_UPLOAD.Value.split(".");
            var length  = tmp.length;
            var ext     = tmp[length-1].toLowerCase();

            if(!(length > 0
                    && (   ext == "jpg"
                        || ext == "gif"
                        || ext == "jpeg"
                        || ext == "bmp"
                        || ext == "png"))) {
                alert("�̹��� ������ ���ϸ� ���ε� �����մϴ�.");
                return;
            }
 
            dsFILE_UPLOAD.Do("FileUploadShareWrite", "TRUE");   /** �����ִ� ���� �б� */

            dsFILE_UPLOAD.AddRow();
            dsFILE_UPLOAD.NameValue(dsFILE_UPLOAD.CountRow, "FILE_URL")  = oFile_url;
            dsFILE_UPLOAD.NameValue(dsFILE_UPLOAD.CountRow, "FILE_NAME") = oFile_name;
            
            
            
            //���� ÷�ο� ���ÿ� ������ ���ε�
            fnc_FileUpload();
		}
        
        /**
         * ������ ������ ��Ͻ�Ų��.
         */
        function fnc_FileUpload() {
            dsFILE_UPLOAD.UseChangeInfo = "false";

            
            //prompt(this,dsFILE_UPLOAD.text);            
            
            trFILE_UPLOAD.KeyValue = "tr01(I:dsFILE_UPLOAD=dsFILE_UPLOAD)";
            trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=ULD";
            
            trFILE_UPLOAD.post();
        }

		/**
         * ÷�ε� ������ ������Ų��.
         */
		function fnc_FileDelete(type) {
            var oDATA_SET;
            
            //����� DATASET ����
            if(type == "temp") {
                oDATA_SET = dsFILE_SEARCH_TP;
            } else {
                oDATA_SET = dsFILE_SEARCH_SV;
            }
        
			if (oDATA_SET.CountRow < 1) {
                alert("���� �� ������ �����ϴ�!");
                return;
            }else{
                var FILE_NAME = oDATA_SET.nameValue(oDATA_SET.RowPosition, "FILE_NAME");
            	var tmpMSG = "�Ʒ� ���� �����Ͻðڽ��ϱ�?\n���ϸ�     = "+FILE_NAME+"\n";

	            if( confirm(tmpMSG) ){
					oDATA_SET.DeleteRow(oDATA_SET.RowPosition);

					// �Ķ���� �߰�
					trFILE_UPLOAD.KeyValue = "tr02(I:dsFILE_SEARCH_SV=dsFILE_SEARCH_SV, I:dsFILE_SEARCH_TP=dsFILE_SEARCH_TP)";
					trFILE_UPLOAD.action = "/servlet/GauceChannelSVL?cmd=hr.pir.g.pirg010.cmd.PIRG010CMD&S_MODE=DEL&FILE_NAME="+FILE_NAME+"&TYPE="+type;
					trFILE_UPLOAD.post();

					img.setImage("/images/common/none.jpg");
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
    | 1. ��ȸ�� DataSet									   |
    | 2. �̸��� ds_ (FILE_SEARCH_CL)			   			   |
    | 3. ���Ǵ� Table List								   |
    +------------------------------------------------------>
	<Object ID="dsFILE_SEARCH_SV" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>
    
	<Object ID="dsFILE_SEARCH_TP" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" 			Value="True">
		<Param Name="UseChangeInfo"		Value="True">
		<Param Name="ViewDeletedRow"	Value="False">
	</Object>

    <!-- ���콺 ���� ������Ʈ -->
    <object id=fcFILE_UPLOAD classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
        <param name="Text"              value='÷������'>
        <param name="Enable"            value="true">
    </object>

    <!-- �����ͼ� ������Ʈ ���� [���� ÷�ο�] -->
    <object id="dsFILE_UPLOAD" classid="clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <param name="Syncload" value="true">
    </object>

	<!-----------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(FILE_SEARCH_CL)		   |
    | 3. ���Ǵ� Table List(FILE_SEARCH_CL)			   |
    +------------------------------------------------------>
    <Object ID ="trFILE_UPLOAD" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>
    
    <Object ID ="trFILE_SEARCH" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
        <Param Name=KeyName     Value="dataid">
    </Object>

 	<!-- ���콺 ���� ������Ʈ -->
	<object id=tb_InputFile classid=CLSID:C722848E-C7EE-4DC6-947E-C2CD49BBA9DE class="root" style="display:none" >
		<param name="Text"			value='FileOpen'>
		<param name="OpenFileName"	value='�� ����'>
		<param name="Enable"		value="true">
	</object>

	<!--**************************************************************************************
    *                                       												 *
    *	Component���� �߻��ϴ� Event ó����														 *
    *                                       												 *
    ***************************************************************************************-->

	<!-----------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����			       |
    +------------------------------------------------------>
	<Script For=dsFILE_UPLOAD Event="OnLoadCompleted(iCount)">

    </Script>

	<Script For=dsFILE_SEARCH_SV Event="OnLoadCompleted(iCount)">

    </Script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsFILE_SEARCH_CL Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<!-----------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� �� 	   |
    +------------------------------------------------------>
	<Script For=dsFILE_SEARCH_CL Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trFILE_UPLOAD event="OnSuccess()">
        dsFILE_SEARCH_TP.UseChangeInfo = "true";
    
		fnc_Clear();
		fnc_SearchList();
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   						   |
    +------------------------------------------------------>
	<script for=trFILE_UPLOAD event="OnFail()">
        alert(trFILE_UPLOAD.ErrorMsg);
    </script>
    
	<script for=trFILE_SEARCH event="OnFail()">
        alert(trFILE_SEARCH.ErrorMsg);
    </script>

	<!-----------------------------------------------------+
    | Grid Ŭ���� �̹��� �̸����� - server							   |
    +------------------------------------------------------>
	<script language="javascript"  for=grdFILE_SEARCH_SV event=OnClick(row,colid)>
	
        //server
        //alert(dsFILE_SEARCH_SV.NameValue(row, "FILE_URL"));
        
		img.setImage(dsFILE_SEARCH_SV.NameValue(row,"FILE_URL"));

        fnc_ShowElement("btnDOWN");
        fnc_HiddenElement("btnSAVE");
        
	</script>

	<!-----------------------------------------------------+
    | Grid Ŭ���� �̹��� �̸����� - temp							|
    +------------------------------------------------------>
	<script language="javascript"  for=grdFILE_SEARCH_TP event=OnClick(row,colid)>
	
	    //temp
	    //alert(dsFILE_SEARCH_TP.NameValue(row, "FILE_URL"));
	    
		img.setImage(dsFILE_SEARCH_TP.NameValue(row, "FILE_URL"));

        fnc_ShowElement("btnSAVE");
        fnc_HiddenElement("btnDOWN");
        
	</script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();">
	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="/images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="/images/common/barGreenBg.gif" class="barTitle">����ȭ������</td>
					<td align="right" class="navigator">HOME/�λ����/<font color="#000000">����ȭ������</font></td>
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
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgCancel','','/images/button/btn_CancelOver.gif',1)"><img src="/images/button/btn_CancelOn.gif" name="imgCancel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Clear();"></a>
	            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','/images/button/btn_ExitOver.gif',1)">  <img src="/images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

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
	<!-- ��ȸ ���� ���̺� �� -->

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="800" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<b>Temp</b><br>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','/images/button/FileAddOver.gif',1)"><img src="/images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_AddFile()"></a>
			            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgRemove','','/images/button/btn_DeleteOver.gif',1)"><img src="/images/button/btn_DeleteOn.gif" name="imgRemove" width="60" height="20" border="0" align="absmiddle" onClick="fnc_FileDelete('temp')"></a>
					</td>
					<td>&nbsp;</td>
					<td>
						<b>Server</b><br>
						<input id="txtLOC_SV" size="33" class="input_ReadOnly" readonly value="<%=DIR_PATH %>">
<!--
    ������ �̹��� ���� ��ư ���Ŀ� ���
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','/images/button/FileDelOver.gif',1)"><img src="/images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete('server')"></a>
-->
					</td>
				</tr>
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id=grdFILE_SEARCH_TP classid=CLSID:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B style="width:300px;height:390px;">
    					<param name="DataID"		value='dsFILE_SEARCH_TP'>
    					<param name="ColSelect"		value='true'>
    					<param name="Format"		value='
    						<C> id="{curow}"		width=30	name="NO"		align=center	Edit=none	 value="{String(currow)}"</C>
    						<C> id="FILE_NAME"		width=250	name="���ϸ�"		align=left		Edit=none	 LeftMargin="10"</C>
                        '>
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
					<td align="center" width="200px" height="100px">
						<table style="border:1px solid #000000;width:150px;height:200px"  cellspacing="0" cellpadding="0">
						<tr>
						<td>
							<img id="viewImage" src="init" border="0" onerror="this.src='/images/common/none.jpg';" style="width:150px;height:200px;">
						</td>
						</tr>
						</table>
						<br>
						<br>
						<br>
						<input id="btnSAVE" name="btnSAVE" type="button" value="�ø���" style="width:100px" onclick="fnc_Save()">
						<input id="btnDOWN" name="btnDOWN" type="button" value="�����ޱ�" style="width:100px" onclick="fnc_Down()" style="display:none;">
					</td>
					<td>
					<comment id="__NSID__">
					<object id="grdFILE_SEARCH_SV" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:390px;">
						<param name="DataID" value="dsFILE_SEARCH_SV">
						<param name="Editable" value="false">
						<param name="DragDropEnable" value="true">
						<param name="SortView" value="Left">
						<param name="Format" value='
							<C> id="{curow}"		width=30	name="NO"		align=center	Edit=none	 value="{String(currow)}"</C>
							<C> id="FILE_NAME"		width=250	name="���ϸ�"		align=left		Edit=none	 LeftMargin="10"</C>
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
