<!--*************************************************************************
* @source      : acqa001.jsp												*
* @description : Action Plan > ��ü������Ȳ > ��ü������Ȳ					*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/15            �̵���       �����ҿ� ���� �����Ծ ���м���		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>��ü������Ȳ</title>
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

        var obj = new String();
        
		obj.app_cmt = "";



        
        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

            var DOC_GB1 = document.getElementById("txtDOC_GB1_SHR").value;
            var DOC_GB2 = document.getElementById("txtDOC_GB2_SHR").value;
            var DOC_GB3 = document.getElementById("txtDOC_GB3_SHR").value;

            trT_ACT_PLANLIST.KeyValue = "tr(O:dsT_ACT_PLANLIST=dsT_ACT_PLANLIST)";
            trT_ACT_PLANLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa001.cmd.ACQA001CMD&S_MODE=SHR&DOC_GB1="+DOC_GB1+"&DOC_GB2="+DOC_GB2+"&DOC_GB3="+DOC_GB3;
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


            document.getElementById('txtDOC_GB1_SHR').value  = '';
            document.getElementById('txtDOC_NM1_SHR').value  = '';
            document.getElementById('txtDOC_GB2_SHR').value  = '';
            document.getElementById('txtDOC_NM2_SHR').value  = '';
            document.getElementById('txtDOC_GB3_SHR').value  = '';
            document.getElementById('txtDOC_NM3_SHR').value  = '';           	
        	
            fnc_SearchList();

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

			cfStyleGrid_New(form1.grdT_ACT_PLANLIST,0,"false","true");      // Grid Style ����		
					

			
			fnc_SearchList();
			
        }


		


        
		
        /************************************************
         *        	���� ���� �˾�â ó��               *
         ************************************************/
        function fnc_DocNmPopup(gbn) {

            var obj = new String();

            if (gbn == 'GB1') {
            	
                obj.title = '����';
                obj.gbn   = 'DOC1';

                window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                if(obj.comm_cd != '' && obj.comm_nm != '') {
                	
                    document.getElementById('txtDOC_GB1_SHR').value  = obj.comm_cd;
                    document.getElementById('txtDOC_NM1_SHR').value  = obj.comm_nm;
                    document.getElementById('txtDOC_GB2_SHR').value = '';
                    document.getElementById('txtDOC_NM2_SHR').value = '';
                    document.getElementById('txtDOC_GB3_SHR').value = '';
                    document.getElementById('txtDOC_NM3_SHR').value = '';                    
                    
                }

                fnc_SearchList();
                
            }else if (gbn == 'GB2') {
            	
                if (document.getElementById("txtDOC_GB1_SHR").value == "") {
                	
                    alert("�����ڵ带 ���� �Է��Ͻ� �� �˾�â�� �����Ͽ� �ֽʽÿ�.");
                    return;
                    
                }else {
                	
                    obj.title = '����';
                    obj.gbn   = 'DOC2';
                    obj.up_cd  = document.getElementById('txtDOC_GB1_SHR').value;
                    
                    window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                    
                    if(obj.comm_cd != '' && obj.comm_nm != '') {
                    	
                        document.getElementById('txtDOC_GB2_SHR').value  = obj.comm_cd;
                        document.getElementById('txtDOC_NM2_SHR').value  = obj.comm_nm;
                        document.getElementById('txtDOC_GB3_SHR').value = '';
                        document.getElementById('txtDOC_NM3_SHR').value = '';                    
                        
                    }                    
                    
                }
                
                fnc_SearchList();
                
            }else if (gbn == 'GB3') {
            	
                if (document.getElementById("txtDOC_GB1_SHR").value == "" || document.getElementById("txtDOC_GB2_SHR").value == "") {

	                    alert("�����ڵ带 ���� �Է��Ͻ� �� �˾�â�� �����Ͽ� �ֽʽÿ�.");
	                    return;

                }else {
                	
                    obj.title = '����';
                    obj.gbn   = 'DOC3';
                    obj.up_cd  = document.getElementById('txtDOC_GB2_SHR').value;
                    
                    window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                    
                    if(obj.comm_cd != '' && obj.comm_nm != '') {
                    	
                        document.getElementById('txtDOC_GB3_SHR').value  = obj.comm_cd;
                        document.getElementById('txtDOC_NM3_SHR').value  = obj.comm_nm;
         
                    }       

                }
                
                fnc_SearchList();
                
            }
            
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
  
    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->


    

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>




    <!-----------------------------------------------------+
    | 			Transaction Successful ó��  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_PLANLIST event="OnSuccess()">

        
    </script>    


    <!-----------------------------------------------------+
    | 			Transaction Failure ó��  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_PLANLIST event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>



	
    <!-----------------------------------------------------+
    | 				Grid ���� Ŭ���� 						|
    +------------------------------------------------------>
    <script language=JavaScript for=grdT_ACT_PLANLIST event="OnDblClick(row,colid)">    
    
	    var param = new String();

	    if(row < 1) {
	
	        return;
	
	    } else {

	        // ���� Ȯ��

			var url = "../../hr/acq/acqa002.jsp?REQ_NO=" + dsT_ACT_PLANLIST.NameValue(row,"REQ_NO");

			window.showModalDialog(url, "Modal", "dialogWidth:1100px; dialogHeight:400px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

			fnc_SearchList();
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
		<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
		<td class="paddingTop5" align="right" >
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageClear','','../../images/button/btn_Clear.gif',1)">
				<img src="../../images/button/btn_Clear.gif" name="ImageClear" width="57" height="21" border="0" align="absmiddle" onClick="fnc_Clear()">
			</a>		
		
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageSearch','','../../images/button/btn_SearchOver.gif',1)">
				<img src="../../images/button/btn_SearchOn.gif" name="ImageSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()">
			</a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="50"></col>
				<col width="100"></col>
				<col width="50"></col>
				<col width="100"></col>
				<col width="50"></col>
				<col width="100"></col>				
				<col width="*"></col>
			</colgroup>
			<tr>
			
                    <td align="center" class="blueBold">��з�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB1_SHR" style="width:10%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM1_SHR" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB1','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB1" name="ImgDOC_GB1" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB1');"></a>
                    </td>

                    <td align="center" class="blueBold">�ߺз�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB2_SHR" style="width:10%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM2_SHR" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB2','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB2" name="ImgDOC_GB2" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB2');"></a>
                    </td>
                    
                    <td align="center" class="blueBold">���κз�</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB3_SHR" style="width:15%;ime-mode:inactive" maxlength="4"> 
                        <input id="txtDOC_NM3_SHR" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB3','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB3" name="ImgDOC_GB3" width="21" height="20" border="0" align="absmiddle" onClick="fnc_DocNmPopup('GB3');"></a>
                    </td>	
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search���̺� �� -->

<br>

<!-- ���� ��Ȳ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_PLANLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
				<param name="DataID"				value="dsT_ACT_PLANLIST">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
                    <C> id={currow}       	 	width=45   	name='No'	         	align=center 	BgColor='#EEEEEE'</C>
					<C> id='FILE_KEY'			width=80	name='FILE_KEY'			align=center	show=false</C>	
					<C> id='DOC_STATUS'			width=50	name='��Ȳ'				align=center 	value={decode(DOC_STATUS,'G','�Ϸ�','Y','������','R','HELP','')} BgColor={decode(DOC_STATUS,'R','#FF0000','Y','#FFF000','G','#1DDB16','')}</C>	                    
					<C> id='DOC_NO'				width=80	name='������ȣ'			align=center	</C>					
					<C> id='DOC_NM1'			width=120	name='��з�'			align=center	suppress=1</C>
					<C> id='DOC_NM2'			width=120	name='�ߺз�'			align=center	suppress=2</C>
                    <C> id='DOC_NM3'			width=120	name='���κз�'			align=left		</C>
					<C> id='DOC_TITLE'			width=200	name='����'				align=left	    </C>
					<C> id='DOC_REMARK'			width=180	name='����'				align=left 		show=false</C>
					<C> id='APP_STATUS'			width=80	name='Ȯ�λ���'			align=center	value={decode(APP_STATUS_CD,'S','����','G','Ȯ����','R','�ݷ�','Y','Ȯ�οϷ�','')}</C>
					<C> id='IPT_YMD'			width=80	name='�Է�����'			align=center	mask='XXXX-XX-XX'</C>
				">
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
    </tr>
</table>


<br>



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


