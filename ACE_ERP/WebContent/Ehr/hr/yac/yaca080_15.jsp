<!--
    **************************************************
    * @source        : yaca080_14.jsp 				                             *
    * @description   : ���κ������ȸ PAGE.                                     *
****************************************************
* DATE            AUTHOR        DESCRIPTION                                  *
*-----------------------------------------------------------------
* 2015/01/27            �̵���             �����ۼ�                                         *
****************************************************-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>

<jsp:include page="/Ehr/common/include/head.jsp"/>

<title>���κ������ȸ</title>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

		//��ư���� : ��ȸ �ű� ���� ��� ���� �μ� ���� �ݱ�
		var btnList = 'TFFTTFFT';

        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var PIS_YY_SHR = document.getElementById("txtPIS_YY_SHR").value; // ����⵵
			var DPT_CD_SHR = document.getElementById("txtDPT_CD_SHR").value; // �Ҽ�
			var ENO_NO_SHR = document.getElementById("txtENO_NO_SHR").value; // ���

            //�����ͼ� ����
            dsT_CM_PERSON.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca080.cmd.YACA080CMD&S_MODE=SHR_15&PIS_YY_SHR="+PIS_YY_SHR+"&DPT_CD_SHR="+DPT_CD_SHR+"&ENO_NO_SHR="+ENO_NO_SHR;
            dsT_CM_PERSON.Reset();


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

        	//�����ͼ� �ʱ�ȭ 
        	gcds_print.ClearAll();
        	
			var eno_no  = dsT_CM_PERSON.NameValue(dsT_CM_PERSON.RowPosition, "ENO_NO");

        	//1,2pgae
        	gcds_print.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.yac.a.yaca050.cmd.YACA050CMD&S_MODE=YACA050_PRT_15&PIS_YY=2015&ENO_NO="+eno_no;
        	gcds_print.reset();

        	gcrp_print.Preview();
        	
        }

        /***********************
         * 06. ���� ���� �Լ�  *
         ***********************/
        function fnc_ToExcel() {

            if (dsT_CM_PERSON.CountRow < 1) {
                alert("������ ��ȯ�� �ڷᰡ �����ϴ�!");
                return;
            }

            form1.grdT_CM_PERSON.GridToExcel("���κ������ȸ", '', 225);

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

        }

        /********************
         * 10. �ʱ�ȭ �Լ�  *
         ********************/
        function fnc_Clear() {

			fnc_OnLoadProcess();
			dsT_CM_PERSON.ClearData();
			document.getElementById("resultMessage").innerText = ' ';
			//document.getElementById("cmbOCC_CD_SHR").value = ""; // �ٷα��б���
			document.getElementById("txtDPT_CD_SHR").value = ""; // �Ҽ��ڵ�
			document.getElementById("txtDPT_NM_SHR").value = ""; // �ҼӸ�
			document.form1.txtPIS_YY_SHR.focus();

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

        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        	if (!dsT_CM_PERSON.isUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
                return false;
			}
			return true;
        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//ù��° �μ� : �׸����                                        
			//�ι�° �μ� : Row Head ǥ�ÿ���(0:��ǥ��, 15:ǥ��)
			//����° �μ� : �׸�����(false:�б�, true:����)    
			//�׹�° �μ� : sort��� ��뿩��(false:�̻��, right:sort���)
			
			cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","true");
			
            document.getElementById("txtPIS_YY_SHR").value =  '2015';
            
			//���� ��� �����¸� �����°� ����
			var PIS_YY_SHR = (document.getElementById("txtPIS_YY_SHR").value).replace("-", "").replace("-", "");
			
			if(PIS_YY_SHR.trim() == ""){
				document.getElementById("txtPIS_YY_SHR").value = "";
			}
			
			fnc_SearchList();

        }

		/********************
         * 16. ����Ű ó��  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

</script>
</head>

    <!--**************************************************************************************
    *                                                                                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)                *
    *                                                                                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                                          |
    | 2. �̸� : dsT_CM_PERSON                             |
    | 3. Table List : T_CM_PERSON                         |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
        <param name="SubsumExpr"          value="total">        
    </Object>

    <Object ID="gcds_print" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"          Value="True">
    </Object>

   	<!-- ���� �޺��� ���� DataSet -->
    <!-- �ٷα��� -->
    <jsp:include page="/common/gauceDataSet.jsp" flush="true">
       <jsp:param name="DATASET_ID"    value="dsCOMMON_A1"/>
       <jsp:param name="CODE_GUBUN"    value="A1"/>
       <jsp:param name="SYNCLOAD"      value="false"/>
       <jsp:param name="USEFILTER"     value="false"/>
    </jsp:include>

    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton                     |
    | 2. �̸� : trT_CM_PERSON                                    |
    | 3. Table List : T_CM_PERSON                             |
    +----------------------------------------------->
    <Object ID ="trT_CM_PERSON" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="dataid">
    </Object>

    <!--*************************************
    *                                                                   *
    *  Component���� �߻��ϴ� Event ó����       *
    *                                                                   *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����              |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����                     |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
	    cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=trT_CM_PERSON event="OnSuccess()">
   		var iCount = dsT_CM_PERSON.CountRow;
		if (iCount == 0) {
			fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			//alert(dsT_CM_PERSON.ExportData(1, dsT_CM_PERSON.CountRow, true));
            fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
        }
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=trT_CM_PERSON event="OnFail()">
        cfErrorMsg(this);
    </script>

<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- form ���� -->
<form name="form1">


<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
		    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPrint','','../../images/button/btn_PrintOver.gif',1)"><img src="../../images/button/btn_PrintOn.gif" name="imgPrint" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Print()"></a>&nbsp;&nbsp;&nbsp;&nbsp;             
            				
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgExcel','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="ImgExcel" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">    <img src="../../images/button/btn_ExitOn.gif"   name="imgExit"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
		</td>
	</tr>
</table>
<!-- ��ư ���̺� �� -->

<!-- power Search���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="center" class="blueTable">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<colgroup>
								<col width="10"></col>
								<col width="80"></col>
								<col width="140"></col>
								<col width="80"></col>
								<col width="170"></col>
								<col width="80"></col>
								<col width="200"></col>
								<col width=""></col>
							</colgroup>
							<tr>
								<td align="center">&nbsp;</td>
								<td align="center" class="searchState">����⵵</td>
								<td>
									<input id="txtPIS_YY_SHR" size="6" maxlength="4"  onkeypress="cfNumberCheck();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled">
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgPIS_YY_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" name="imgPIS_YY_SHR" width="21" height="20" border="0" align="absmiddle" onclick="calendarBtn('datetype3','txtPIS_YY_SHR','','75','112');"></a>
								</td>
								<td align="center" class="searchState">��&nbsp;&nbsp;&nbsp;��</td>
								<td>
									<input id="txtDPT_CD_SHR" name="txtDPT_CD_SHR" size="6" maxlength="6" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList();"  onChange="fnc_GetCommNm('A4', 'txtDPT_CD_SHR','txtDPT_NM_SHR')">
									<input id="txtDPT_NM_SHR" name="txtDPT_NM_SHR" size="14" class="input_ReadOnly" readonly>
									<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgDPT_CD_SHR','','../../images/button/btn_HelpOver.gif',1)">
										<img src="../../images/button/btn_HelpOn.gif" name="imgDPT_CD_SHR" width="21" height="20" border="0" align="absmiddle" onClick="fnc_commnmPopup('txtDPT_CD_SHR','txtDPT_NM_SHR','�μ�','DEPT')">
									</a>
								</td>
								<td align="center" class="searchState">�����ȣ</td>
								<td >
									<input id="txtENO_NO_SHR" name="txtENO_NO_SHR" size="8" maxlength="8" onkeypress="if(event.keyCode==13) fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');cfNumberCheck();" onchange="fnc_GetEnoNm('txtENO_NO_SHR','txtENO_NM_SHR');fnc_SearchList();" style="ime-mode:disabled">
									<input id="txtENO_NM_SHR" name="txtENO_NM_SHR" size="12" maxlength="12" onkeypress="if(event.keyCode==13) fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');" onchange="fnc_GetEnoNo('txtENO_NM_SHR','txtENO_NO_SHR');fnc_SearchList();">
									<a href="#" onMouseOut="MM_swapImgRestore();" onMouseOver="MM_swapImage('imgENO_NO_SHR','','../../images/button/btn_HelpOver.gif',1)"><img src="../../images/button/btn_HelpOn.gif" id="imgENO_NO_SHR" name="imgENO_NO_SHR" width="21" height="20" border="0" align="absmiddle" onclick="fnc_empl2Popup('txtENO_NO_SHR','txtENO_NM_SHR', '1');fnc_SearchList();"></a>
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
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
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
						<object	id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:550px;">
							<param name="DataID"					value="dsT_CM_PERSON">
							<param name="EdiTABLE"					value="false">
							<param name="DragDropEnable"			value="true">
							<param name="SortView"					value="Left">
							<param name="VIEWSUMMARY"			    value=0>
							<param name="Format"				value="
								<FC> id='{CUROW}'		width=39			name='NO'								align=center		value={String(Currow)}		</FC>
                            	<FC> id='RET_YN'           width=60   align=center    name='����'     Value={Decode(RET_YN,'','����','����')}</FC>
                            	<FC> id='RET_YMD'         width=70   align=center    name='������'      </FC>   								
								<FC> id='JOB_NM'			width=80			name='����'								align=center		</FC>
								<FC> id='ENO_NO'		width=80			name='���'								align=center		</FC>
								<FC> id='ENO_NM'		width=80			name='����'								align=center		SubSumText='�� ��' </FC>
								<C> id='CET_NO'			width=100			name='�ֹι�ȣ'						align=center		</C>						
								<C> id='DPT_NM'			width=100			name='�Ҽ�'								align=left		    </C>						
								<C> id='TEAM_NM'		width=150			name='��'								align=left		    </C>	
								<C> id='SALT_AMTT'		width=100			name='�ѱٷμҵ�'						align=right		</C>
								<C> id='FREE_INCOME'	width=100			name='�����'							align=right		SumText=@sum</C>								
								<C> id='TAX_INCOME'	width=100			name='�������޿�'					align=right		</C>									
								<C> id='MGR_AMT'		width=100			name='�ٷμҵ����'					align=right		SumText=@sum</C>
								<C> id='MNI_AMT'		width=100			name='�����ٷμҵ�'					align=right		BgColor='#99FF99' </C>								
								<C> id='MNI_TOT'			width=100			name='�����ҵ�ݾ�'					align=right		</C>										
								
								<C> id='TAX_AMT'		width=100			name='���⼼��'						align=right		</C>									
								<C> id='TDED_TOT'		width=100			name='���װ�����'						align=right		</C>
							<G> name='��������' 		BgColor='#dae0ee'
								<C> id='DGG_TAX'		width=100			name='�����ҵ漼'						align=right		</C>								
								<C> id='DJM_TAX'			width=100			name='�����ֹμ�'						align=right		</C>	
								<C> id='DGG_DJM'			width=100			name='�Ұ�'								align=right		</C>
							</G>
							<G> name='�ⳳ�μ���' 		BgColor='#dae0ee'							
								<C> id='AGG_TAX'		width=100			name='�ⳳ�μҵ漼'					align=right		</C>								
								<C> id='AJM_TAX'			width=100			name='�ⳳ���ֹμ�'					align=right		</C>	
								<C> id='AGG_AJM'			width=100			name='�Ұ�'								align=right		</C>
							</G>
							<G> name='ȯ�޼���' 		BgColor='#dae0ee'		
								<C> id='DRE_INTX'		width=100			name='ȯ�޼ҵ漼'						align=right		</C>								
								<C> id='DRE_CTTX'		width=100			name='ȯ���ֹμ�'						align=right		</C>	
							</G>							
								<C> id='RET_SUM'		width=100			name='ȯ�޾�'							align=right		BgColor='#FFFF99'</C>	
						  	    <C> id='INS_TAG_NM'		width=100			name='�г�����'							align=center		</C>		
								
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


    <!-----------------------------------------------------------------------------
			R E P O R T   C O M P O N E N T S   D E F I N I T I O N
------------------------------------------------------------------------------>
<object  ID="gcrp_print" CLASSID="CLSID:CC26E2A9-760B-4EA6-8DDF-DB423FD24089" >  
 
	<PARAM NAME="MasterDataID"		VALUE="gcds_print">  
	<PARAM NAME="DetailDataID"		VALUE="gcds_print">
    <param name="PaperSize"         value="A4">
    <param name="Landscape"         value="false">
    <param name="NullRecordFlag"    value="true">
    <param name="PrintSetupDlgFlag" value="true">
    <param name="PreviewZoom"       value="120">
    <param name="Format"            value=" 
    
    <A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='1.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, MasterDataID='gcds_print' 
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2741 ,face='Arial' ,size=10 ,penwidth=1
		<X>left=101 ,top=185 ,right=482 ,bottom=275 ,border=true</X>
	<L> left=64 ,top=159 ,right=66 ,bottom=2696 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��1��)' ,left=1725 ,top=90 ,right=1881 ,bottom=151 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='[���� ��24ȣ ����(1)]  ' ,left=64 ,top=90 ,right=1471 ,bottom=151 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=64 ,top=156 ,right=1886 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<X>left=585 ,top=243 ,right=614 ,bottom=278 ,border=true</X>
	<X>left=585 ,top=193 ,right=614 ,bottom=228 ,border=true</X>
	<T>id='����' ,left=106 ,top=191 ,right=220 ,bottom=230 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=228 ,top=185 ,right=228 ,bottom=275 </L>
	<L> left=64 ,top=672 ,right=1886 ,bottom=672 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='', left=1016, top=915, right=1114, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=873, top=915, right=971, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1381, top=857, right=1479, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1381, top=915, right=1479, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1521, top=857, right=1619, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1521, top=915, right=1619, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAX_INCOME,0,,TAX_INCOME)}', left=630, top=976, right=855, bottom=1021, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1638, top=857, right=1730, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1773, top=857, right=1863, bottom=902, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1638, top=915, right=1730, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1773, top=915, right=1863, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1130, top=915, right=1222, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1257, top=915, right=1355, bottom=960, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAS_NM3', left=1392, top=741, right=1614, bottom=786, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1320, right=855, bottom=1365, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1320, right=1106, bottom=1365, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1320, right=1365, bottom=1365, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1320, right=1614, bottom=1365, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1320, right=1873, bottom=1365, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1265, right=855, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1265, right=1106, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1265, right=1365, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1265, right=1614, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1265, right=1873, bottom=1310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1204, right=855, bottom=1249, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1204, right=1106, bottom=1249, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1204, right=1365, bottom=1249, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1204, right=1614, bottom=1249, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1204, right=1873, bottom=1249, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1148, right=855, bottom=1193, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1148, right=1106, bottom=1193, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1148, right=1365, bottom=1193, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1148, right=1614, bottom=1193, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1148, right=1873, bottom=1193, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=127 ,top=733 ,right=1886 ,bottom=733 </L>
	<L> left=127 ,top=791 ,right=1886 ,bottom=791 </L>
	<L> left=127 ,top=852 ,right=1886 ,bottom=852 </L>
	<L> left=127 ,top=908 ,right=1886 ,bottom=908 </L>
	<L> left=127 ,top=1371 ,right=1886 ,bottom=1371 </L>
	<L> left=127 ,top=1315 ,right=1886 ,bottom=1315 </L>
	<L> left=127 ,top=1257 ,right=1886 ,bottom=1257 </L>
	<L> left=127 ,top=1201 ,right=1886 ,bottom=1201 </L>
	<L> left=127 ,top=1143 ,right=1886 ,bottom=1143 </L>
	<L> left=127 ,top=1082 ,right=1886 ,bottom=1082 </L>
	<L> left=127 ,top=1027 ,right=1886 ,bottom=1027 </L>
	<L> left=127 ,top=968 ,right=1886 ,bottom=968 </L>
	<L> left=124 ,top=672 ,right=124 ,bottom=2516 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='STR', left=624, top=857, right=741, bottom=902, face='Arial Narrow', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAS_NM2', left=1124, top=741, right=1371, bottom=786, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id=' ~' ,left=730 ,top=857 ,right=759 ,bottom=902 ,face='Arial' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='END', left=757, top=857, right=863, bottom=902, face='Arial Narrow', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=64 ,top=1431 ,right=1886 ,bottom=1431 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<C>id='', left=884, top=1439, right=1106, bottom=1484, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='16)-1��������' ,left=1394 ,top=683 ,right=1617 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=868 ,right=124 ,bottom=908 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=915 ,right=124 ,bottom=955 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=960 ,right=124 ,bottom=1000 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='ó' ,left=71 ,top=1003 ,right=124 ,bottom=1042 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=1045 ,right=124 ,bottom=1085 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=1087 ,right=124 ,bottom=1124 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=1132 ,right=124 ,bottom=1169 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=1175 ,right=124 ,bottom=1212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=71 ,top=1220 ,right=124 ,bottom=1257 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ��õ¡��������' ,left=624 ,top=193 ,right=1244 ,bottom=241 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ٷμҵ� ���޸���' ,left=624 ,top=243 ,right=1244 ,bottom=288 ,align='left' ,face='��ü�� ����ü' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1328 ,top=161 ,right=1865 ,bottom=161 </L>
	<T>id='��ȣ' ,left=106 ,top=235 ,right=220 ,bottom=273 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2015 -' ,left=230 ,top=191 ,right=333 ,bottom=270 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HTITLE', left=683, top=310, right=1101, bottom=352, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1328 ,top=161 ,right=1328 ,bottom=405 </L>
	<T>id='���ֱ���' ,left=1331 ,top=164 ,right=1543 ,bottom=198 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1328 ,top=198 ,right=1865 ,bottom=198 </L>
	<T>id='�ܱ��δ��ϼ�������' ,left=1331 ,top=267 ,right=1601 ,bottom=302 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1328 ,top=233 ,right=1865 ,bottom=233 </L>
	<L> left=1328 ,top=265 ,right=1865 ,bottom=265 </L>
	<T>id='����' ,left=1331 ,top=302 ,right=1450 ,bottom=336 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1328 ,top=299 ,right=1865 ,bottom=299 </L>
	<L> left=1331 ,top=333 ,right=1868 ,bottom=333 </L>
	<L> left=1331 ,top=370 ,right=1868 ,bottom=370 </L>
	<L> left=1328 ,top=405 ,right=1865 ,bottom=405 </L>
	<L> left=1865 ,top=161 ,right=1865 ,bottom=405 </L>
	<L> left=64 ,top=410 ,right=1886 ,bottom=410 </L>
	<L> left=1545 ,top=161 ,right=1545 ,bottom=267 </L>
	<L> left=1765 ,top=198 ,right=1765 ,bottom=233 </L>
	<L> left=1453 ,top=198 ,right=1453 ,bottom=233 </L>
	<L> left=1453 ,top=302 ,right=1453 ,bottom=336 </L>
	<L> left=1603 ,top=265 ,right=1603 ,bottom=299 </L>
	<L> left=1765 ,top=299 ,right=1765 ,bottom=333 </L>
	<L> left=249 ,top=410 ,right=249 ,bottom=672 </L>
	<L> left=249 ,top=460 ,right=1886 ,bottom=460 </L>
	<T>id='(1)�� �� �� (�� ȣ)' ,left=254 ,top=415 ,right=540 ,bottom=458 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��)' ,left=627 ,top=415 ,right=918 ,bottom=458 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(2)�� ǥ �� (��     ��)' ,left=1040 ,top=415 ,right=1384 ,bottom=458 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�� �� ��' ,left=1410 ,top=415 ,right=1730 ,bottom=458 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(3)����ڵ�Ϲ�ȣ' ,left=251 ,top=466 ,right=537 ,bottom=508 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='140111-0011714' ,left=1408 ,top=466 ,right=1728 ,bottom=508 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(4)�� �� �� �� �� ȣ' ,left=1037 ,top=466 ,right=1381 ,bottom=508 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='221-81-13834' ,left=627 ,top=466 ,right=918 ,bottom=508 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=249 ,top=511 ,right=1886 ,bottom=511 </L>
	<T>id='(5)�� �� �� (�ּ�)' ,left=254 ,top=516 ,right=540 ,bottom=561 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=64 ,top=564 ,right=1886 ,bottom=564 </L>
	<T>id='(6)����' ,left=254 ,top=569 ,right=540 ,bottom=614 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=249 ,top=616 ,right=1886 ,bottom=616 </L>
	<T>id='(8)�ּ�' ,left=254 ,top=622 ,right=540 ,bottom=667 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NM', left=627, top=569, right=918, bottom=614, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(7)�� �� �� ��  �� ȣ' ,left=1037 ,top=569 ,right=1381 ,bottom=614 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CET_NO', left=1410, top=569, right=1844, bottom=614, align='left' , face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1029 ,top=410 ,right=1029 ,bottom=511 </L>
	<L> left=1400 ,top=410 ,right=1400 ,bottom=511 </L>
	<C>id='ADDRESS_HOME', left=627, top=622, right=1852, bottom=667, align='left', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1400 ,top=564 ,right=1400 ,bottom=616 </L>
	<T>id='¡   ��' ,left=71 ,top=450 ,right=243 ,bottom=495 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ǹ���' ,left=71 ,top=495 ,right=243 ,bottom=540 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ���' ,left=71 ,top=574 ,right=243 ,bottom=661 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=130 ,top=683 ,right=601 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(10)����ڵ�Ϲ�ȣ' ,left=130 ,top=802 ,right=601 ,bottom=847 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(11)�ٹ��Ⱓ' ,left=130 ,top=860 ,right=601 ,bottom=905 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(12)����Ⱓ' ,left=130 ,top=918 ,right=601 ,bottom=963 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(13)��               ��' ,left=130 ,top=979 ,right=601 ,bottom=1024 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(14)��               ��' ,left=130 ,top=1035 ,right=601 ,bottom=1080 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(15)��   ��   ��   ��' ,left=130 ,top=1093 ,right=601 ,bottom=1135 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(15)-1�ֽĸż����ñ� �������' ,left=130 ,top=1151 ,right=601 ,bottom=1193 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(15)-2�츮�������������' ,left=130 ,top=1209 ,right=601 ,bottom=1251 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(15)-3�ӿ� �����ҵ�ݾ� �ѵ��ʰ���' ,left=130 ,top=1265 ,right=601 ,bottom=1310 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15)-4' ,left=130 ,top=1320 ,right=601 ,bottom=1365 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='16)��' ,left=130 ,top=1378 ,right=601 ,bottom=1423 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=886 ,top=683 ,right=1109 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=1143 ,top=683 ,right=1368 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��  ��' ,left=1635 ,top=683 ,right=1876 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1886 ,top=156 ,right=1886 ,bottom=2693 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=127 ,top=2426 ,right=1886 ,bottom=2426 </L>
	<T>id='(76)��(��)�ٹ���' ,left=230 ,top=2379 ,right=553 ,bottom=2424 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=228 ,top=2373 ,right=1886 ,bottom=2373 </L>
	<L> left=127 ,top=2230 ,right=1886 ,bottom=2230 </L>
	<T>id='�ⳳ��' ,left=130 ,top=2289 ,right=222 ,bottom=2320 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=130 ,top=2320 ,right=220 ,bottom=2352 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(74)��     ��     ��     ��' ,left=127 ,top=2183 ,right=609 ,bottom=2228 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=122 ,top=2178 ,right=1881 ,bottom=2178 </L>
	<L> left=699 ,top=2230 ,right=699 ,bottom=2371 </L>
	<L> left=532 ,top=2233 ,right=532 ,bottom=2373 </L>
	<L> left=64 ,top=2125 ,right=1886 ,bottom=2125 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(75)��(��)�ٹ���' ,left=257 ,top=2249 ,right=511 ,bottom=2283 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(�������׶���' ,left=257 ,top=2286 ,right=511 ,bottom=2320 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='  ���� ����)' ,left=257 ,top=2323 ,right=511 ,bottom=2357 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=2389 ,right=122 ,bottom=2426 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=2334 ,right=122 ,bottom=2371 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=2278 ,right=122 ,bottom=2318 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=2225 ,right=122 ,bottom=2262 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=2172 ,right=122 ,bottom=2212 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(18) ���ܱٷ�' ,left=135 ,top=1442 ,right=434 ,bottom=1487 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1495 ,right=1886 ,bottom=1495 </L>
	<T>id='(18)-1 �߰��ٷμ���' ,left=135 ,top=1505 ,right=434 ,bottom=1550 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1558 ,right=1886 ,bottom=1558 </L>
	<T>id='(18)-2 ��꺸������' ,left=132 ,top=1572 ,right=431 ,bottom=1617 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1625 ,right=1886 ,bottom=1625 </L>
	<T>id='(18)-4 ����������' ,left=135 ,top=1635 ,right=434 ,bottom=1680 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1688 ,right=1886 ,bottom=1688 </L>
	<T>id='(18)-5' ,left=135 ,top=1699 ,right=434 ,bottom=1744 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1752 ,right=1886 ,bottom=1752 </L>
	<T>id='(18)-6' ,left=135 ,top=1762 ,right=434 ,bottom=1804 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=119 ,top=1812 ,right=1879 ,bottom=1812 </L>
	<T>id='~' ,left=135 ,top=1823 ,right=434 ,bottom=1865 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1871 ,right=1886 ,bottom=1871 </L>
	<T>id='(18)-(25)' ,left=135 ,top=1881 ,right=434 ,bottom=1926 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1931 ,right=1886 ,bottom=1931 </L>
	<T>id='(19)���ú�������' ,left=135 ,top=1942 ,right=434 ,bottom=1987 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=1998 ,right=1886 ,bottom=1998 </L>
	<T>id='(20)������ҵ� ��' ,left=132 ,top=2008 ,right=603 ,bottom=2053 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=2061 ,right=1886 ,bottom=2061 </L>
	<T>id='(20)-1����ҵ� ��' ,left=130 ,top=2072 ,right=601 ,bottom=2117 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='M0X' ,left=442 ,top=1442 ,right=611 ,bottom=1487 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='O0X' ,left=442 ,top=1505 ,right=611 ,bottom=1550 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Q0X' ,left=442 ,top=1572 ,right=611 ,bottom=1617 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='H0X' ,left=442 ,top=1635 ,right=611 ,bottom=1680 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='', left=1140, top=1442, right=1365, bottom=1487, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1442, right=1614, bottom=1487, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1505, right=1873, bottom=1550, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1505, right=1614, bottom=1550, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1505, right=1365, bottom=1550, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1505, right=1106, bottom=1550, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1505, right=855, bottom=1550, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1572, right=855, bottom=1617, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1572, right=1106, bottom=1617, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1572, right=1365, bottom=1617, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1572, right=1614, bottom=1617, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1572, right=1873, bottom=1617, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1635, right=855, bottom=1680, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=878, top=1635, right=1103, bottom=1680, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1138, top=1635, right=1363, bottom=1680, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1386, top=1635, right=1611, bottom=1680, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1630, top=1635, right=1871, bottom=1680, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1699, right=855, bottom=1744, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1699, right=1106, bottom=1744, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1699, right=1365, bottom=1744, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1699, right=1614, bottom=1744, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1699, right=1873, bottom=1744, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=630, top=1762, right=855, bottom=1807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=884, top=1762, right=1106, bottom=1807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1140, top=1762, right=1365, bottom=1807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1392, top=1762, right=1614, bottom=1807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='', left=1632, top=1762, right=1873, bottom=1807, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=865 ,top=672 ,right=865 ,bottom=2125 </L>
	<L> left=1122 ,top=672 ,right=1122 ,bottom=2125 </L>
	<L> left=1373 ,top=672 ,right=1373 ,bottom=2125 </L>
	<L> left=1625 ,top=672 ,right=1625 ,bottom=2125 </L>
	<T>id='������ ���� ������ ȭ�������� 10' ,left=627 ,top=516 ,right=1852 ,bottom=561 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=437 ,top=1431 ,right=437 ,bottom=2000 </L>
	<T>id='��' ,left=69 ,top=1550 ,right=122 ,bottom=1590 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1593 ,right=122 ,bottom=1632 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1635 ,right=122 ,bottom=1675 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1696 ,right=122 ,bottom=1736 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1759 ,right=122 ,bottom=1812 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1815 ,right=122 ,bottom=1855 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1857 ,right=122 ,bottom=1897 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1900 ,right=122 ,bottom=1939 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1500 ,right=122 ,bottom=1540 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=1961 ,right=122 ,bottom=2000 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=69 ,top=2003 ,right=122 ,bottom=2043 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=942 ,top=2125 ,right=942 ,bottom=2519 </L>
	<T>id='��          ��' ,left=130 ,top=2130 ,right=931 ,bottom=2175 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ҵ漼' ,left=947 ,top=2130 ,right=1254 ,bottom=2175 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ҵ漼' ,left=1262 ,top=2130 ,right=1569 ,bottom=2175 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����Ư����' ,left=1577 ,top=2130 ,right=1884 ,bottom=2175 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DGG_TAX,0,,DGG_TAX)}', left=947, top=2183, right=1254, bottom=2228, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=699 ,top=2326 ,right=1886 ,bottom=2326 </L>
	<L> left=622 ,top=418 ,right=622 ,bottom=2127 </L>
	<T>id='���������ڵ�' ,left=1553 ,top=204 ,right=1759 ,bottom=233 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1331 ,top=204 ,right=1450 ,bottom=233 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ܱ���' ,left=1331 ,top=235 ,right=1543 ,bottom=265 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ڵ�' ,left=1553 ,top=304 ,right=1762 ,bottom=333 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1545 ,top=302 ,right=1545 ,bottom=407 </L>
	<T>id='�����ֿ���' ,left=1331 ,top=339 ,right=1543 ,bottom=368 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������걸��' ,left=1331 ,top=373 ,right=1543 ,bottom=402 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1029 ,top=566 ,right=1029 ,bottom=616 </L>
	<L> left=64 ,top=2519 ,right=1886 ,bottom=2519 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='���� ��õ¡����(�ٷμҵ�)�� ���� ����(����)�մϴ�.' ,left=122 ,top=2524 ,right=1707 ,bottom=2564 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(77)����Ư�ʼ���' ,left=124 ,top=2429 ,right=606 ,bottom=2474 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(78)��  ��  ¡  ��  ��  ��[(74)-(75)-(76)-(77)]' ,left=127 ,top=2471 ,right=926 ,bottom=2516 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=127 ,top=2469 ,right=1886 ,bottom=2469 </L>
	<L> left=1257 ,top=2125 ,right=1257 ,bottom=2519 </L>
	<L> left=1572 ,top=2125 ,right=1572 ,bottom=2519 </L>
	<L> left=225 ,top=2230 ,right=225 ,bottom=2426 </L>
	<T>id='�ǰ�����:' ,left=98 ,top=296 ,right=254 ,bottom=336 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='ENO_NO', left=336, top=191, right=474, bottom=270, face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����ڨ�/�������2' ,left=1550 ,top=164 ,right=1860 ,bottom=198 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TYPE', left=1553, top=235, right=1860, bottom=265, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��1 / �Ψ�' ,left=1611 ,top=267 ,right=1857 ,bottom=302 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='HOL_YN_1', left=1553, top=339, right=1860, bottom=368, align='left', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��ӱٷΨ� , �ߵ����2' ,left=1553 ,top=370 ,right=1863 ,bottom=405 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��뺸��:' ,left=98 ,top=333 ,right=254 ,bottom=373 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='JAS_NM1', left=870, top=741, right=1119, bottom=786, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(9)��   ��   ó   ��' ,left=130 ,top=741 ,right=601 ,bottom=786 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��(��)' ,left=632 ,top=683 ,right=857 ,bottom=728 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='COMP_NM', left=632, top=741, right=857, bottom=786, face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='TAX_NO', left=632, top=802, right=857, bottom=847 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAO_NO1', left=870, top=802, right=1119, bottom=847 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAO_NO2', left=1124, top=802, right=1371, bottom=847 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAO_NO3', left=1392, top=802, right=1614, bottom=847 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAA_AMT1,0,,JAA_AMT1)}', left=884, top=976, right=1106, bottom=1021, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAA_AMT2,0,,JAA_AMT2)}', left=1138, top=976, right=1360, bottom=1021, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAA_AMT3,0,,JAA_AMT3)}', left=1392, top=976, right=1614, bottom=1021, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAC_AMT1,0,,JAC_AMT1)}', left=884, top=1035, right=1106, bottom=1080, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAC_AMT2,0,,JAC_AMT2)}', left=1138, top=1035, right=1360, bottom=1080, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAC_AMT3,0,,JAC_AMT3)}', left=1392, top=1035, right=1614, bottom=1080, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAX_INCOME,0,,TAX_INCOME)}', left=630, top=1381, right=855, bottom=1426, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAE_AMT1,0,,JAE_AMT1)}', left=881, top=1381, right=1103, bottom=1426, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAE_AMT2,0,,JAE_AMT2)}', left=1140, top=1381, right=1363, bottom=1426, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAE_AMT3,0,,JAE_AMT3)}', left=1392, top=1381, right=1614, bottom=1426, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM,0,,SUM)}', left=1632, top=1381, right=1873, bottom=1426, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAI_AMT1,0,,JAI_AMT1)}', left=884, top=1093, right=1106, bottom=1138, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAI_AMT2,0,,JAI_AMT2)}', left=1138, top=1093, right=1360, bottom=1138, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAI_AMT3,0,,JAI_AMT3)}', left=1392, top=1093, right=1614, bottom=1138, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_JAI_AMT,0,,SUM_JAI_AMT)}', left=1632, top=1093, right=1873, bottom=1138, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SEA_FREE,0,,SEA_FREE)}', left=630, top=2008, right=855, bottom=2053, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAG_AMT3,0,,JAG_AMT3)}', left=1392, top=2008, right=1614, bottom=2053, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAG_AMT2,0,,JAG_AMT2)}', left=1140, top=2008, right=1363, bottom=2053, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAG_AMT1,0,,JAG_AMT1)}', left=881, top=2008, right=1103, bottom=2053, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAO_NO1', left=706, top=2238, right=939, bottom=2278 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='JAO_NO2', left=706, top=2283, right=939, bottom=2323 ,mask='XXX-XX-XXXXX', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DRE_INTX,0,,DRE_INTX)}', left=945, top=2471, right=1251, bottom=2516, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DRE_CTTX,0,,DRE_CTTX)}', left=1259, top=2471, right=1566, bottom=2516, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DRE_DFTX,0,,DRE_DFTX)}', left=1574, top=2471, right=1881, bottom=2516, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CITI_TAX,0,,CITI_TAX)}', left=1259, top=2379, right=1566, bottom=2424, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(INCM_TAX,0,,INCM_TAX)}', left=945, top=2379, right=1251, bottom=2424, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAL_AMT2,0,,JAL_AMT2)}', left=945, top=2283, right=1251, bottom=2328, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAL_AMT1,0,,JAL_AMT1)}', left=945, top=2233, right=1251, bottom=2278, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAN_AMT1,0,,JAN_AMT1)}', left=1257, top=2233, right=1564, bottom=2278, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAN_AMT2,0,,JAN_AMT2)}', left=1259, top=2283, right=1566, bottom=2328, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAN_AMT2,0,,JAN_AMT2)}', left=1574, top=2283, right=1881, bottom=2328, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(JAM_AMT1,0,,JAM_AMT1)}', left=1572, top=2233, right=1879, bottom=2278, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DBW_TAX,0,,DBW_TAX)}', left=1574, top=2183, right=1881, bottom=2228, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DJM_TAX,0,,DJM_TAX)}', left=1259, top=2183, right=1566, bottom=2228, align='right', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_HINU,0,,SUM_HINU)}', left=257, top=296, right=482, bottom=336, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_HINS,0,,SUM_HINS)}', left=257, top=333, right=482, bottom=373, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_JAA_AMT,0,,SUM_JAA_AMT)}', left=1632, top=976, right=1873, bottom=1021, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_JAC_AMT,0,,SUM_JAC_AMT)}', left=1632, top=1035, right=1873, bottom=1080, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_JAG_AMT,0,,SUM_JAG_AMT)}', left=1632, top=2008, right=1873, bottom=2053, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='210��x297��(�Ϲݿ��� 60g/��)' ,left=1241 ,top=2704 ,right=1881 ,bottom=2738 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=64 ,top=2699 ,right=1886 ,bottom=2699 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(���� �Ǵ� ��)' ,left=1519 ,top=2617 ,right=1786 ,bottom=2651 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ƻ�(��)' ,left=1236 ,top=2617 ,right=1466 ,bottom=2651 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='¡��(����)�ǹ���' ,left=796 ,top=2617 ,right=1151 ,bottom=2651 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='TAX_OFFICE', left=413, top=2641, right=487, bottom=2686, align='left', face='����', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='��������  ����' ,left=492 ,top=2643 ,right=773 ,bottom=2686 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='CURDT', left=720, top=2572, right=1130, bottom=2609 ,mask='XXXX��  XX��  XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<I>id='../../images/common/asan_dojang.gif' ,left=1656 ,top=2524 ,right=1831 ,bottom=2699</I>
	<L> left=699 ,top=2278 ,right=1886 ,bottom=2278 </L>
	<T>id='�����' ,left=566 ,top=2249 ,right=667 ,bottom=2283 ,align='left' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���' ,left=566 ,top=2286 ,right=667 ,bottom=2320 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȣ' ,left=566 ,top=2323 ,right=667 ,bottom=2357 ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SEA_FREE,0,,SEA_FREE)}', left=630, top=1439, right=855, bottom=1484, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>


	</R>
	</A>
	
	<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='2.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 MasterDataID='gcds_print' 
	<B>id=Header ,left=0,top=0 ,right=2000 ,bottom=2760 ,face='Arial' ,size=10 ,penwidth=1
		<L> left=45 ,top=2651 ,right=1868 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=45 ,top=159 ,right=45 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<T>id='(��2��)' ,left=1707 ,top=90 ,right=1863 ,bottom=151 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=45 ,top=156 ,right=1868 ,bottom=156 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=1868 ,top=156 ,right=1868 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=106 ,top=156 ,right=106 ,bottom=2651 </L>
	<T>id='��' ,left=56 ,top=1159 ,right=101 ,bottom=1201 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=56 ,top=1275 ,right=101 ,bottom=1312 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=56 ,top=1386 ,right=101 ,bottom=1423 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=56 ,top=1484 ,right=101 ,bottom=1521 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=56 ,top=1606 ,right=101 ,bottom=1643 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1656 ,top=159 ,right=1656 ,bottom=2651 </L>
	<L> left=987 ,top=159 ,right=987 ,bottom=2651 ,penstyle=solid ,penwidth=3 ,pencolor=#000000 </L>
	<L> left=778 ,top=159 ,right=778 ,bottom=2651 </L>
	<T>id='[(16), �ٸ� �ܱ��δ��ϼ��� ����ÿ��� ' ,left=291 ,top=161 ,right=743 ,bottom=201 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id=' ���� �ٷμҵ�)' ,left=291 ,top=198 ,right=743 ,bottom=238 ,align='left' ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=238 ,right=1871 ,bottom=238 </L>
	<T>id='(21)�ѱ޿�' ,left=114 ,top=180 ,right=275 ,bottom=217 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڱ�' ,left=209 ,top=1519 ,right=304 ,bottom=1556 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=209 ,top=1484 ,right=304 ,bottom=1521 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(34)' ,left=209 ,top=1450 ,right=304 ,bottom=1487 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=1077 ,right=987 ,bottom=1077 </L>
	<T>id='��' ,left=161 ,top=1508 ,right=201 ,bottom=1537 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=1471 ,right=201 ,bottom=1500 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=1434 ,right=201 ,bottom=1463 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=1397 ,right=201 ,bottom=1426 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=1360 ,right=201 ,bottom=1389 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=161 ,top=1323 ,right=201 ,bottom=1352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)������ü������' ,left=312 ,top=1032 ,right=640 ,bottom=1069 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=307 ,top=1019 ,right=987 ,bottom=1019 </L>
	<T>id='(��)�縳�б�����������' ,left=312 ,top=974 ,right=640 ,bottom=1011 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=307 ,top=960 ,right=987 ,bottom=960 </L>
	<T>id='(��)���ο���' ,left=312 ,top=915 ,right=640 ,bottom=953 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=307 ,top=905 ,right=987 ,bottom=905 </L>
	<T>id='(��)����������' ,left=312 ,top=857 ,right=640 ,bottom=894 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=209 ,top=1013 ,right=304 ,bottom=1050 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����' ,left=209 ,top=982 ,right=304 ,bottom=1019 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=209 ,top=950 ,right=304 ,bottom=987 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��   ��' ,left=209 ,top=918 ,right=304 ,bottom=955 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(32)' ,left=209 ,top=884 ,right=304 ,bottom=921 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=204 ,top=844 ,right=987 ,bottom=844 </L>
	<T>id='(31)���ο��ݺ�������' ,left=212 ,top=796 ,right=540 ,bottom=833 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=1011 ,right=201 ,bottom=1040 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=982 ,right=201 ,bottom=1011 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=923 ,right=201 ,bottom=953 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=953 ,right=201 ,bottom=982 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=894 ,right=201 ,bottom=923 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=865 ,right=201 ,bottom=894 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=836 ,right=201 ,bottom=865 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(30)�Ѻθ���' ,left=212 ,top=736 ,right=508 ,bottom=773 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=204 ,top=722 ,right=987 ,bottom=722 </L>
	<T>id='(29)��   ��   ��' ,left=212 ,top=675 ,right=508 ,bottom=712 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(28)�� �� �� ' ,left=212 ,top=614 ,right=413 ,bottom=651 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=204 ,top=601 ,right=987 ,bottom=601 </L>
	<T>id='(27)��ο��' ,left=212 ,top=553 ,right=413 ,bottom=590 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=701 ,right=201 ,bottom=728 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=669 ,right=201 ,bottom=699 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=638 ,right=201 ,bottom=667 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=606 ,right=201 ,bottom=635 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=540 ,right=987 ,bottom=540 </L>
	<T>id='(26)�ξ簡��' ,left=212 ,top=492 ,right=413 ,bottom=529 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=204 ,top=476 ,right=987 ,bottom=476 </L>
	<T>id='(25)��   ��   ��' ,left=212 ,top=429 ,right=497 ,bottom=466 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=482 ,right=201 ,bottom=511 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=452 ,right=201 ,bottom=482 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=423 ,right=201 ,bottom=452 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=161 ,top=394 ,right=201 ,bottom=423 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(23)�ٷμҵ�ݾ�' ,left=114 ,top=310 ,right=680 ,bottom=347 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(22)�ٷμҵ����' ,left=114 ,top=251 ,right=680 ,bottom=288 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2064 ,right=153 ,bottom=2101 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2167 ,right=153 ,bottom=2207 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2223 ,right=153 ,bottom=2260 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2299 ,right=153 ,bottom=2336 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2344 ,right=153 ,bottom=2381 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2392 ,right=153 ,bottom=2432 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=114 ,top=2439 ,right=153 ,bottom=2482 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(50)���ռҵ� ����ǥ��' ,left=992 ,top=183 ,right=1471 ,bottom=220 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=204 ,top=415 ,right=987 ,bottom=415 </L>
	<L> left=106 ,top=352 ,right=1871 ,bottom=352 </L>
	<T>id='(51)���⼼��' ,left=995 ,top=280 ,right=1474 ,bottom=318 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=106 ,top=299 ,right=987 ,bottom=299 </L>
	<L> left=1037 ,top=603 ,right=1865 ,bottom=603 </L>
	<T>id='(56)���װ����' ,left=1040 ,top=616 ,right=1519 ,bottom=654 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(55)��������' ,left=1040 ,top=556 ,right=1519 ,bottom=593 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(53)[����Ư�����ѹ�] (54 ����)' ,left=1040 ,top=426 ,right=1519 ,bottom=463 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(52)[�ҵ漼��]' ,left=1040 ,top=368 ,right=1519 ,bottom=405 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1037 ,top=415 ,right=1865 ,bottom=415 </L>
	<T>id='(54)[����Ư�����ѹ�]  ��30��' ,left=1040 ,top=495 ,right=1519 ,bottom=532 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1037 ,top=476 ,right=1865 ,bottom=476 </L>
	<L> left=1037 ,top=542 ,right=1865 ,bottom=542 </L>
	<L> left=204 ,top=661 ,right=1868 ,bottom=661 </L>
	<T>id='��' ,left=992 ,top=550 ,right=1032 ,bottom=579 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=992 ,top=511 ,right=1032 ,bottom=540 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=990 ,top=471 ,right=1029 ,bottom=500 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=990 ,top=431 ,right=1029 ,bottom=460 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(57)�ٷμҵ�' ,left=1040 ,top=675 ,right=1519 ,bottom=712 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1035 ,top=722 ,right=1868 ,bottom=722 </L>
	<L> left=1082 ,top=873 ,right=1082 ,bottom=2289 </L>
	<T>id='(59)���б���ΰ���' ,left=1087 ,top=908 ,right=1360 ,bottom=945 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1035 ,top=870 ,right=1868 ,bottom=870 </L>
	<L> left=1386 ,top=923 ,right=1868 ,bottom=923 </L>
	<L> left=1085 ,top=979 ,right=1868 ,bottom=979 </L>
	<L> left=1386 ,top=1037 ,right=1868 ,bottom=1037 </L>
	<L> left=1085 ,top=1093 ,right=1868 ,bottom=1093 </L>
	<T>id='(60)[�ٷ��������޿�' ,left=1087 ,top=984 ,right=1360 ,bottom=1021 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����]�� ����' ,left=1087 ,top=1019 ,right=1360 ,bottom=1056 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��������' ,left=1087 ,top=1050 ,right=1360 ,bottom=1087 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1386 ,top=1146 ,right=1868 ,bottom=1146 </L>
	<T>id='(61)��������' ,left=1087 ,top=1130 ,right=1360 ,bottom=1167 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1037 ,top=1196 ,right=1865 ,bottom=1196 </L>
	<L> left=1386 ,top=1246 ,right=1868 ,bottom=1246 </L>
	<L> left=1225 ,top=1296 ,right=1871 ,bottom=1296 </L>
	<T>id='(62)�����' ,left=1087 ,top=1270 ,right=1217 ,bottom=1307 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1386 ,top=1347 ,right=1868 ,bottom=1347 </L>
	<L> left=1085 ,top=1400 ,right=1868 ,bottom=1400 </L>
	<L> left=1384 ,top=1458 ,right=1865 ,bottom=1458 </L>
	<T>id='(63)�Ƿ��' ,left=1087 ,top=1445 ,right=1360 ,bottom=1482 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1082 ,top=1519 ,right=1865 ,bottom=1519 </L>
	<L> left=1386 ,top=1574 ,right=1868 ,bottom=1574 </L>
	<T>id='(64)������' ,left=1087 ,top=1553 ,right=1360 ,bottom=1590 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1085 ,top=1630 ,right=1868 ,bottom=1630 </L>
	<L> left=1386 ,top=1685 ,right=1868 ,bottom=1685 </L>
	<L> left=1386 ,top=1794 ,right=1868 ,bottom=1794 </L>
	<L> left=1386 ,top=1908 ,right=1868 ,bottom=1908 </L>
	<L> left=1386 ,top=2021 ,right=1868 ,bottom=2021 </L>
	<L> left=1386 ,top=2127 ,right=1868 ,bottom=2127 </L>
	<T>id='��' ,left=990 ,top=1640 ,right=1029 ,bottom=1683 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=990 ,top=1577 ,right=1029 ,bottom=1617 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=990 ,top=1513 ,right=1029 ,bottom=1550 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=990 ,top=1453 ,right=1029 ,bottom=1490 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1085 ,top=2178 ,right=1868 ,bottom=2178 </L>
	<T>id='��' ,left=1087 ,top=1947 ,right=1127 ,bottom=1987 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1087 ,top=1905 ,right=1127 ,bottom=1942 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1087 ,top=1863 ,right=1127 ,bottom=1900 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(65)' ,left=1087 ,top=1823 ,right=1127 ,bottom=1860 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1132 ,top=1630 ,right=1132 ,bottom=2178 </L>
	<L> left=1085 ,top=2233 ,right=1868 ,bottom=2233 </L>
	<T>id='(67) ǥ�ؼ��װ���' ,left=1090 ,top=2244 ,right=1355 ,bottom=2281 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(66) ��' ,left=1090 ,top=2188 ,right=1355 ,bottom=2225 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1132 ,top=1849 ,right=1871 ,bottom=1849 </L>
	<L> left=1132 ,top=1963 ,right=1871 ,bottom=1963 </L>
	<L> left=1132 ,top=2077 ,right=1871 ,bottom=2077 </L>
	<T>id='�������ݾ�' ,left=1389 ,top=878 ,right=1569 ,bottom=915 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1230 ,top=722 ,right=1230 ,bottom=870 </L>
	<L> left=1230 ,top=773 ,right=1868 ,bottom=773 </L>
	<L> left=1230 ,top=823 ,right=1868 ,bottom=823 </L>
	<T>id='���������    ' ,left=1238 ,top=730 ,right=1434 ,bottom=767 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='6�� ����        ' ,left=1238 ,top=781 ,right=1434 ,bottom=818 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ꡤ�Ծ���   ' ,left=1238 ,top=831 ,right=1434 ,bottom=868 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1154 ,right=1569 ,bottom=1191 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1101 ,right=1569 ,bottom=1138 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1048 ,right=1569 ,bottom=1085 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=990 ,right=1569 ,bottom=1027 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=934 ,right=1569 ,bottom=971 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1204 ,right=1569 ,bottom=1241 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1254 ,right=1569 ,bottom=1291 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1304 ,right=1569 ,bottom=1341 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1355 ,right=1569 ,bottom=1392 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1410 ,right=1569 ,bottom=1447 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1468 ,right=1569 ,bottom=1505 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1527 ,right=1569 ,bottom=1564 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1585 ,right=1569 ,bottom=1622 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1638 ,right=1569 ,bottom=1675 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1696 ,right=1569 ,bottom=1733 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1746 ,right=1569 ,bottom=1783 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1804 ,right=1569 ,bottom=1842 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1860 ,right=1569 ,bottom=1897 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=1918 ,right=1569 ,bottom=1955 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=1974 ,right=1569 ,bottom=2011 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=2032 ,right=1569 ,bottom=2069 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������ݾ�' ,left=1389 ,top=2085 ,right=1569 ,bottom=2122 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���װ�����' ,left=1389 ,top=2135 ,right=1569 ,bottom=2172 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(58)�ڳ�' ,left=1040 ,top=778 ,right=1167 ,bottom=815 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=968 ,right=1080 ,bottom=997 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1008 ,right=1080 ,bottom=1037 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1048 ,right=1080 ,bottom=1077 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1087 ,right=1080 ,bottom=1117 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1225 ,top=1196 ,right=1225 ,bottom=1400 </L>
	<T>id='���强' ,left=1233 ,top=1228 ,right=1341 ,bottom=1265 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���������' ,left=1233 ,top=1312 ,right=1376 ,bottom=1349 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���强' ,left=1233 ,top=1349 ,right=1341 ,bottom=1386 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1249 ,top=1630 ,right=1249 ,bottom=1849 </L>
	<L> left=1249 ,top=1738 ,right=1868 ,bottom=1738 </L>
	<T>id='����' ,left=1259 ,top=1685 ,right=1352 ,bottom=1722 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10����' ,left=1259 ,top=1648 ,right=1352 ,bottom=1685 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ʰ�' ,left=1259 ,top=1794 ,right=1352 ,bottom=1831 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10����' ,left=1259 ,top=1757 ,right=1352 ,bottom=1794 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�' ,left=1138 ,top=1767 ,right=1241 ,bottom=1804 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�ڱ�' ,left=1138 ,top=1725 ,right=1241 ,bottom=1762 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)��ġ' ,left=1138 ,top=1683 ,right=1241 ,bottom=1720 ,align='right' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)������α�' ,left=1138 ,top=1889 ,right=1363 ,bottom=1926 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)�츮��������' ,left=1138 ,top=1969 ,right=1363 ,bottom=2006 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��α�(2015��' ,left=1138 ,top=2003 ,right=1363 ,bottom=2040 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���� ��κ�)' ,left=1138 ,top=2037 ,right=1363 ,bottom=2074 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)������α�' ,left=1138 ,top=2111 ,right=1363 ,bottom=2148 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1384 ,top=873 ,right=1384 ,bottom=2178 </L>
	<L> left=1032 ,top=2289 ,right=1868 ,bottom=2289 </L>
	<T>id='(68)�������հ���' ,left=1040 ,top=2297 ,right=1561 ,bottom=2334 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1032 ,top=2339 ,right=1868 ,bottom=2339 </L>
	<L> left=1032 ,top=2389 ,right=1868 ,bottom=2389 </L>
	<L> left=1032 ,top=2439 ,right=1868 ,bottom=2439 </L>
	<L> left=1032 ,top=2535 ,right=1868 ,bottom=2535 </L>
	<T>id='�������ݾ�' ,left=1389 ,top=2445 ,right=1569 ,bottom=2482 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1386 ,top=2487 ,right=1868 ,bottom=2487 </L>
	<T>id='���װ�����' ,left=1389 ,top=2495 ,right=1569 ,bottom=2532 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(69)�������Ա�' ,left=1040 ,top=2347 ,right=1561 ,bottom=2384 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(70)�ܱ�����' ,left=1040 ,top=2397 ,right=1561 ,bottom=2434 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(71)������' ,left=1040 ,top=2474 ,right=1378 ,bottom=2511 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1384 ,top=2439 ,right=1384 ,bottom=2535 </L>
	<T>id='��' ,left=111 ,top=1643 ,right=151 ,bottom=1685 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=111 ,top=1582 ,right=151 ,bottom=1622 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=111 ,top=1521 ,right=151 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=111 ,top=1461 ,right=151 ,bottom=1498 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=111 ,top=1394 ,right=151 ,bottom=1434 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=111 ,top=1331 ,right=151 ,bottom=1371 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Ư' ,left=1040 ,top=1519 ,right=1080 ,bottom=1558 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1582 ,right=1080 ,bottom=1622 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1648 ,right=1080 ,bottom=1685 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1709 ,right=1080 ,bottom=1746 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1770 ,right=1080 ,bottom=1810 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��' ,left=1040 ,top=1831 ,right=1080 ,bottom=1873 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=783 ,right=987 ,bottom=783 </L>
	<C>id='{decode(SUM,0,,SUM)}', left=783, top=177, right=984, bottom=222, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TTAX_STD,0,,TTAX_STD)}', left=1664, top=172, right=1865, bottom=217, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAX_AMT,0,,TAX_AMT)}', left=1664, top=270, right=1865, bottom=315, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(HGR_DED,0,,HGR_DED)}', left=1664, top=672, right=1865, bottom=717, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AGE_AMT,0,,AGE_AMT)}', left=1664, top=728, right=1865, bottom=773, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AGE_INP,0,,AGE_INP)}', left=1664, top=828, right=1865, bottom=873, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ANN_DED,0,,ANN_DED)}', left=1664, top=1151, right=1865, bottom=1196, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MMA_DED,0,,MMA_DED)}', left=1664, top=1468, right=1865, bottom=1513, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GOV_DED,0,,GOV_DED)}', left=1664, top=1691, right=1865, bottom=1736, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LC23_DED,0,,LC23_DED)}', left=1664, top=2130, right=1865, bottom=2175, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MRENT_AMT,0,,MRENT_AMT)}', left=1664, top=2490, right=1865, bottom=2535, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(NPEN_DED,0,,NPEN_DED)}', left=783, top=791, right=984, bottom=836, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(OTX_DED,0,,OTX_DED)}', left=783, top=730, right=984, bottom=775, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(WDD_AMT,0,,WDD_AMT)}', left=783, top=672, right=984, bottom=717, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TBL_DED,0,,TBL_DED)}', left=783, top=611, right=984, bottom=656, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GOL_AMT,0,,GOL_AMT)}', left=783, top=550, right=984, bottom=595, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GDED_AMT,0,,GDED_AMT)}', left=783, top=487, right=984, bottom=532, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SPSB_AMT,0,,SPSB_AMT)}', left=783, top=426, right=984, bottom=471, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MNI_AMT,0,,MNI_AMT)}', left=783, top=307, right=984, bottom=352, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MGR_AMT,0,,MGR_AMT)}', left=783, top=249, right=984, bottom=294, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(24)��         ��' ,left=212 ,top=368 ,right=497 ,bottom=405 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(BADD_AMT,0,,BADD_AMT)}', left=783, top=362, right=984, bottom=407, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(STA_TOT,0,,STA_TOT)}', left=1664, top=2238, right=1865, bottom=2283, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(NSE_TOT,0,,NSE_TOT)}', left=1664, top=2183, right=1865, bottom=2228, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LC1_DED,0,,LC1_DED)}', left=1664, top=1916, right=1865, bottom=1961, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GOV2_DED,0,,GOV2_DED)}', left=1664, top=1802, right=1865, bottom=1847, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(EDU_DED,0,,EDU_DED)}', left=1664, top=1582, right=1865, bottom=1627, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LIH_DED,0,,LIH_DED)}', left=1664, top=1352, right=1865, bottom=1397, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(MIN_DED,0,,MIN_DED)}', left=1664, top=1249, right=1865, bottom=1294, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(AGE_RCH,0,,AGE_RCH)}', left=1664, top=778, right=1865, bottom=823, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TAX_DED,0,,TAX_DED)}', left=1664, top=614, right=1865, bottom=659, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DFM_CNT,0,,DFM_CNT)}', left=415, top=492, right=545, bottom=529 ,mask='(XX��)', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(GOL_CNT,0,,GOL_CNT)}', left=415, top=553, right=545, bottom=590 ,mask='(XX��)', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(TRB_CNT,0,,TRB_CNT)}', left=415, top=614, right=545, bottom=651 ,mask='(XX��)', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CHI_INP,0,,CHI_INP)}', left=1439, top=831, right=1569, bottom=868 ,mask='(XX��)', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CHI_RCH,0,,CHI_RCH)}', left=1439, top=781, right=1569, bottom=818 ,mask='(XX��)', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(CHI_CNT,0,,CHI_CNT)}', left=1439, top=730, right=1569, bottom=767 ,mask='(XX��)', face='����', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(49)�ҵ���� �����ѵ� �ʰ���' ,left=119 ,top=2606 ,right=632 ,bottom=2646 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INDED_EXC,0,,INDED_EXC)}', left=783, top=2606, right=984, bottom=2646, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(73)��������[(51)-(56)-(72)]' ,left=1003 ,top=2606 ,right=1516 ,bottom=2646 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DGG_TAX,0,,DGG_TAX)}', left=1664, top=2606, right=1865, bottom=2646, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=106 ,top=2601 ,right=1868 ,bottom=2601 </L>
	<T>id='(72)���װ�����' ,left=1040 ,top=2553 ,right=1561 ,bottom=2590 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(TDED_TOT,0,,TDED_TOT)}', left=1664, top=2548, right=1865, bottom=2593, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1032 ,top=352 ,right=1032 ,bottom=2604 </L>
	<T>id='(48)�� ���� �ҵ���� ��' ,left=164 ,top=2559 ,right=677 ,bottom=2598 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=2553 ,right=987 ,bottom=2553 </L>
	<T>id='(47)�������������������' ,left=164 ,top=2511 ,right=677 ,bottom=2551 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LSS_DED,0,,LSS_DED)}', left=783, top=2511, right=984, bottom=2551, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=156 ,top=2506 ,right=987 ,bottom=2506 </L>
	<T>id='(46)�� �ȵ�� ���� ���ڻ�ȯ��' ,left=164 ,top=2463 ,right=677 ,bottom=2503 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=2458 ,right=987 ,bottom=2458 </L>
	<T>id='(45)������� �߼ұ�� �ٷ���' ,left=164 ,top=2416 ,right=677 ,bottom=2455 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=2410 ,right=987 ,bottom=2410 </L>
	<T>id='(44)�츮�������� ��α�(2014�� ���� ��κ�)' ,left=164 ,top=2368 ,right=770 ,bottom=2408 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=159 ,top=2363 ,right=990 ,bottom=2363 </L>
	<T>id='(43)�츮�������� �⿬��' ,left=164 ,top=2320 ,right=677 ,bottom=2360 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SAJU_DED,0,,SAJU_DED)}', left=783, top=2320, right=984, bottom=2360, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=156 ,top=2315 ,right=987 ,bottom=2315 </L>
	<T>id='(42)�ſ�ī�� �� ����' ,left=164 ,top=2273 ,right=677 ,bottom=2312 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=156 ,top=2267 ,right=987 ,bottom=2267 </L>
	<T>id='(41)������������ ��' ,left=164 ,top=2225 ,right=677 ,bottom=2265 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(VEN2_DED,0,,VEN2_DED)}', left=783, top=2225, right=984, bottom=2265, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=159 ,top=2220 ,right=990 ,bottom=2220 </L>
	<T>id='(��)�ٷ������ø�������' ,left=318 ,top=2178 ,right=635 ,bottom=2217 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SAVE3_DED,0,,SAVE3_DED)}', left=783, top=2178, right=984, bottom=2217, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=307 ,top=2172 ,right=987 ,bottom=2172 </L>
	<T>id='(��)����û����������' ,left=318 ,top=2130 ,right=635 ,bottom=2170 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SAVE2_DED,0,,SAVE2_DED)}', left=783, top=2130, right=984, bottom=2170, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=307 ,top=2125 ,right=987 ,bottom=2125 </L>
	<T>id='(��)û������' ,left=318 ,top=2082 ,right=635 ,bottom=2122 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SAVE1_DED,0,,SAVE1_DED)}', left=783, top=2082, right=984, bottom=2122, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=156 ,top=2077 ,right=987 ,bottom=2077 </L>
	<L> left=307 ,top=2077 ,right=307 ,bottom=2220 </L>
	<T>id='����' ,left=164 ,top=2183 ,right=302 ,bottom=2220 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����ҵ�' ,left=164 ,top=2148 ,right=302 ,bottom=2185 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ø���' ,left=164 ,top=2114 ,right=302 ,bottom=2151 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(40)' ,left=164 ,top=2080 ,right=302 ,bottom=2117 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(39)�ұ�� �һ���� �����α�' ,left=164 ,top=2035 ,right=677 ,bottom=2074 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(SSO_DED,0,,SSO_DED)}', left=783, top=2035, right=984, bottom=2074, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=156 ,top=2029 ,right=987 ,bottom=2029 </L>
	<T>id='(38)���ο�������' ,left=164 ,top=1987 ,right=479 ,bottom=2027 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(PER_DED,0,,PER_DED)}', left=783, top=1987, right=984, bottom=2027, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=106 ,top=1982 ,right=987 ,bottom=1982 </L>
	<L> left=156 ,top=1982 ,right=156 ,bottom=2604 </L>
	<T>id='(37)�����ҵ�ݾ�' ,left=119 ,top=1939 ,right=434 ,bottom=1979 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(INDED_TOT,0,,INDED_TOT)}', left=783, top=1939, right=984, bottom=1979, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=106 ,top=1934 ,right=987 ,bottom=1934 </L>
	<L> left=204 ,top=1886 ,right=987 ,bottom=1886 </L>
	<T>id='(36)��' ,left=209 ,top=1892 ,right=524 ,bottom=1931 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(VEN_DED,0,,VEN_DED)}', left=783, top=1892, right=984, bottom=1931, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(35)��α�(�̿���)' ,left=209 ,top=1844 ,right=524 ,bottom=1884 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(DON_FWD,0,,DON_FWD)}', left=783, top=1844, right=984, bottom=1884, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=204 ,top=1839 ,right=987 ,bottom=1839 </L>
	<C>id='{decode(CARD_DED,0,,CARD_DED)}', left=783, top=2273, right=984, bottom=2312, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(SUM_HINU,0,,SUM_HINU)}', left=783, top=1087, right=984, bottom=1132, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����' ,left=209 ,top=1124 ,right=304 ,bottom=1162 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(33)' ,left=209 ,top=1090 ,right=304 ,bottom=1127 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��������� ���������)' ,left=312 ,top=1114 ,right=736 ,bottom=1151 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)�ǰ������' ,left=312 ,top=1082 ,right=736 ,bottom=1119 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=307 ,top=1156 ,right=987 ,bottom=1156 </L>
	<C>id='{decode(SUM_HINS,0,,SUM_HINS)}', left=783, top=1164, right=984, bottom=1209, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(��)��뺸���' ,left=312 ,top=1164 ,right=736 ,bottom=1201 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=204 ,top=1212 ,right=987 ,bottom=1212 </L>
	<T>id='������' ,left=614 ,top=1217 ,right=749 ,bottom=1257 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LOAN_DED,0,,LOAN_DED)}', left=783, top=1217, right=984, bottom=1257, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='������' ,left=614 ,top=1265 ,right=749 ,bottom=1304 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=310 ,top=1307 ,right=990 ,bottom=1307 </L>
	<C>id='{decode(PLOAN_DED,0,,PLOAN_DED)}', left=783, top=1265, right=984, bottom=1304, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='(��)�����������Ա�' ,left=312 ,top=1228 ,right=572 ,bottom=1265 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݻ�ȯ��' ,left=312 ,top=1262 ,right=572 ,bottom=1299 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LONG4_DED,0,,LONG4_DED)}', left=783, top=1312, right=984, bottom=1352, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='15�� �̸�' ,left=614 ,top=1312 ,right=762 ,bottom=1352 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15��~29��' ,left=614 ,top=1360 ,right=762 ,bottom=1400 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LONG5_DED,0,,LONG5_DED)}', left=783, top=1360, right=984, bottom=1400, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='30�� �̻�' ,left=614 ,top=1408 ,right=762 ,bottom=1447 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LONG6_DED,0,,LONG6_DED)}', left=783, top=1408, right=984, bottom=1447, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=471 ,top=1450 ,right=987 ,bottom=1450 </L>
	<C>id='{decode(LONG8_DED,0,,LONG8_DED)}', left=783, top=1553, right=984, bottom=1593, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=574 ,top=1259 ,right=987 ,bottom=1259 </L>
	<T>id='���Ժ�' ,left=476 ,top=1394 ,right=572 ,bottom=1431 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=476 ,top=1360 ,right=572 ,bottom=1397 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2011��' ,left=476 ,top=1326 ,right=572 ,bottom=1363 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����ݸ�/���ġ' ,left=579 ,top=1455 ,right=773 ,bottom=1495 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=577 ,top=1540 ,right=987 ,bottom=1540 </L>
	<C>id='{decode(LONG7_DED,0,,LONG7_DED)}', left=783, top=1479, right=984, bottom=1519, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='���ڻ�ȯ��' ,left=318 ,top=1574 ,right=463 ,bottom=1611 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������Ա�' ,left=318 ,top=1540 ,right=463 ,bottom=1577 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�������' ,left=318 ,top=1505 ,right=463 ,bottom=1543 ,align='left' ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='(��)' ,left=318 ,top=1471 ,right=463 ,bottom=1508 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��ȯ����' ,left=579 ,top=1498 ,right=773 ,bottom=1537 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ ����' ,left=579 ,top=1553 ,right=773 ,bottom=1593 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2012��' ,left=476 ,top=1455 ,right=572 ,bottom=1492 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=476 ,top=1490 ,right=572 ,bottom=1527 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ժ�' ,left=476 ,top=1524 ,right=572 ,bottom=1561 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15���̻�' ,left=476 ,top=1558 ,right=572 ,bottom=1595 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=474 ,top=1598 ,right=990 ,bottom=1598 </L>
	<L> left=574 ,top=1214 ,right=574 ,bottom=1842 </L>
	<T>id='�����̸鼭' ,left=651 ,top=1603 ,right=775 ,bottom=1632 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ġ' ,left=651 ,top=1632 ,right=775 ,bottom=1662 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�����̰ų�' ,left=651 ,top=1670 ,right=775 ,bottom=1699 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ġ' ,left=651 ,top=1699 ,right=775 ,bottom=1728 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='��Ÿ����' ,left=651 ,top=1738 ,right=775 ,bottom=1767 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=471 ,top=1310 ,right=471 ,bottom=1839 </L>
	<L> left=307 ,top=844 ,right=307 ,bottom=1842 </L>
	<L> left=204 ,top=357 ,right=204 ,bottom=1934 </L>
	<L> left=156 ,top=355 ,right=156 ,bottom=1934 </L>
	<L> left=646 ,top=1601 ,right=646 ,bottom=1842 </L>
	<C>id='{decode(LONG9_DED,0,,LONG9_DED)}', left=786, top=1614, right=987, bottom=1654, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=648 ,top=1664 ,right=987 ,bottom=1664 </L>
	<L> left=646 ,top=1730 ,right=987 ,bottom=1730 </L>
	<C>id='{decode(LONG10_DED,0,,LONG10_DED)}', left=786, top=1677, right=987, bottom=1717, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='�����̰ų�' ,left=651 ,top=1781 ,right=775 ,bottom=1810 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���ġ' ,left=651 ,top=1810 ,right=775 ,bottom=1839 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{decode(LONG12_DED,0,,LONG12_DED)}', left=786, top=1789, right=987, bottom=1828, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(LONG11_DED,0,,LONG11_DED)}', left=786, top=1733, right=987, bottom=1773, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DCIRP_DED,0,,DCIRP_DED)}', left=1664, top=1045, right=1865, bottom=1090, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(ETC_TOT,0,,ETC_TOT)}', left=783, top=2559, right=984, bottom=2598, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=574 ,top=1355 ,right=987 ,bottom=1355 </L>
	<L> left=574 ,top=1402 ,right=987 ,bottom=1402 </L>
	<L> left=574 ,top=1773 ,right=990 ,bottom=1773 </L>
	<T>id='15��' ,left=579 ,top=1807 ,right=640 ,bottom=1836 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='10~' ,left=579 ,top=1778 ,right=640 ,bottom=1807 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='15��' ,left=579 ,top=1654 ,right=640 ,bottom=1691 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�̻�' ,left=579 ,top=1688 ,right=640 ,bottom=1725 ,face='����' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='����' ,left=476 ,top=1699 ,right=572 ,bottom=1736 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='���Ժ�' ,left=476 ,top=1728 ,right=572 ,bottom=1765 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='2015��' ,left=476 ,top=1664 ,right=572 ,bottom=1701 ,face='����' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
</R>
</A>
		
">
</object>




</body>
</html>