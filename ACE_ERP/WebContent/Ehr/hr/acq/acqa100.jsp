<!--*************************************************************************
* @source      : acqa100.jsp												*
* @description : Action Plan > Timetable > �󸶳� �� ������ �ΰ���!!!! 	*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/13            �̵���       �����ҿ� ���� �����Ծ ���м���		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>Timetable</title>
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

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	var ENO_NO_SHR = gusrid; 

            //trT_ACT_TIMETABLE.KeyValue = "tr(O:dsT_ACT_TIMETABLE=dsT_ACT_TIMETABLE)";
            //trT_ACT_TIMETABLE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa100.cmd.ACQA100CMD&S_MODE=SHR";
            //trT_ACT_TIMETABLE.post();               

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

        	alert("����ڿ��� ���ǹٶ��ϴ�.");
			//if(!fnc_SaveItemCheck()) return;
            
			//trT_ACT_TIMETABLE_SAV.KeyValue = "tr(I:dsT_ACT_TIMETABLE=dsT_ACT_TIMETABLE)";
			//trT_ACT_TIMETABLE_SAV.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa100.cmd.ACQA100CMD&S_MODE=SAV";
			//trT_ACT_TIMETABLE_SAV.post();

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
			fnc_InputEnable();
			
			dsT_ACT_TIMETABLE.addRow();
			

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

			if (!dsT_ACT_TIMETABLE.IsUpdated ) {
                alert("����� �ڷᰡ �����ϴ�.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}          
            
            if(document.getElementById("txtDOC_TITLE").value == ""){
            	alert("���� ������ �Է��Ͻñ� �ٶ��ϴ�.");
            	document.getElementById("txtDOC_TITLE").focus();
            	return false;
            }

            if(dsT_ACT_TIMETABLE.NameValue(dsT_ACT_TIMETABLE.RowPosition, "FILE_KEY") == ""){
            	alert("������ ÷���Ͻñ� �ٶ��ϴ�.");

            	return false;
            }
            
			return true;

        }

        

        
        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                             �ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    �׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			cfStyleGrid_New(form1.grdT_ACT_TIMETABLE,0,"false","true");      // Grid Style ����		
			
			fnc_SearchList();
			
            fnc_InputDisabled();//�Է¶� disabled			

        }



		
        /***********************************
         *    	�Է¶� Disabledó��  		*
         ***********************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDOC_TITLE").className = "input_ReadOnly";
            document.getElementById("txtDOC_TITLE").readOnly = true;
            document.getElementById("txtDOC_REMARK").className = "input_ReadOnly";
            document.getElementById("txtDOC_REMARK").readOnly = true;

        }

        
        /***********************************
         *    	�Է¶� Enableó��    		*
         ***********************************/     
        function fnc_InputEnable() {
        	        	
            document.getElementById("txtDOC_TITLE").className = "";
            document.getElementById("txtDOC_TITLE").readOnly = false;
            document.getElementById("txtDOC_REMARK").className = "";
            document.getElementById("txtDOC_REMARK").readOnly = false;

        }

        
        /********************************************
         * 				÷������ ó��				*
         ********************************************/
		function fnc_FileUpload() {
        	
            if(dsFILE.CountRow == 1) {
            	
                alert("�� �̻� ÷�������� �߰��Ͻ� �� �����ϴ�.");
                
                return;
                
            }

            var key = dsT_ACT_TIMETABLE.NameValue(dsT_ACT_TIMETABLE.RowPosition, "FILE_KEY");

            if(key == "") {
            	
                key = "acqa100"+(new Date().getTime());
                
                dsT_ACT_TIMETABLE.NameValue(dsT_ACT_TIMETABLE.RowPosition, "FILE_KEY") = key;
                
            }

            if(!fnc_AddFileImg(key)) {
            	
                return;
                
            }
            
		}

        
		/********************************************
         * 				÷������ ����				*
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
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <Object ID="dsT_ACT_TIMETABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    

    



    <!------------------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton			    |
    | 2. �̸��� tr_ + �ֿ� ���̺��(trT_ACT_TIMETABLE)	    |
    | 3. ���Ǵ� Table List(T_ACT_PLAN)	                |
    +------------------------------------------------------->
    <Object ID ="trT_ACT_TIMETABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ACT_TIMETABLE_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    

    
    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-----------------------------------------------------+
    | 			Transaction Successful ó��  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_TIMETABLE event="OnSuccess()">

  
        
    </script>    
    
  
    <!-----------------------------------------------------+
    | 			Transaction Failure ó��  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_TIMETABLE event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>


    <!-----------------------------------------------------+
    | Grid Ŭ���� ������¿� ���� ��ư �� �ʵ� Ȱ��ȭ ó�� |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ACT_TIMETABLE event=OnRowPosChanged(row)>    	
        	
        if(row > 0) {
        	
            //��ϵ� ���ϵ� ��ȸ
            fnc_GetFileList(dsT_ACT_TIMETABLE.NameValue(row, "FILE_KEY"));              

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

            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNew','','../../images/button/btn_AddnewOver.gif',1)">    
            	<img src="../../images/button/btn_AddnewOn.gif"   name="imgNew"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()">
            </a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    
            	<img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()">
            </a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->


<!-- ���� �Է� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>				
					<col width=""></col>
				</colgroup>

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
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)">
							<img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()">
						</a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)">
							<img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()">
						</a>
		
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

<font color="blue" size="2"><b>[Document List]</b></font>

<!-- ���� ��Ȳ ���� ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_TIMETABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
				<param name="DataID"				value="dsT_ACT_TIMETABLE">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
                    <C> id={currow}       	 	width=50   	name='No'	         	align=center 	BgColor='#EEEEEE'</C>
					<C> id='FILE_KEY'			width=100	name='FILE_KEY'			align=center	show=false</C>	
					<C> id='DOC_TITLE'			width=400	name='����'				align=left	    </C>
					<C> id='DOC_REMARK'			width=400	name='����'				align=left 		</C>
					<C> id='IPT_YMD'			width=120	name='�Է�����'			align=center	mask='XXXX-XX-XX'</C>
				
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
<object id="bndT_ACT_TIMETABLE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ACT_TIMETABLE">
	<Param Name="BindInfo", Value='
		<C>Col=DOC_NO     		Ctrl=txtDOC_NO     			Param=value 	</C>  
        <C>Col=DOC_TITLE		Ctrl=txtDOC_TITLE	   		Param=value		</C>
		<C>Col=DOC_REMARK   	Ctrl=txtDOC_REMARK    		Param=value		</C>
    '>
</object>


