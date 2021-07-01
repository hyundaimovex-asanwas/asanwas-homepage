<!--*************************************************************************
* @source      : acqa091.jsp												*
* @description : Action Plan > ��ϰ��� > �󸶳� �� ������ �ΰ���!!!! 	*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/13            �̵���       �����ҿ� ���� �����Ծ ���м���		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<%
    String REQ_NO = request.getParameter("REQ_NO");         //���
    String Gubun = request.getParameter("GUBUN");

%>

<html>
<head>
<title>Ȯ���� ����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>



	<!-- ÷�� ������ ���� -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- ÷�� ������ ���� -->



    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var obj = new String();
        
		obj.app_cmt = "";

        var dsTemp = window.dialogArguments;

        var status = "";//���� Ȯ�� ����

        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


            trT_ACT_PLANLIST.KeyValue = "tr(O:dsT_ACT_PLANLIST=dsT_ACT_PLANLIST,O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
            trT_ACT_PLANLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa090.cmd.ACQA090CMD&S_MODE=SHR_APP&REQ_NO="+<%=REQ_NO%>;
            trT_ACT_PLANLIST.post();               

        }


        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {


        }


        /***********************************
         * 			03. ���� �Լ�  			*
         ***********************************/
        function fnc_Save() {


        }


        
        /***********************************
         * 			04. ���� �Լ�  			*
         ***********************************/
        function fnc_Delete() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        
        
        /***********************************
         * 			05. �μ� �Լ�  			*
         ***********************************/
        function fnc_Print() {


        }

        
        
        /***********************************
         * 			06. ���� ���� �Լ�  	*
         ***********************************/
        function fnc_ToExcel() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }


        /***********************************
         * 			07. �ű� �Լ�  			*
         ***********************************/
        function fnc_AddNew() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���.

        }

        
        /***********************************
         * 			08. �߰� �Լ� 		 	*
         ***********************************/
        function fnc_Append() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���
			
        }
		
		

        /***********************************
         * 			09. ���� �Լ�  			*
         ***********************************/
        function fnc_Remove() {

			
        }

        
        
        /***********************************
         * 			10. �ʱ�ȭ �Լ�  		*
         ***********************************/
        function fnc_Clear() {


        }

        
        
        /***********************************
         * 			11. ȭ�� ����(�ݱ�) 	*
         ***********************************/
        function fnc_Exit() {


        }
        
        
        

        /***********************************
         * 		12. �˻� ���� ��ȿ�� �˻�  *
         ***********************************/
        function fnc_SearchItemCheck() {

			//�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        
        
        
        
        /***********************************
         * 		13. ���� ��ȿ�� üũ  		*
         ***********************************/
        function fnc_SaveItemCheck() {


        }

        

        
        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style ����
			
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;			
			
			fnc_SearchList();
			
            fnc_InputDisabled();//�Է¶� disabled			
			

        }



        
		/********************
         * 15. Ȯ�� ó��
         *******************/
		function fnc_SubmitApproval(kind) {

            if (!confirm(kind+" ó���� �Ͻðڽ��ϱ�?")) return;

            var app_yn = "Y";    //Ȯ�οϷῩ��

            var Aeno_no = "";   
            
            var APP_STATUS = "";
         
            for(var i= 1; i <= dsT_ACT_APPROVAL.CountRow; i++){

                Aeno_no = dsT_ACT_APPROVAL.NameValue(i,"ENO_NO");   	  //Ȯ����
                
				APP_STATUS = dsT_ACT_APPROVAL.NameValue(i,"APP_STATUS");   //Ȯ�ο���  &&  (app_yn == null)

				if(Aeno_no == gusrid &&  APP_STATUS == "��Ȯ��"){

	                dsT_ACT_APPROVAL.addrow();
	                dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"REQ_NO") = document.getElementById("txtREQ_NO").value;
	                dsT_ACT_APPROVAL.NameValue(dsT_ACT_APPROVAL.RowPosition,"ENO_NO") = Aeno_no;
	                
	    			trT_ACT_APPROVAL_SAV.KeyValue = "tr(I:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
	    			trT_ACT_APPROVAL_SAV.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa090.cmd.ACQA090CMD&S_MODE=SAV_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
	    			//prompt(this, dsT_ACT_APPROVAL.text);
	    			trT_ACT_APPROVAL_SAV.post();	                

					alert("Ȯ�� ó���Ǿ����ϴ�.");
					
		        	window.close();
		        	
				}
				
            }

		}


        /***********************************
         *    	�Է¶� Disabledó��  		*
         ***********************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDOC_GB1").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB1").readOnly = true;
            document.getElementById("txtDOC_GB2").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB2").readOnly = true;
            document.getElementById("txtDOC_GB3").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB3").readOnly = true;
            document.getElementById("txtDOC_TITLE").className = "input_ReadOnly";
            document.getElementById("txtDOC_TITLE").readOnly = true;
            document.getElementById("txtDOC_REMARK").className = "input_ReadOnly";
            document.getElementById("txtDOC_REMARK").readOnly = true;

            document.getElementById("ImgDOC_GB1").style.display = "none";            
            document.getElementById("ImgDOC_GB2").style.display = "none";            
            document.getElementById("ImgDOC_GB3").style.display = "none";

            document.getElementById("cmbDOC_STATUS").className = "input_ReadOnly";        
            document.getElementById("cmbDOC_STATUS").readOnly = true;
        }

    </script>

    </head>




    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <Object ID="dsT_ACT_PLANLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <Object ID="dsT_ACT_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    

    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_ACT_PLANLIST)	    |
    | 3. ���Ǵ� Table List(T_ACT_PLAN)	                |
    +------------------------------------------------------->
    <Object ID ="trT_ACT_PLANLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>


    
    <Object ID ="trT_ACT_APPROVAL_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>    
    
  
    <Object ID ="trT_ACT_APPROVAL_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
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

    <Script For=dsT_ACT_APPROVAL Event="OnLoadCompleted(iCount)">
    
    </Script>


    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>

    <Script For=dsT_ACT_APPROVAL Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

    </Script>
    

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>




    <!-----------------------------------------------------+
    | 			Transaction Successful ó��  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_PLANLIST event="OnSuccess()">

        trT_ACT_APPROVAL_SHR.KeyValue = "tr(O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
        trT_ACT_APPROVAL_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa010.cmd.ACQA010CMD&S_MODE=SHR_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
        trT_ACT_APPROVAL_SHR.post();      
        
    </script>    
    


    <!-----------------------------------------------------+
    | 			Transaction Failure ó��  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_PLANLIST event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>


    <!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó�� |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ACT_PLANLIST event=OnRowPosChanged(row)>
    
        //Ȯ�� ���� Ȯ�� : Ȯ�� �Ϸ� or Ȯ�� �������̸� ���� �Ұ�
        if(dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == "Y" || dsT_ACT_PLANLIST.NameValue(row,"APP_STATUS_CD") == "G" ){
        	
        	fnc_InputDisabled();
       
    	
        }        	
        	
        if(row > 0) {
        	
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_ACT_PLANLIST.NameValue(row, "FILE_KEY"));

        }

	</script>


	<!-----------------------------------------------------+
    | 		grdT_DI_APPROVAL OnClick ó�� - ���� ��ȸ      |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_ACT_APPROVAL.NameValue(Row, "REMARK1") == "�ǰ�" ){
		
		obj =  dsT_ACT_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("./acqa016.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
		
	}

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
  
 
 
 
 
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s22.jsp"  flush="true"/>

<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>


<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop5" align="right" >

    		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgConfirm','','../../images/button/btn_ConfirmOver.gif',1)">
    			<img src="../../images/button/btn_ConfirmOn.gif"    name="imgConfirm"  width="60" height="20" border="0" align="absmiddle" onClick="fnc_SubmitApproval('Ȯ��');">
    		</a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<br>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- ���� �Է� ���̺� ���� -->
			<table width="320" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							
							<tr height="25">
								<td align="center" class="blueBold">������ȣ</td>
								<td class="padding2423">
									<input id="txtDOC_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            
                            <tr height="25">
								<td align="center" class="blueBold">�Ҽ�</td>
								<td class="padding2423">
									<input id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="10" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							
                            <tr height="25">
								<td align="center" class="blueBold">����</td>
								<td class="padding2423">
                                    <input id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="10" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							
							<tr height="25">
								<td align="center" class="blueBold">�ۼ���</td>
								<td class="padding2423">
									<input id="txtENO_NO" size="7" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="7" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							
							<tr height="25">
								<td align="center" class="blueBold">Ȯ�ι�ȣ</td>
								<td class="padding2423">
                                    <input id="txtREQ_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- ���� �Է� ���̺� �� -->
			
        </td>
        <td width="30">&nbsp;&nbsp;</td>
        <td>
        
        	<!-- Ȯ�μ� ���� ���̺� ���� -->
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:660px;height:127px;">
							<param name="DataID"				value="dsT_ACT_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
                    			<C> id={currow}       	width=45   	name='No'	        align=center 	BgColor='#EEEEEE'</C>
								<C> id='ENO_NM'			width=120	name='Ȯ����'		align=center	</C>
								<C> id='JOB_NM'			width=120	name='����'			align=center	</C>
                                <C> id='DPT_NM'			width=150	name='�Ҽ�'			align=center	</C>
								<C> id='APP_STATUS'		width=200	name='Ȯ�λ���'		align=center    </C>

							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- Ȯ�μ� ���� ���̺� �� -->
        </td>
    </tr>
</table>

<br>

<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>					
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="blueBold">��з�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB1" style="width:10%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM1" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB1','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB1" name="ImgDOC_GB1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB1');"></a>
                    </td>

                    <td align="center" class="blueBold">�ߺз�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB2" style="width:10%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM2" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB2','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB2" name="ImgDOC_GB2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB2');"></a>
                    </td>
                    
                    <td align="center" class="blueBold">���κз�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB3" style="width:15%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM3" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB3','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB3" name="ImgDOC_GB3" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB3');"></a>
                    </td>
                    
                    <td align="center" class="blueBold">�����Ȳ</td>
                    <td class="padding2423">
						<select id="cmbDOC_STATUS" style="width:90%" class="input_ReadOnly"  readonly>
		                   <option value="" ></option>
		                   <option value="G">�Ϸ�</option>
		                   <option value="Y">������</option>	
		                   <option value="R">HELP</option>	                
						</select>	
                    </td>                    
                    
                </tr>


				<tr>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423" colspan="7">
						<input id="txtDOC_TITLE" style="width:80%;ime-mode:inactive" size = "100" maxlength="200">
					</td>
				</tr>
				
				
				<tr>
					<td align="center" class="blueBold">����</td>
					<td class="padding2423" colspan="7">
						<input id="txtDOC_REMARK" style="width:80%;ime-mode:inactive" size = "100" maxlength="200">
					</td>
				</tr>				
				
				
				<tr>
					<td align="center" class="blueBold">����÷��</td>
					<td class="padding2423" colspan="7">
		                <comment id="__NSID__">
		                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:25px;">
		                    <param name="DataID" 			value="dsFILE">
		                    <param name="Editable" 			value="false">
		                    <param name="DragDropEnable" 	value="true">
		                    <param name="SortView" 			value="Left">
		                    <param name=ViewHeader  		value="false">
		                    <param name="Format" 			value='
		                        <C> id="{CUROW}"    width="30"      name="NO"         	align="center"  value={String(Currow)}</C>
		                        <C> id=FILE_NAME    width="500"     name="���ϸ�"      	align="left"    leftmargin="10"</C>
		                    '>
		                </object>
		                </comment><script> __ShowEmbedObject(__NSID__); </script>
		                

		
					</td>
				</tr>

			</table>
		</td>
	</tr>
</table>




<!-- ��ȸ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>

				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- ��ȸ ���� ���̺� �� -->



<!-- ���� ��Ȳ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_PLANLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:0px;">
				<param name="DataID"				value="dsT_ACT_PLANLIST">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
                    <C> id={currow}       	 	width=45   	name='No'	         	align=center 	BgColor='#EEEEEE'</C>
					<C> id='FILE_KEY'			width=80	name='FILE_KEY'			align=center	show=false</C>	
					<C> id='DOC_STATUS'			width=50	name='��Ȳ'				align=center 	BgColor={decode(DOC_STATUS,'R','#FF0000','Y','#FFF000','G','#1DDB16','')}</C>	                    
					<C> id='DOC_NO'				width=80	name='������ȣ'			align=center	</C>					
					<C> id='DOC_NM1'			width=100	name='��з�'			align=center	</C>
					<C> id='DOC_NM2'			width=100	name='�ߺз�'			align=center	</C>
                    <C> id='DOC_NM3'			width=130	name='���κз�'			align=left		</C>
					<C> id='DOC_TITLE'			width=150	name='����'				align=left	    </C>
					<C> id='DOC_REMARK'			width=150	name='����'				align=left 		</C>
					<C> id='APP_STATUS'			width=90	name='Ȯ�λ���'			align=center	value={decode(APP_STATUS_CD,'S','����','G','Ȯ����','R','�ݷ�','Y','Ȯ�οϷ�','')}</C>
					<C> id='IPT_YMD'			width=80	name='�Է�����'			align=center	mask='XXXX-XX-XX'</C>
				
				">
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
    </tr>
</table>


</form>
<!-- form �� -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



<!--
**************************************************************
* ���ε� ������Ʈ
**************************************************************
-->
<!-- -->
<object id="bndT_ACT_PLANLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ACT_PLANLIST">
	<Param Name="BindInfo", Value='
        <C>Col=DOC_STATUS     	Ctrl=cmbDOC_STATUS     		Param=value 	</C>
		<C>Col=DOC_NO     		Ctrl=txtDOC_NO     			Param=value 	</C>  
		<C>Col=ENO_NO     		Ctrl=txtENO_NO     			Param=value 	</C> 
		<C>Col=ENO_NM     		Ctrl=txtENO_NM     			Param=value 	</C>  
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     			Param=value 	</C> 	
		<C>Col=DPT_NM     		Ctrl=txtDPT_NM     			Param=value 	</C>  
		<C>Col=JOB_CD     		Ctrl=txtJOB_CD     			Param=value 	</C> 
		<C>Col=JOB_NM     		Ctrl=txtJOB_NM     			Param=value 	</C>  
		<C>Col=REQ_NO     		Ctrl=txtREQ_NO     			Param=value 	</C>  
		<C>Col=DOC_GB1     		Ctrl=txtDOC_GB1     		Param=value 	</C>
		<C>Col=DOC_NM1     		Ctrl=txtDOC_NM1     		Param=value 	</C>
        <C>Col=DOC_GB2     		Ctrl=txtDOC_GB2     		Param=value 	</C>
		<C>Col=DOC_NM2     		Ctrl=txtDOC_NM2     		Param=value 	</C>        
		<C>Col=DOC_GB3			Ctrl=txtDOC_GB3	   			Param=value		</C>
		<C>Col=DOC_NM3     		Ctrl=txtDOC_NM3     		Param=value 	</C>		
        <C>Col=DOC_TITLE		Ctrl=txtDOC_TITLE	   		Param=value		</C>
		<C>Col=DOC_REMARK   	Ctrl=txtDOC_REMARK    		Param=value		</C>


    '>
</object>


