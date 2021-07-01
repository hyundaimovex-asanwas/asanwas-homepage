<!--
***********************************************************************
* @source      : vluo050.jsp
* @description : ���� ��ǥ���� PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/13      �̵���        �����ۼ�.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>���� ��ǥ����</title>
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
        	
        	
        	dsT_EVL_APPROVAL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo050.cmd.VLUO050CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&TEAM_CD="+TEAM_CD+"&ENO_NO="+ENO_NO+"&STATUS="+document.getElementById("cmbSTATUS").value+"&SEQ="+document.getElementById("cmbSEQ").value;
			dsT_EVL_APPROVAL.Reset();            

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

            if (dsT_EVL_APPROVAL.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_EVL_APPROVAL.GridToExcel("��ü��", '', 225);
        	
        }

        /******************
         * 07. �ű� �Լ�  *
         ******************/

        function fnc_AddNew() {



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
            dsT_EVL_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo050.cmd.VLUO050CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_EVL_TEAM.reset();

            document.getElementById("txtEVL_YYYY").value = year;   
            document.getElementById('txtTEAM_CD').value = dsT_EVL_TEAM.NameValue(1,"TEAM_CD");
            document.getElementById('txtTEAM_NM').value = dsT_EVL_TEAM.NameValue(1,"TEAM_NM");              
            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;

         
    	//�������� ��� ��� �˻� Ȱ��ȭ
    	if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "1990071" && gusrid != "2020008" && gusrid != "2070020"){ 

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

            document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_YYYY").readOnly = true;
			document.getElementById("txtENO_NO").className = "";
	  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtENO_NM").className = "";
	  		document.getElementById("txtENO_NM").readOnly = false;

    	}

			cfStyleGrid_New(form1.grdT_EVL_APPROVAL, 0, "true", "true");    	
    	
    		fnc_SearchList();

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
	<script language=JavaScript for=grdT_EVL_APPROVAL event="OnDblClick(row,colid)">

			curRowPosition = dsT_EVL_APPROVAL.RowPosition;

			if(dsT_EVL_APPROVAL.CountRow < 1) {
				alert("������ �ڷᰡ �����ϴ�.");
				return;
			}

			var url = "../../../Ehr/hr/vlu/vluo101.jsp?ENO_NO=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NO") + "&ENO_NM=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NM") + "&GOAL_SEQ=" + dsT_EVL_APPROVAL.NameValue(row,"GOAL_SEQ");

			window.showModalDialog(url, "Modal", "dialogWidth:1100px; dialogHeight:750px; help:No; resizable:YES; status:No; scroll:Yes; center:Yes;");
            
			fnc_SearchList();

	</script>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_EVL_APPROVAL) |
    | 3. ���Ǵ� Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EVL_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸��� tr_ + �ֿ� ���̺��(T_EVL_APPROVAL) |
    | 3. ���Ǵ� Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_APPROVAL)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_APPROVAL Event="OnLoadCompleted(iCount)">

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
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            &nbsp;&nbsp;
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
                                <col width="200"></col>                                
                                <col width="50"></col>
                                <col width="150"></col>
                                <col width="50"></col>
                                <col width="100"></col>                                                                  
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">�ۼ����&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtEVL_YYYY" name="txtEVL_YYYY" style="ime-mode:disabled" size="7" maxlength="7" readOnly class="input_ReadOnly"  >
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
											<option value="S">����</option>		
											<option value="R">���</option>												
											<option value="Y">�Ϸ�</option>																	
									</select>
								</td>      
								<td align="center" class="searchState">����</td>
								<td>
									<select id="cmbSEQ" style="WIDTH:100" onChange="fnc_SearchList();">
											<option value="" >��ü</option>
											<option value="1">1��</option>		
											<option value="2">2��</option>																											
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
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" width="600" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
                            <object    id="grdT_EVL_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
                                <param name="DataID"                 	value="dsT_EVL_APPROVAL">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="AutoReSizing"           	value="true">
                                <param name="ColSizing"  				value="true">
								<param name="SortView" 					value="right">                                   
                                <param name="RowHeight"   				value="10">
								<param name="TitleHeight" 				value="20">
								<param name="VIEWSUMMARY"          		value=1>							
                                <param name="Format"                 	value="

			                        <G> name='������' 		BgColor='#dae0ee'									                             
			                        <C> id=HTEAM_NM         width=140   	name='�Ҽ�'        align=center Edit=None </C>
			                        <C> id=HJOB_NM          width=90   		name='����'		   align=center Edit=None </C>
			                        <C> id=HENO_NO          width=70   		name='���'        align=center Edit=None </C>
			                        <C> id=HENO_NM          width=100   	name='����'        align=center Edit=None </C>
			                        </G>			                        
			                        <G> name='�����' 		BgColor='#dae0ee'
			                        <C> id=TEAM_NM          width=140   	name='�Ҽ�'        align=center Edit=None </C>
			                        <C> id=JOB_NM          	width=90   		name='����'		   align=center Edit=None </C>			                        
			                        <C> id=ENO_NO          	width=70   		name='���'        align=center Edit=None </C>
			                        <C> id=ENO_NM          	width=100   	name='����'        align=center Edit=None </C>
			                        </G>
			                        <C> id=GOAL_SEQ    		width=70   		name='����'  	   align=center Edit=None </C>			                        
			                        <C> id=STATUS    		width=100   	name='��ǥ���ο���'  align=center Edit=None </C>
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