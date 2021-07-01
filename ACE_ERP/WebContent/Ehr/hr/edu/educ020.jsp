<!--
    ************************************************************************************
    * @Source         : educ020.jsp                                                    *
    * @Description    : �⵵�������̷� PAGE                                            *
    * @Developer Desc :                                                                *
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                                            *
    *-------------+-----------+--------------------------------------------------------+
    * 2007/04/20  |  ���м�   | �����ۼ�                                               *
     *-------------+-----------+--------------------------------------------------------+
    * 2015/05/11  |  ������   | �ҽ������۾�                                          *
    *************************************************************************************
-->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>


<html>

    <head>
    <title>���ǳ⵵�������̷�</title>
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

        //��ư����  : ��ȸ  �ű�  ����  ���  ����  �μ�  ����  �ݱ�
        var btnList = 'T' + 'F' + 'F' + 'T' + 'T' + 'T' + 'F' + 'T';

        var edu_cd      = '';
        var edu_nm      = '';
        var seq_no      = '';
        var eno_no      = '';
        var str_ymd     = '';
        var edu_autho   = '';

        var opener = window.dialogArguments;

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

        	var PIS_YY = document.getElementById("txtYEAR_SHR").value;//�⵵
        	
        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//�н��� ���

            if(PIS_YY == ""){
        		alert("�ش�⵵�� �Է��ϼ���.");
                document.getElementById("txtYEAR_SHR").focus();
                return false;
        	}

        	if(ENO_NO == ""){
        		alert("����� �Է��ϼ���.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("����� �߸��Ǿ����ϴ�.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}


        	trT_CM_EDUCATION.KeyValue = "SVL(O:dsT_CM_EDUCATION_01=dsT_CM_EDUCATION_01, "+
        	                                "O:dsT_CM_EDUCATION_02=dsT_CM_EDUCATION_02, "+
        	                                "O:dsT_ED_LCTRHIST_03=dsT_ED_LCTRHIST_03, "+
        	                                "O:dsT_CM_EDUCATION_04=dsT_CM_EDUCATION_04)";
        	
			trT_CM_EDUCATION.Action = "../../../servlet/GauceChannelSVL?cmd=Ehr.edu.c.educ012.cmd.EDUC012CMD&S_MODE=SHR&PIS_YY="+PIS_YY+"&ENO_NO="+ENO_NO;
			
			trT_CM_EDUCATION.Post();

        }

        /***********************************
         * 02. ��ȸ �Լ�_Item ������ ��ȸ  *
         ***********************************/
        function fnc_SearchItem() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 03. ���� �Լ�  *
         ******************/
        function fnc_Save() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

        	var PIS_YY = document.getElementById("txtYEAR_SHR").value;//�⵵
        	var ENO_NO = document.getElementById("txtENO_NO_SHR").value;//�н��� ���

            if(PIS_YY == ""){
        		alert("�ش�⵵�� �Է��ϼ���.");
                document.getElementById("txtYEAR_SHR").focus();
                return false;
        	}

        	if(ENO_NO == ""){
        		alert("����� �Է��ϼ���.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

        	if(ENO_NO.trim() != "" && document.getElementById("txtENO_NM_SHR").value.trim() == ""){
        		alert("����� �߸��Ǿ����ϴ�.");
                document.getElementById("txtENO_NO_SHR").focus();
                return false;
        	}

            var url = "../../hr/edu/educ020_PV.jsp?eno_no="+ENO_NO+"&str_ymd="+PIS_YY;
            window.open(url,"","width=1050,height=700,left=0,top=0,scrollbars=yes,status=yes,resizable=yes");

        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CM_EDUCATION_01.CountRow < 1 && dsT_CM_EDUCATION_02.CountRow < 1 && dsT_ED_LCTRHIST_03.CountRow < 1 && dsT_CM_EDUCATION_04.CountRow < 1) {
            	
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                
                return;
                
            }


            if(dsT_CM_EDUCATION_01.CountRow > 0){
              // form1.grdT_CM_EDUCATION_01.GridToExcel("����������Ȳ", "C:\\educ020.xls", 1+4);
                form1.grdT_CM_EDUCATION_01.SaveExcel("����������Ȳ", true, true, false, "C:\\educ020.xls");
            }
            
            if(dsT_CM_EDUCATION_04.CountRow > 0){
                form1.grdT_CM_EDUCATION_04.GridToExcel("��ܱ����̷�", "C:\\educ020.xls", 1+32);
            }
            if(dsT_ED_LCTRHIST_03.CountRow > 0){
                form1.grdT_ED_LCTRHIST_03.GridToExcel("�系�����̷�",  "C:\\educ020.xls", 1+32);
            }
            if(dsT_CM_EDUCATION_02.CountRow > 0){
                form1.grdT_CM_EDUCATION_02.GridToExcel("�系�����̷�", "C:\\educ020.xls", 1+32);
            }

        }


        /******************
         * 07. �ű� �Լ�  *
         ******************/
        function fnc_AddNew() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /******************
         * 08. �߰� �Լ�  *
         ******************/
        function fnc_Append() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

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

            dsT_CM_EDUCATION_01.ClearData();
            dsT_CM_EDUCATION_02.ClearData();
            dsT_ED_LCTRHIST_03.ClearData();
            dsT_CM_EDUCATION_04.ClearData();

            document.getElementById("txtYEAR_SHR").focus();


        }

        /******************************
         * 11. �˻� ���� ��ȿ�� �˻�  *
         ******************************/
        function fnc_SearchItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /*************************
         * 12. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

            //�̰��� �ش� �ڵ��� �Է� �ϼ���

        }

        /********************************************
         * 13. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

   			cfStyleGrid_New(form1.grdT_CM_EDUCATION_01,0,"false","false");      // Grid Style ����
   			
			form1.grdT_CM_EDUCATION_01.HiddenHScroll  = true;
			form1.grdT_CM_EDUCATION_01.HiddenVScroll  = true;
			form1.grdT_CM_EDUCATION_01.DisableNoHScroll = false;
			form1.grdT_CM_EDUCATION_01.DisableNoVScroll = false;

			cfStyleGrid_New(form1.grdT_CM_EDUCATION_02,0,"false","false");      // Grid Style ����
			cfStyleGrid_New(form1.grdT_ED_LCTRHIST_03,0,"false","false");      // Grid Style ����
			cfStyleGrid_New(form1.grdT_CM_EDUCATION_04,0,"false","false");      // Grid Style ����


            document.getElementById("txtYEAR_SHR").value = gcurdate.substr(0,4);
            document.getElementById("txtYEAR_SHR").focus();


            if (opener != null){
            	
                document.getElementById("txtENO_NO_SHR").value = opener.eno_no;
                document.getElementById("txtENO_NM_SHR").value = opener.eno_nm;
                
            } else {
            	
                document.getElementById("txtENO_NO_SHR").value = gusrid;
                document.getElementById("txtENO_NM_SHR").value = gusrnm;
                
            }
            
            //������ ����
        	if(gusrid != "6060002" && gusrid != "6070001"  && gusrid != "2030007" && gusrid != "2070020" && gusrid != "2180001" ){ 
        		
        		 //�����ڰ� �ƴϸ� �ٸ� ������� ��ȸ�� ���� �ʰ� 
        		 fnc_ChangeStateElement(false, "txtENO_NO_SHR");
                 fnc_ChangeStateElement(false, "txtENO_NM_SHR");
                 fnc_ChangeStateElement(false, "ImgEnoNoShr");
                 
                 //�ҼӺμ�������̰ų� �Ϲݻ������ ��� �ڽ��� �μ������� �˻��� ����
                 document.getElementById("hidEMPL_DPT_CD").value = gdeptcd;
                 
        	}
        		
        }


        /********************************************
         * 14. �����ư Ŭ���� �����ϴ� �Լ�        *
         *******************************************/
        function fnc_Exit() {

           if (opener != null){

                window.close();

            } else {

            	window.close();
                
            }

        }

        /********************
         * 15. ����Ű ó��  *
         *******************/
        function fnc_HotKey() {

            fnc_HotKey_Process(btnList, event.keyCode);
        }


        /********************************************************
         * �� �� ��� ������ �ʿ��� �Լ��� �����ؼ� ����ϼ���  *
         *******************************************************/


    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
    *                                                                                        *
    ***************************************************************************************-->
    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸��� ds_ + �ֿ� ���̺��(T_CM_EMPLIST)   |
    | 3. ���Ǵ� Table List(T_CM_EMPLIST)          |
    +----------------------------------------------->

	<Object ID="dsT_CM_EDUCATION_01" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_02" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_ED_LCTRHIST_03" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>

	<Object ID="dsT_CM_EDUCATION_04" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
		<Param Name="Syncload" Value="True">
		<Param Name="UseChangeInfo" Value="True">
		<Param Name="ViewDeletedRow" Value="False">
	</Object>



    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : trT_CM_EDUCATION                    |
    | 3. Table List : T_CM_EDUCATION                |
    +----------------------------------------------->
    <Object ID ="trT_CM_EDUCATION" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadCompleted(iCount)">
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadCompleted(iCount)">
    </Script>




    <!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

	<Script For=dsT_CM_EDUCATION_01 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_02 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_ED_LCTRHIST_03 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>

	<Script For=dsT_CM_EDUCATION_04 Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>



    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_EMPLIST Event="OnDataError()">

        //Dataset���� Error ó��
        cfErrorMsg(this);

    </Script>

	<!-----------------------------------------------------+
    | Transaction Successful ó��     					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnSuccess()">
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure ó��    	   					   |
    +------------------------------------------------------>
	<script for=trT_CM_EDUCATION event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>
<!-- <body leftmargin="20" topmargin="14" rightmargin="20" bottommargin="15" marginwidth="0" marginheight="0" scroll=auto onkeydown="fnc_HotKey();" onload="fnc_OnLoadProcess();"> -->



<!-- �̸��� ������-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
    <iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
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
			                	<col width="100"></col>
			                    <col width="120"></col>
			                    <col width="90"></col>
			                    <col width=""></col>
			                </colgroup>
                            <tr>
                                <td align="right" class="searchState">�ش�⵵&nbsp;</td>
                                <td class="padding2423">

                                    <table height="19" cellspacing="0" cellpadding="0" width="100%" border="0">
                                        <tr>
                                            <td width="40" rowspan="2" style="padding-left:0px; border-style:none">
                                                <input type="text" id="txtYEAR_SHR" style="ime-mode:disabled" size="5" maxlength= "4"onkeypress="javascript:if(event.keyCode==13) fnc_SearchList(); cfNumberCheck()">
                                            </td>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spinup" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'next');" src="../../images/common/arrowup.gif"></TD>
                                        </tr>
                                        <tr>
                                            <td style="height:9px; padding-left:0px; border-style:none"><img id="img_spindown" style="cursor: hand" onclick="datechange('txtYEAR_SHR', 'yyyy', 'prev');" src="../../images/common/arrowdown.gif"></TD>
                                        </tr>
                                    </table>

                                </td>
                                <td align="right" class="searchState">�����ȣ&nbsp;</td>
                                <td class="padding2423">
                                    <input id="txtENO_NO_SHR" size="9" maxlength= "8"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNm('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <input id="txtENO_NM_SHR" size="9" maxlength= "9"onkeypress="if(event.keyCode==13) fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');" onchange="fnc_GetCommonEnoNo('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNoShr','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNoShr" name="ImgEnoNoShr" width="21" height="20" border="0" align="absmiddle" onclick="fnc_CommonEmpPopup('txtENO_NO_SHR','txtENO_NM_SHR','hidEMPL_DPT_CD');"></a>
                                    <input type="hidden" id="hidEMPL_DPT_CD">
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

	<!-- ���� ��ȸ �׸��� ���̺� ����-->
	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>����������Ȳ</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_01" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:86px;">
						<param name="DataID" value="dsT_CM_EDUCATION_01">
						<param name="Format"				value="
							<G> name='�����հ�'  HeadBgColor='#dae0ee'
								<C> id='JOB_POINT'				width='120'		name='��ǥ����'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_TOT'		width='120'		name='�������'			align='right'	Edit=none</C>
							</G>
							
							<G> name='�系����'  HeadBgColor='#dae0ee'
								<C> id='CPT_PNT_AA1'		width='120'		name='�ʼ�'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB1'		width='120'		name='����'			align='right'	Edit=none</C>
							</G>
							
                            <C> id='CPT_PNT_LCT'            width='120'      name='�系����'     align='right'   Edit=none</C>
                            
							<G> name='��ܱ���'  HeadBgColor='#dae0ee'
								<C> id='CPT_PNT_AA2'		width='120'		name='�ʼ�'			align='right'	Edit=none</C>
								<C> id='CPT_PNT_AB2'		width='120'		name='����'			align='right'	Edit=none</C>
							</G>
							
							<C> id='CPT_PNT_EXP'				width='120'		name='��������'		align='right'	Edit=none</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�系�����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_02" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
						<param name="DataID" value="dsT_CM_EDUCATION_02">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='40'		name='NO'				align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='260'		name='������'			align='left'				Edit=none				</C>
								<C> id='SEQ_NO'		    width='100'		name='����'				align='center'		Edit=none				</C>
								<C> id='LCT_TIME'		width='100'		name='�����ð�'		align='right'			Edit=none				</C>
								<C> id='EDU_YMD'		width='160'		name='��������'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='100'		name='����'				align='center'		Edit=none				</C>
								<C> id='EDU_TAG'		width='100'		name='���'				align='center'		Edit=none				</C>
								<C> id='CPT_PNT'        width='100'		name='����'				align='right'			Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>�系�����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_ED_LCTRHIST_03" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
						<param name="DataID" value="dsT_ED_LCTRHIST_03">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='40'		name='NO'				align='center'		value={String(Currow)}	</C>
								<C> id='LCT_TAG'		width='260'		name='���Ǹ�'			align='left'				Edit=none				</C>
								<C> id='LCT_TIME'		width='70'		name='���ǽð�'		align='right'			Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='EDU_NM'			width='150'		name='������'			align='left'				Edit=none				</C>
								<C> id='SEQ_NO'		    width='100'		name='����'				align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='90'		name='����'				align='center'		Edit=none				</C>
								<C> id='CPT_PNT'		width='100'		name='����'				align='right'			Edit=none				</C>
						">
					</object>
					</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>

	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td class="paddingTop15"><img src="../../images/common/dotGreen.gif" width="10" height="10" align="absmiddle">
	            <strong>��ܱ����̷�</strong></td>
	    </tr>
		<tr>
			<td class="paddingTop3" colspan="2">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
					<comment id="__NSID__">
					<object id="grdT_CM_EDUCATION_04" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:130px;">
						<param name="DataID" value="dsT_CM_EDUCATION_04">
						<param name="Format"				value="
								<C> id='{CUROW}'		width='40'		name='NO'				align='center'		value={String(Currow)}	</C>
								<C> id='EDU_NM'			width='260'		name='������'			align='left'				Edit=none				</C>
								<C> id='LCT_TIME'		width='100'		name='�����ð�'		align='right'			Edit=none				</C>
								<C> id='EDU_YMD'		width='150'		name='��������'		align='center'		Edit=none				</C>
								<C> id='SHAPE_NM'		width='100'		name='����'				align='center'		Edit=none				</C>
								<C> id='INT_NAM'		width='110'		name='�������'		align='left'				Edit=none				</C>
								<C> id='PLACE_NM'		width='100'		name='�������'		align='left'				Edit=none				</C>
								<C> id='CPT_PNT'        width='100'		name='����'				align='right'			Edit=none				</C>
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

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
