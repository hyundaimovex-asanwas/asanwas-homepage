<!--
    ************************************************************************************
    * @Source         : piri010.jsp
    * @Description    : �����ο����
    * @Font           :
    * @Developer Desc :
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            �̵���            	ERP �̻�							   *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>
<head>
<title>�����ο����</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >



        /***********************************
         * 01. ��ȸ �Լ�_List ������ ��ȸ  *
         ***********************************/
        function fnc_SearchList() {

			var check1 = '';
			var check2 = '';
			var check3 = '';
			var check4 = '';
			var check5 = '';

			var end_yn = document.form1.rdoEND_YN_SHR.CodeValue;

			dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.i.piri010.cmd.PIRI010CMD&S_MODE=SHR_01&END_YN="+end_yn;
			dsT_CM_PERSON.reset();

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

			dsT_CM_PERSON.ClearData();
			dsT_CM_PERSON2.ClearData();
			document.form1.rdoEND_YN_SHR.CodeValue = "1";
			document.getElementById("resultMessage").innerText = ' ';
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

			var check = "N";

			for(i=0;i<checkList.length;i++){
				if(checkList[i].checked == true){
					check = "Y";
				}
			}



        }

        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load �� Default �۾� ó�� �κ�  *
         *******************************************/
        function fnc_OnLoadProcess() {

			var f = document.form1;

            //Grid Style ����
			cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","false");
			cfStyleGrid_New(form1.grdT_CM_PERSON2,0,"true","true");


			f.rdoEND_YN_SHR.CodeValue = "1";

            fnc_SearchList();

            
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
	*																						 *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���) *
	*																						 *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                             |
    | 2. �̸� : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. ��ȸ �� ����� DataSet                     |
    | 2. �̸� : dsT_CM_PERSON2                      |
    | 3. Table List : T_CM_PERSON2                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_PERSON_DUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        	Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			var cnt = 0;
			for(i=1;i<iCount+1;i++){
				cnt = cnt + dsT_CM_PERSON.NameValue(i,'ENO_CNT');
			}
	        document.getElementById("resultMessage").innerText = "  �� "+iCount+"�� ��, "+cnt+"��";
        }
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!-----------------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset���� Error ó��
		cfErrorMsg(this);

    </Script>

	<!---------------------------------+
    | �ٸ� Radio Button�� ������ ���  |
    +------ --------------------------->
	<script language=JavaScript for=rdoEND_YN_SHR event=OnSelChange()>

		if(dsT_CM_PERSON2.CountRow>1){
			dsT_CM_PERSON2.ClearData();
		}
		fnc_SearchList();

	</script>


    <!------------------------------+
    | ���� grid���� row�� Ŭ�������� |
    +------ ------------------------>
	<script for=grdT_CM_PERSON event=OnClick(Row,Colid)>
	
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		
		var end_yn = document.form1.rdoEND_YN_SHR.CodeValue;
		
		if(Row < 1) {
			
			return;
			
		} else {
			
			try {
				dsT_CM_PERSON2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.i.piri010.cmd.PIRI010CMD&S_MODE=SHR_02&END_YN="+end_yn+"&DPT_CD="+dsT_CM_PERSON.NameValue(Row,'DPT_CD');
				dsT_CM_PERSON2.Reset();

			} catch ( exception ) {
				
				fcWindowsXpSp2Notice(false);
				return;
				
			}
			
		}
	</script>

    <!------------------------------+
    | grid���� row�� ����Ŭ�������� |
    +------ ------------------------>
	<script for=grdT_CM_PERSON2 event=OnDblClick(Row,Colid)>
	
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );

		var url = "";
		var data = new String();

		if(Row < 1) {

			return;

		} else {
			
			dsT_CM_PERSON_DUTY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.i.piri010.cmd.PIRI010CMD&S_MODE=SHR_DUTY&ENO_NO="+gusrid;
			dsT_CM_PERSON_DUTY.reset();
			
	        var ENONO = dsT_CM_PERSON_DUTY.NameValue(1,'ENO_NO');			
	        var DUTYCD = dsT_CM_PERSON_DUTY.NameValue(1,'DUTY_CD');
	        var TEAMCD = dsT_CM_PERSON_DUTY.NameValue(1,'TEAM_CD');     
	        var DPTCD = dsT_CM_PERSON_DUTY.NameValue(1,'DPT_CD');


	        	//20 ��������̸�
	            if (DUTYCD == "20") {
   	
					            if (TEAMCD != dsT_CM_PERSON2.NameValue(Row,'TEAM_CD')) {	
					            	
					            	alert("���������� �ش����� �ο��� ��ȸ�����Ͻʴϴ�.");
					            	
					            	return;
					            	
				            	}else{
				            		
					    			data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
					    			data.mode       = "read";
				
					    			url = "../../../Ehr/hr/pir/pirc010.jsp";
					    			
					    			window.showModalDialog(url, data, "dialogWidth:950px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	            	
				            	}
		            
	             }else{
	            	 
									// 2016.09.22 �μ��� ->�������� ����Ƴ� �򰥸� 
									// 41 �����̸�
					 	            if (DUTYCD == "41") {	            

							            if (DPTCD != dsT_CM_PERSON2.NameValue(Row,'DPT_CD')) {	
							            	
							            	// �ѻ�� ������� ���������� + ������� ��ȸ ���� 2020.04.14 �̵���
							            	if (ENONO == '2030002') {
							            		
							            		if (dsT_CM_PERSON2.NameValue(Row,'DPT_CD') == 'II25'){
								            		
													data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
													data.mode       = "read";
													url = "../../../Ehr/hr/pir/pirc010.jsp";
													window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	
								            		
							            		
													
													
							            		}else{

								            		alert("������� �ش��� �ο��� ��ȸ�����Ͻʴϴ�.");
								            		return;
							            	
							            		}


							            	}
							            	
						            	}else{
						            		
											data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
											data.mode       = "read";
											url = "../../../Ehr/hr/pir/pirc010.jsp";
											window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");		            		
							            	
							            	
							            	}	 	            	
					 	            	

								   // �̱���󹫴�, ��ö�󹫴��� �Ǽ�������� ��ȸ ���� 	            	
					 	           }else if (ENONO == '2040062') {				            

									    if (dsT_CM_PERSON2.NameValue(Row,'HEAD_CD') == 'II00'){
									            			
											data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
											data.mode       = "read";
											url = "../../../Ehr/hr/pir/pirc010.jsp";
											window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	

						            	}else{
						            		
										    if (dsT_CM_PERSON2.NameValue(Row,'ENO_NO') == '2040067' || dsT_CM_PERSON2.NameValue(Row,'ENO_NO') == '2080006'){
						            			
												data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
												data.mode       = "read";
												url = "../../../Ehr/hr/pir/pirc010.jsp";
												window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	

										    }else{
										    	
										    	return;
										    	
										    }
						            		
											return;
						            	}	 										    
									    
  
								   // �̵��� �׽�Ʈ	            	
					 	           }else if (ENONO == '6060002' || ENONO == '6180001') {				            
					 	        	   
					 	        	   
					            		if (dsT_CM_PERSON2.NameValue(Row,'DPT_CD') == 'II25'){
						            		
											data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
											data.mode       = "read";
											url = "../../../Ehr/hr/pir/pirc010.jsp";
											window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	
						            		
					            		}
									    
					 	           }else{
					 	        	   
				
									data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
									data.mode       = "read";
				
									url = "../../../Ehr/hr/pir/pirc010.jsp";
									
									window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
							
					 	           }
	 	            
	             }

		}
	</script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

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
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="2">
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

											<col width="*"></col>
										</colgroup>
										<tr>
											<td align="center" class="searchState">����/��������&nbsp;</td>
											<td class="padding2423"><comment id="__NSID__">
												<object id=rdoEND_YN_SHR classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
															style="height:20; width:180">
													<param name=AutoMargin	value="true">
													<param name=Cols		value="2">
													<param name=Format		value="1^������ ����,2^������ ����">
												</object>
												</comment><script> __ShowEmbedObject(__NSID__); </script>
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
		</td>
	</tr>
    <tr>
        <td>
            <!-- ��ȸ ���� ���̺� ���� -->
            <table width="200" border="0" cellspacing="0" cellpadding="0">
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
        </td>
    </tr>
	<tr>
		<td>
			<!-- ���� ȭ�� ����-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">

						<!-- ���� ��ȸ �׸��� ���̺� ����-->
                        <table width="300" border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:540px;">
                                        <param name="DataID"                        value="dsT_CM_PERSON">
                                        <param name="EdiTABLE"              value="false">
                                        <param name="DragDropEnable"        value="true">
                                        <param name="SortView"                  value="Left">
                                        <param name="VIEWSUMMARY"       value=0>
                                        <param name="Format"                        value="
                                            <C> id='CURROW'  	width=35   name='NO'   align=center        value={CurRow}  </C>
                                            <C> id='DPT_NM'  	width=200  name='�Ҽ�'   align=left </C>
                                            <C> id='ENO_CNT' 	width=45   name='�ο�'   align=right </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
						<!-- ���� ��ȸ �׸��� ���̺� ��-->
					</td>
				</tr>
			</table>
			<!-- ���� ȭ�� ��-->
		</td>
		<td>
			<!-- ������ ȭ�� ����-->
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- ���� ��ȸ �׸��� ���̺� ����-->
                        <table width="600" border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_PERSON2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:700px;height:540px;">
                                        <param name="DataID"                        value="dsT_CM_PERSON2">
                                        <param name="EdiTABLE"              value="false">
                                        <param name="DragDropEnable"        value="true">
                                        <param name="SortView"                  value="Left">
                                        <param name="VIEWSUMMARY"       value=0>
                                        <param name="Format"                        value="
                                            <C> id='CURROW' width=45    name='NO'   align=center        value={CurRow}  </C>
                                            <C> id='ENO_NM'  width=80   name='����'   align=center edit='none'</C>
                                            <C> id='ENO_NO'  width=70   name='���'   align=center edit='none'</C>                                        
                                            <C> id='TEAM_NM' width=100   name='��Ʈ/����'    align=left edit='none'</C>
                                            <C> id='DUTY_NM' width=80   name='��å'   align=center edit='none'</C>
                                            <C> id='JOB_NM'  width=100   name='����'   align=center edit='none'</C>
                                            <C> id='HOB_NM'  width=60   name='����'   align=center edit='none'</C>
                                            <C> id='HIR_YMD' width=70   name='�Ի���' align=center edit='none'</C>
                                            <C> id='RET_YMD' width=70   name='������' align=center     edit='none'</C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
						<!-- ���� ��ȸ �׸��� ���̺� ��-->
					</td>
				</tr>
  			</table>


	              <tr>
                    <td  colspan="2">
                    <br>
                    &nbsp;&nbsp;�� ���κ� �ڷḦ ����Ŭ���ϸ� ���������� ��ȸ�˴ϴ�.<br>
                    </td>
                </tr>


    		<!-- ������ ȭ�� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


