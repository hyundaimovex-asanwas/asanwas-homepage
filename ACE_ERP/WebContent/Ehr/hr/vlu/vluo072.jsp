	<!--*************************************************************************
	* @source      : vluo072.jsp												*
	* @description : ������� ���ϰ���(��ȸ��) PAGE                             *
	*****************************************************************************
	* DATE            AUTHOR        DESCRIPTION									*
	*----------------------------------------------------------------------------
    * 2017/02/15           �� �� ��          	        �����ۼ�
	**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<%
    String prmENO_NO    = request.getParameter("ENO_NO");
	String prmMEET_NO   = request.getParameter("MEET_NO");
	String prmMEET_GBN  = request.getParameter("MEET_GBN");	
	String prmEVL_YYYY  = request.getParameter("EVL_YYYY");	
	String prmIPT_YMD   = request.getParameter("IPT_YMD");	
%>

<html>
<head>
<title>������� ������ȸ</title>
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

	<!-- ÷�� ������ ���� -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

	<script language="javascript">


        var prmENO_NO    = "<%=prmENO_NO %>";    //���
        var prmMEET_NO   = "<%=prmMEET_NO %>";    //
        var prmMEET_GBN   = "<%=prmMEET_GBN %>";    // 
        var prmEVL_YYYY   = "<%=prmEVL_YYYY %>";    //        
        var prmIPT_YMD   = "<%=prmIPT_YMD %>";    //
        
		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	
            //��ȸ
            dsT_EV_MEETLIST.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR_FILE&ENO_NO="+prmENO_NO+"&MEET_NO="+prmMEET_NO+"&EVL_YYYY="+prmEVL_YYYY;
            dsT_EV_MEETLIST.reset();        	

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

            dsT_EV_MEETLIST.UseChangeInfo = false;

			// save
			trT_EV_MEETLIST.KeyValue = "tr01(I:dsT_EV_MEETLIST=dsT_EV_MEETLIST)";
			trT_EV_MEETLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SAV_FILE";
			trT_EV_MEETLIST.post();

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

			
			
        }

		/********************************************
         * 10. �ʱ�ȭ �Լ�  							*
         ********************************************/
        function fnc_Clear() {


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
			

			return true;

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�   		*
         ********************************************/
        function fnc_OnLoadProcess() {

        
            //��û�� ������ �������
            document.getElementById("txtENO_NO").value = prmENO_NO;
        	
            //�Ҽ� ��ȸ
            dsT_EVL_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR_TEAM&ENO_NO="+prmENO_NO;
            dsT_EVL_TEAM.reset();

            document.getElementById('txtTEAM_NM').value = dsT_EVL_TEAM.NameValue(1,"TEAM_NM");              
            document.getElementById('txtJOB_NM').value = dsT_EVL_TEAM.NameValue(1,"JOB_NM");  
            document.getElementById("txtENO_NM").value = dsT_EVL_TEAM.NameValue(1,"ENO_NM");            
            
            
            var MEET_GB;
            
			if(prmMEET_GBN == "S"){
				
				MEET_GB = "��ǥ����";
				
			}else if(prmMEET_GBN == "M"){
				
				MEET_GB = "����";
				
			}else if(prmMEET_GBN == "F"){
				
				MEET_GB = "����(1��)";
				
			}else if(prmMEET_GBN == "G"){
				
				MEET_GB = "����(2��)";
				
			}            

            document.getElementById("txtMEET_GBN").value = MEET_GB;
            document.getElementById("txtEVL_YYYY").value = prmEVL_YYYY;            
            document.getElementById("txtIPT_YMD").value = prmIPT_YMD;

            fnc_SearchList();
            
        }




        /********************************************
         * ÷������ ó��								*
         ********************************************/
		function fnc_FileUpload() {
        	
            if(dsFILE.CountRow == 1) {
                alert("������� ������ �ϳ��� ���ε��Ͻñ� �ٶ��ϴ�.");
                return;
            }

            var key = dsT_EV_MEETLIST.NameValue(dsT_EV_MEETLIST.RowPosition, "FILE_KEY");

            
            if(key == "") {
            	
                key = "vluo071"+(new Date().getTime());
                
                dsT_EV_MEETLIST.NameValue(dsT_EV_MEETLIST.RowPosition, "FILE_KEY") = key;
                
            }

            if(!fnc_AddFileImg(key)) {
            	
                return;
                
            }
            
            
		}

		/********************************************
         * ÷������ ����								*
         ********************************************/
		function fnc_FileDelete() {
			
            if(dsFILE.CountRow < 1) {
            	
                alert("������ ������ �������� �ʽ��ϴ�.");
                
                return;
            }

            if( confirm("÷�ε� ������ �����Ͻðڽ��ϱ�?") ){
            	
                dsFILE.DeleteRow(dsFILE.RowPosition);
                
                fnc_DelFile();
                
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
    | 1. ��ȸ �� ����� DataSet							   |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EV_MEETLIST)			   |
    | 3. ���Ǵ� Table List(T_EV_MEETLIST) 				   |
    +------------------------------------------------------>
	<Object ID="dsT_EV_MEETLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>


	<Object ID="dsT_EVL_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<!-----------------------------------------------------+
    | 1. ��ȸ �� ����� Data Transacton						   |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EV_MEETLIST)			       |
    | 3. ���Ǵ� Table List(T_EV_MEETLIST)				       |
    +------------------------------------------------------>
	<Object ID="trT_EV_MEETLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
	</Object>
	


    <!-- ���� �޺��� ���� DataSet -->
    <!-- ��û���� ���� -->
    <jsp:include page="../../common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsT_CM_COMMON_Q3"/>
       <jsp:param name="CODE_GUBUN"    value="Q3"/>
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
	<Script For=dsT_EV_MEETLIST Event="OnLoadCompleted(iCount)">
	
		if (iCount == 0)    {
			
			fnc_Message(document.getElementById("resultMessage"),"MSG_02");
			
			alert("�˻��Ͻ� ������ �ڷᰡ �����ϴ�!");
			
		} else {
			
			// ��ȸ �ڷᰡ 1�� �̻��� �� ó�� �� ���� �ڵ�
			//fnc_Message(document.getElementById("resultMessage"),"MSG_03",dsT_EV_MEETLIST.CountRow);
			
            //fnc_EnableElementAll(oElementList);
            
        }
    </Script>

    <!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó��			   |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_EV_MEETLIST event=OnRowPosChanged(row)>
    
        //�Է� ���ϰ� ����
        //fnc_DisableElementAll(oElementList);

        if(row > 0) {
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_EV_MEETLIST.NameValue(row, "FILE_KEY"));

        }
	</script>


	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����			   |
    +------------------------------------------------------>
	<Script For=dsT_EV_MEETLIST Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

	<Script For=dsT_EV_MEETLIST Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>


	<!-----------------------------------------------------+
    | Transaction Successful ó��     						   |
    +------------------------------------------------------>
	<script for=trT_EV_MEETLIST event="OnSuccess()">
	
        //���� �޼����� �ִ� ���θ� �ľ��� �� �˸�
    </script>
    

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   				       |
    +------------------------------------------------------>
	<script for=trT_EV_MEETLIST event="OnFail()">
        alert(trT_EV_MEETLIST.ErrorMsg);
    </script>
    


	<!-- ���� �׸��� Ŭ���� �ٿ�ε� �ǰ� -->
    <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
    
        if(row > 0) {
        	
            var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
            var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
           
            // ÷�� ������ �����ϴ� ��츸 �����ϰ�~
            if (vFILE_NAME != "" && vFILE_URL != "") {
				cfDownload(vFILE_NAME,vFILE_URL);
            }
        }
        
    </script>

	<!--**************************************************************************************
    *                                       												 *
	*	BODY START																			 *
    *                                       												 *
    ***************************************************************************************-->

<body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onload="fnc_OnLoadProcess();">

	<!-- Ķ���� ������-->
	<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
	</div>

	<!-- form ���� -->
	<form name="form1">

	<!-- Ÿ��Ʋ �� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="25" background="/images/common/barBg.gif">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="23"><img src="../../images/common/barHead.gif" width="23" height="25"></td>
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������� ������ȸ</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<!-- Ÿ��Ʋ �� ���̺� �� -->

	<!-- ��ư ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td height="35" class="paddingTop5" align="right">
	            <img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)" style="cursor:hand;">
            	<!--  <img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)" style="cursor:hand;"> -->
	            <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)" style="cursor:hand;">
			</td>
		</tr>
	</table>
	<!-- ��ư ���̺� �� -->

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

	<!-- ���� �Է� ���̺� ���� -->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td class="paddingTop8">
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="80"></col>
				<col width="80"></col>
				<col width="*"></col>
			</colgroup>
		<tr>
            <td align="center" class="blueBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423">
                <input id="txtENO_NO" name="txtENO_NO" class="input_ReadOnly"  size="10" maxlength= "8" readonly>
            </td>
            <td align="center" class="blueBold">��&nbsp;&nbsp;��</td>
            <td class="padding2423">
                <input id="txtENO_NM" name="txtENO_NM" class="input_ReadOnly"  size="14" maxlength= "14" readonly>
            </td>
			<td align="center" class="blueBold">����</td>
			<td class="padding2423">
				<input id="txtJOB_NM" class="input_ReadOnly" size="10" readonly>
			</td>
			<td align="center" class="blueBold">��</td>
			<td class="padding2423">
				<input id=txtTEAM_NM class="input_ReadOnly" size="15" style="ime-mode:disabled" readonly>
			</td>
		</tr>
		</table>
		</td>
	</tr>
	
	
	<tr>
		<td colspan="8" height = "20" class="paddingTop8"></td>
	</tr>	
	
	
	<tr>
		<td colspan="8" class="paddingTop8"><img src="../../images/specialHr/dotGreen.gif" width="10" height="10" align="absmiddle">������� ÷��</td>
	</tr>


	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse;" bordercolor="#999999" class="table_cream">
			<colgroup>
				<col width="80"></col>
				<col width="100"></col>
				<col width="80"></col>
				<col width="100"></col>	
				<col width="80"></col>
				<col width="100"></col>	
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="blueBold">��㱸��</td>
			<td class="padding2423">
				    <input type="text" id="txtMEET_GBN"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
    		</td>


			<td align="center" class="blueBold">����</td>
				<td class="padding2423">
				    <input type="text" id="txtEVL_YYYY"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
				</td>
				
			<td align="center" class="blueBold">�ۼ�����</td>
				<td class="padding2423">
				    <input type="text" id="txtIPT_YMD"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
				</td>



			<td align="center"></td>

		</tr>

		<tr>
			<td align="center" class="blueBold">�������<br>÷��</td>
			<td class="padding2423" colspan="6">
                <comment id="__NSID__">
                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:60px;">
                    <param name="DataID" 				value="dsFILE">
                    <param name="Editable" 				value="false">
                    <param name="DragDropEnable" 		value="true">
                    <param name="SortView" 				value="Left">
                    <param name=ViewHeader  			value="false">
                    <param name="Format" 				value='
                        <C> id="{CUROW}"    width="30"      name="NO"         align="center"  value={String(Currow)}</C>
                        <C> id=FILE_NAME    width="270"     name="���ϸ�"      align="left"    leftmargin="10"</C>
                    '>
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)"><img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()"></a>
				<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)"><img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()"></a>
			</td>
		</tr>

			</table>
			</td>
		</tr>

	</table>
	<!-- ���� �Է� ���̺� �� -->

	</form>
	<!-- form �� -->

</body>
</html>

