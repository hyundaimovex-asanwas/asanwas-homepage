<!--
***********************************************************************
* @source      : vluo070.jsp
* @description : ������� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/13      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="com.shift.gef.configuration.Configuration" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>�������</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/style_new.css" rel="stylesheet" type="text/css">	
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  �ڹٽ�ũ��Ʈ �Լ� ����κ�  *
    *****************************-->
    <script language="javascript" >

        var year    = "2021";

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {


        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var TEAM_CD = document.getElementById("txtTEAM_CD").value;
            var ENO_NO = document.getElementById("txtENO_NO").value;
        	
        	
        	dsT_EVL_MEETLIST.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&ENO_NO="+ENO_NO+"&STATUS="+document.getElementById("cmbSTATUS").value;
			dsT_EVL_MEETLIST.Reset();            

        }

        
        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {


        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {



        }

        /******************
         * 04. ���� �Լ�  *
         ******************/
        function fnc_Delete() {



        }

        /******************
         * 05. �μ� �Լ�  *
         ******************/
        function fnc_Print() {



        }
 

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {


        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/

        function fnc_AddNew() {

            var ENO_NO = document.getElementById("txtENO_NO").value;       
            
            var url = "../../../Ehr/hr/vlu/vluo071.jsp?ENO_NO="+ENO_NO;
            
            cfWinOpen(url,"�������",1100,400);
			
            fnc_SearchList();  	
			
        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {


        }

        /******************
         * 09. ���� �Լ�  *
         ******************/
        function fnc_Remove() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {


        }


        /************************
         * 11. ȭ�� ����(�ݱ�)  *
         ***********************/
        function fnc_Exit() {


               window.close();


        }

        /******************************
         * 12. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  	*
         *******************************************/
        function fnc_OnLoadProcess() {

            //�Ҽ� ��ȸ
            dsT_EVL_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_EVL_TEAM.reset();

            document.getElementById("txtEVL_YYYY").value = year;   
            document.getElementById('txtTEAM_CD').value = dsT_EVL_TEAM.NameValue(1,"TEAM_CD");
            document.getElementById('txtTEAM_NM').value = dsT_EVL_TEAM.NameValue(1,"TEAM_NM");              
            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;

         
    	//�������� ��� �⵵, ��� �˻� Ȱ��ȭ
    	if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "2070020"){ 

			document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_YYYY").readOnly = true;
	  		
			document.getElementById("txtTEAM_CD").className = "input_ReadOnly";
	  		document.getElementById("txtTEAM_CD").readOnly = true;	  		
			document.getElementById("txtTEAM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtTEAM_NM").readOnly = true;
	  		document.getElementById("ImgTeam").style.display = "none";
	  		
			document.getElementById("txtENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";

		}else{

            document.getElementById("txtEVL_YYYY").className = "";
	  		document.getElementById("txtEVL_YYYY").readOnly = false;
			document.getElementById("txtENO_NO").className = "";
	  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtENO_NM").className = "";
	  		document.getElementById("txtENO_NM").readOnly = false;

    	}

			cfStyleGrid_New(form1.grdT_EVL_MEETLIST, 0, "true", "true");    	
    	
    		fnc_SearchList();

        }


        
		/********************************************
         * ÷������ ó��								*
         ********************************************/
		function fnc_FileUpload(){

			
			dsT_EVL_MEETLIST.AddRow();

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

                trFILE_UPLOAD.KeyValue = "SVL(I:dsFILE_UPLOAD=dsFILE_UPLOAD, O:dsT_EVL_MEETLIST=dsT_EVL_MEETLIST, O:dsRESULT=dsRESULT)";
                trFILE_UPLOAD.action   = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo070.cmd.VLUO070CMD&S_MODE=ULD";
                trFILE_UPLOAD.post();
            }


		}        
        
        
        
        
        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            fnc_SearchList();

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList();
	    }                
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | �׸����� ROW�� ����Ŭ�� �� ó��  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_EVL_MEETLIST event="OnDblClick(row,colid)">

			var MEET_GB;
	
			curRowPosition = dsT_EVL_MEETLIST.RowPosition;

			var url = "../../../Ehr/hr/vlu/vluo072.jsp?ENO_NO=" + dsT_EVL_MEETLIST.NameValue(row,"ENO_NO") + "&MEET_NO=" + dsT_EVL_MEETLIST.NameValue(row,"MEET_NO") + "&MEET_GBN=" + dsT_EVL_MEETLIST.NameValue(row,"MEET_GB") + "&IPT_YMD=" + dsT_EVL_MEETLIST.NameValue(row,"IPT_YMD") + "&EVL_YYYY=" + document.getElementById("txtEVL_YYYY").value;

			cfWinOpen(url,"�������",1100,400);

            fnc_SearchList();  				
			
	</script>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_MEETLIST) |
    | 3. ���Ǵ� Table List(T_EVL_MEETLIST)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_MEETLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EVL_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
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

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EVL_MEETLIST) |
    | 3. ���Ǵ� Table List(T_EVL_MEETLIST)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_MEETLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_MEETLIST)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_MEETLIST Event="OnLoadCompleted(iCount)">

	    if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
	    } else {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
	    }

    </Script>

    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);

        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�

    </Script>






<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- form ���� -->
<form name="form1">



<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
	        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgAddNew','','../../images/button/btn_AddnewOver.gif',1)"><img src="../../images/button/btn_AddnewOn.gif" name="imgAddNew" width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="50"></col>
                                <col width="180"></col>                                
                                <col width="100"></col>
                                <col width="150"></col>
                                <col width="80"></col>
                                <col width="100"></col>                                                                  
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">�ۼ����&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtEVL_YYYY" name="txtEVL_YYYY" style="ime-mode:disabled" size="7" maxlength="7" class="input_ReadOnly"  readOnly>
                               </td>
								<td align="right" class="searchState">��&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtTEAM_CD" name="txtTEAM_CD" size="9"  maxlength= "8"   style="ime-mode:disabled" onChange="fnc_GetCommNm('A4','txtTEAM_CD','txtTEAM_NM');">
					                <input id="txtTEAM_NMR" name="txtTEAM_NM" size="12" maxlength= "14"  >
					                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)">
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgTeam" name="ImgTeam" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtTEAM_CD','txtTEAM_NM','�Ҽ�','DEPT')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
					            </td>	                               
                                <td align="right" class="searchState">����</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO name=txtENO_NO size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENO_NO', 'txtENO_NM'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENO_NO', 'txtENO_NM');">
                                    <input id=txtENO_NM name=txtENO_NM size="8" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO','txtENO_NM')"></a>
                                </td>
								<td align="center" class="searchState">����</td>
								<td>
									<select id="cmbSTATUS" style="WIDTH:100" onChange="fnc_SearchList();">
											<option value="" >��ü</option>
											<option value="S">��ǥ����</option>		
											<option value="F">����(1��)</option>												
											<option value="G">����(2��)</option>	
											<option value="M">����</option>																												
									</select>
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



<!-- ���� ��ȸ �׸��� ���̺� ����-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EVL_MEETLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
                                <param name="DataID"                 	value="dsT_EVL_MEETLIST">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="AutoReSizing"           	value="true">
                                <param name="ColSizing"  				value="true">
								<param name="SortView" 					value="right">                                
                                <param name="RowHeight"   				value="10">
								<param name="TitleHeight" 				value="20">
								<param name="VIEWSUMMARY"          		value=1>							
                                <param name="Format"                 	value="
			                        <C> id=TEAM_NM          width=200   	name='�Ҽ�'        align=center Edit=None </C>
			                        <C> id=JOB_NM          	width=150   	name='����'		   align=center Edit=None </C>			                        
			                        <C> id=ENO_NO          	width=100   	name='���'        align=center Edit=None </C>
			                        <C> id=ENO_NM          	width=100   	name='����'        align=center Edit=None </C>
			                        <C> id=MEET_NO          width=80   		name='����'        align=center Edit=None </C>
			                        <C> id=MEET_GB           width=100   	name='����'        align=center Edit=None show=false</C>				                        
			                        <C> id=MEET_GBN         width=100   	name='����'        align=center Edit=None </C>	  
			                        <C> id=IPT_YMD    		width=200   	name='�ۼ�����'  	  align=center Edit=None </C>
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