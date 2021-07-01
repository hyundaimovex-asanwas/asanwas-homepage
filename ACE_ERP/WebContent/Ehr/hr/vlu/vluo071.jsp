	<!--*************************************************************************
	* @source      : vluo071.jsp												*
	* @description : ������� ���ϰ���(���ε��) PAGE                           *
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
%>

<html>
<head>
<title>������� ���ϰ���</title>
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

	<!-- ÷�� ������ ���� -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->

	<script language="javascript">


        var prmENO_NO   = "<%=prmENO_NO %>";    //���


		/********************************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ 			 	*
         ********************************************/
        function fnc_SearchList() {
        	
            trT_EV_MEETLIST.KeyValue = "shr(O:dsT_EV_MEETLIST=dsT_EV_MEETLIST)";
            
            trT_EV_MEETLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR_FILE&MEET_NO="+prmMEET_NO;
            
            trT_EV_MEETLIST.post();
            
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
			//trT_EV_MEETLIST.KeyValue = "tr01(I:dsT_EV_MEETLIST=dsT_EV_MEETLIST)";
			
			trT_EV_MEETLIST.KeyValue = "tr01(I:SAV=dsT_EV_MEETLIST)";			
			
			trT_EV_MEETLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SAV_FILE";
			
			//prompt(this, dsT_EV_MEETLIST.text);
			
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
			
            if (dsT_EV_MEETLIST.IsUpdated)  {
            	
                if (!fnc_ExitQuestion())  return;
                
            }
            
            opener.parent.fnc_SearchList();
            
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
			
			
            var MEET_GB = document.form1.cmbMEET_GBN.selectedIndex;			
			
            if(MEET_GB == 0){
            	
            	alert("��㱸���� �����Ͻʽÿ�.");
            	
    			return false;            	
            }

            
            //��û�� ������ �� �׸� ���� �ְ�
			if (dsT_EV_MEETLIST.Countrow == 0) {
				
				dsT_EV_MEETLIST.setDataHeader(  "EVL_YYYY:STRING"
                                            +",TEAM_CD:STRING"
                                            +",JOB_CD:STRING"
                                            +",ENO_NO:STRING"
                                            +",MEET_GBN:STRING"                                            
                                            +",FILE_KEY:STRING"
                                            );

			// �� �߰�
			dsT_EV_MEETLIST.AddRow();

            dsT_EV_MEETLIST.NameValue(1, "EVL_YYYY") = "2021";		
            dsT_EV_MEETLIST.NameValue(1, "TEAM_CD") = dsT_EVL_TEAM.NameValue(1,"TEAM_CD");              
            dsT_EV_MEETLIST.NameValue(1, "JOB_CD") = dsT_EVL_TEAM.NameValue(1,"JOB_CD");   
            dsT_EV_MEETLIST.NameValue(1, "ENO_NO") = dsT_EVL_TEAM.NameValue(1,"ENO_NO");
            
			}
            
            
            if(MEET_GB == 1){            
            
            	dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "S"; 
            
            }else if(MEET_GB == 2){
            
            	dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "M";             	
            	
            }else if(MEET_GB == 3){
            	
            	dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "F"; 
            	
            }else if(MEET_GB == 4){
            	
            	dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "G"; 
            	
            }

			//������ ���� Ű�� ����
            //dsT_EV_MEETLIST.NameValue(1, "FILE_KEY") = "vluo071"+(new Date().getTime());
			
			

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
            
            fnc_ConstructCommonCode("dsT_CM_COMMON_Q3", "cmbMEET_GBN","","�� ��");   //������ ���� �޺��ڽ�
            
            document.getElementById("txtIPT_YMD").value = gcurdate;

            
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

            //alert(key);
            
            if(key == undefined) {

				dsT_EV_MEETLIST.setDataHeader(  "EVL_YYYY:STRING"
					                        +",TEAM_CD:STRING"
					                        +",JOB_CD:STRING"
					                        +",ENO_NO:STRING"
					                        +",MEET_GBN:STRING"                                            
					                        +",FILE_KEY:STRING"
					                        );

				// �� �߰�
				dsT_EV_MEETLIST.AddRow();
				
				dsT_EV_MEETLIST.NameValue(1, "EVL_YYYY") = "2021";		
				dsT_EV_MEETLIST.NameValue(1, "TEAM_CD") = dsT_EVL_TEAM.NameValue(1,"TEAM_CD");              
				dsT_EV_MEETLIST.NameValue(1, "JOB_CD") = dsT_EVL_TEAM.NameValue(1,"JOB_CD");   
				dsT_EV_MEETLIST.NameValue(1, "ENO_NO") = dsT_EVL_TEAM.NameValue(1,"ENO_NO");
				
				var MEET_GB = document.form1.cmbMEET_GBN.selectedIndex;
				
				if(MEET_GB == 1){            
				
				dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "S"; 
				
				}else if(MEET_GB == 2){
				
				dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "M";             	
				
				}else if(MEET_GB == 3){
				
				dsT_EV_MEETLIST.NameValue(1, "MEET_GBN") = "F"; 
				
				}
				
				//������ ���� Ű�� ����
				dsT_EV_MEETLIST.NameValue(1, "FILE_KEY") = "vluo071"+(new Date().getTime());            	

				key = dsT_EV_MEETLIST.NameValue(1, "FILE_KEY");
				
            
				
				//alert(key);

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
        
        alert("���������� ��ϵǾ����ϴ�.");
        
        fnc_Exit();
        
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
					<td valign="top" background="../../images/common/barGreenBg.gif" class="barTitle">������� ���ϰ���</td>
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
            	<img src="../../images/button/btn_SaveOn.gif"   name="imgSave" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)" style="cursor:hand;">
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
				<col width="*"></col>
			</colgroup>
		<tr>
			<td align="center" class="blueBold">��㱸��</td>
			<td class="padding2423">
				<select id="cmbMEET_GBN" style="WIDTH: 100%"></select>
    		</td>

			<td align="center" class="blueBold">�ۼ�����</td>
				<td class="padding2423">
				    <input type="text" id="txtIPT_YMD"  style="ime-mode:disabled" size="10" maxlength="10" class="input_ReadOnly" readonly>
				</td>


			<td align="center"></td>

		</tr>

		<tr>
			<td align="center" class="blueBold">�������<br>÷��</td>
			<td class="padding2423" colspan="4">
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

	<!--**************************************************************************************
    *                                       												 *
	*	���ε� ������Ʈ																			 *
    *                                       												 *
    ***************************************************************************************-->

	<!-- T_EV_MEETLIST ���� ���̺� -->
	<object id="bndT_EV_MEETLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
		<Param Name="DataID",   Value="dsT_EV_MEETLIST">
		<Param Name="BindInfo", Value="
			<C>Col=REQ_NO			Ctrl=txtREQ_NO		Param=value</C>
			<C>Col=ENO_NO			Ctrl=txtENO_NO		Param=value</C>
			<C>Col=ENO_NM			Ctrl=txtENO_NM		Param=value</C>
			<C>Col=OCC_CD			Ctrl=hidOCC_CD		Param=value</C>
			<C>Col=DPT_CD			Ctrl=hidDPT_CD		Param=value</C>
			<C>Col=DPT_NM			Ctrl=txtDPT_NM		Param=value</C>
			<C>Col=JOB_CD			Ctrl=hidJOB_CD		Param=value</C>
			<C>Col=JOB_NM			Ctrl=txtJOB_NM		Param=value</C>

		">
	</object>