<!--
    ******************************************************************
    * @Source              : item010.jsp                             *
    * @Description         : ǰ���ڵ����                            *
    * @Font                :                                         *
    * @Developer Desc      :                                         *
    *******************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                          *
    *-------------+-----------+-------------------------------------+
	* 2018/06/11            �̵���            				         *
    *******************************************************************
-->

<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML ���� : doctype�� html5�� �غ���? ��;;-->
<!DOCTYPE html>
<html lang="ko-KR">
	<head>
	<!-- <meta charset=euc-kr"> -->
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Cache-control" content="no-cache"/>
	<meta http-equiv="Cache-control" content="no-store"/>
	<meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=1080" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	
    <jsp:include page="/Pms/common/include/head.jsp"/>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >


	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����
	
	var menuWin;	//��â �����.
	
	
	
	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		cfStyleGrid(getObjectFirst("grd_ITEM_D"), "comn");	//list detail

		fnInit();
		
	}
	
	
	
	
    <%//�ʱ��۾� %>
    function fnInit() {
    	
	    v_job ="I";
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm010",
            "JSP(O:DS_ITEM_M=ds_item_m)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>");
		
        tr_post(tr1);


    }

    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {

    	v_job="S";

    	/* protype = select , v_site_sid ,  */
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						+ ",v_code=" + txtCOMM_CD_SHR.value				//�ڵ�� , �˻�����
						;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm010",
            "JSP(O:DS_ITEM_M=ds_item_m)", //ȭ�� ���. o ->output
            v_param);

        
        tr_post(tr1);

    }    
    



 		<%//���� %>         
        function fnSave() {
        	
			var f = document.form1;
			
			if(fnc_SaveItemCheck()) {
				
				tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
				tr01T_CM_COMMON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb010.cmd.CODB010CMD&S_MODE=SAV";
				tr01T_CM_COMMON.post();
				

	            dsT_CM_COMMON.Reset();

	            ds01T_CM_COMMON.Reset();
	            
			} else {
				
				return;
				
			}
        }





		<%//�ű� ���� %>
	      function fnAddNew() {
	
	          // AddNew �� �Է� ���̺�� ��Ŀ��
	          ds_ITEM_D.AddRow();
	
	          ds_ITEM_D.NameValue(ds_ITEM_D.RowPosition,"DT_APPLY") = "<%=DateUtil.getCurrentDate(8)%>";
	          
	
	      }




        /*************************
         * 13. ���� ��ȿ�� üũ  *
         *************************/
        function fnc_SaveItemCheck() {
        	
   			var f = document.form1;

			//DataSet�� ���� ���� Ȯ��
			if (!ds01T_CM_COMMON.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			
			var oCD_GBN, oCOMM_CD, oCOMM_NM, oSORT_NO, oEND_YMD;
			
			var RowCnt = ds01T_CM_COMMON.CountRow;
			
			
			for(i=1; i<=RowCnt; i++){

				oCD_GBN = ds01T_CM_COMMON.NameValue(i,"CD_GBN");
				if(oCD_GBN.trim() == ""){
					alert(i+"��°�� ���뱸���ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCD_GBN").focus();
					return false;
				}

				oCOMM_CD = ds01T_CM_COMMON.NameValue(i,"COMM_CD");
				if(oCOMM_CD.trim() == ""){
					alert(i+"��°�� �ڵ尡 �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCOMM_CD").focus();
					return false;
				}

				oCOMM_NM = ds01T_CM_COMMON.NameValue(i,"COMM_NM");
				if(oCOMM_NM.trim() == ""){
					alert(i+"��°�� �ڵ���� �߸��Ǿ����ϴ�." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCOMM_NM").focus();
					return false;
				}


			}

			return true;
        }



</script>





    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component �����(�ش� ������ ���Ǵ� ��� ���۳�Ʈ�� �̰��� ���� �ϼ���)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. ��ȸ�� DataSet                            |
    | 2. �̸� : ds_ITEM_M,    ds_ITEM_D            |
    +----------------------------------------------->
    
	<object id=ds_ITEM_M classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>
	
	<object id=ds_ITEM_D classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>


	<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
	    <param name="KeyName"    value="toinb_dataid4"/>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>



    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | �����͸� ���������� ��ȸ �Ǿ��� �� ó�� �� ����  |
    +-------------------------------------------------->


	<%//������ �׸��� OnClick %>
	<script language="javascript"  for=tree_ds_ITEM_M event=OnClick()>

	
		var overId1 = "CD_ITEM";
		var overId2 = "TREE_LEVEL";
		var overNm = tree_ds_ITEM_M.ItemText;
		var Row = ds_ITEM_M.NameValueRow("DS_KSITEM",overNm);
		var overValue1 = ds_ITEM_M.NameValue(Row,overId1);
		var overValue2 = ds_ITEM_M.NameValue(Row,overId2);
		
		overValue2 = parseInt(overValue2)+1;
		
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1+", overValue2 : "+overValue2);
		
		
    	v_job="S";

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						+ ",v_overValue1=" + overValue1							//�ڵ��
						+ ",v_overValue2=" + overValue2							//Tree Level					
						;

        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm010",
		            "JSP(O:DS_ITEM_D=ds_item_d)", 						
		            v_param);

        
        tr_post(tr1);


	</script>



<script language=JavaScript  for=ds_ITEM_M event=OnLoadCompleted(row)>

		//alert(row);
	
		if(row>0){

			tree_ds_ITEM_M.focus();

			tree_ds_ITEM_M.ExpandLevel = '2';

			tree_ds_ITEM_M.index = 3;	


        }
		
</script>




    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr1 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>


    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr1 event="OnFail()">
        cfErrorMsg(this);
    </script>



</head>
<!--
**************************************************************
* BODY START
**************************************************************
-->


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!-- form ���� -->
<form name="form1">

<!-- ��ư ���̺� ���� -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
        	<img src="<%=dirPath%>/Sales/images/refer.gif"			style="cursor:pointer" onclick="fnSelect()">
        	<img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:pointer" onclick="fnAddNew()">
        	<img src="<%=dirPath%>/Sales/images/save.gif"			style="cursor:pointer" onclick="fnSave()">	
        </td>
    </tr>
</table>
<!-- ��ư ���̺� �� -->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- ���� ȭ�� ����-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  class="r">
						<!-- power Search���̺� ���� -->
						<table width="300" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<colgroup>
											<col width="100"></col>
											<col width=""></col>
											<col width="60"></col>
										</colgroup>
										<tr>
											<td align="center" class="text">�ڵ�/�ڵ��</td>
											<td align="center">
												<input name="txtCOMM_CD_SHR" style="width 100%;" class="divInput" onKeypress="javascript:if(event.keyCode==13)fnc_SearchList()"></td>
											<td align="left"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- power Search���̺� �� -->


						<!-- ���� ��ȸ Tree ����-->
						<table width="300" height = "600" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td>
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <object id="tree_ds_ITEM_M" classid=<%=HDConstant.MxTree_CLSID_S%> style="width:300px;height:600px;">
						                            <param name="DataID"					value="ds_item_m">
													<param name=TextColumn					value="DS_KSITEM">
													<param name=LevelColumn					value="TREE_LEVEL">
													<param name=ExpandLevel					value="0">
													<param name=BorderStyle  				value="2">													
						                        </object>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- ���� ��ȸ Tree ��-->

					</td>
				</tr>
			</table>
			<!-- ���� ȭ�� ��-->
		</td>
		<td>
			<!-- ������ ȭ�� ����-->
			<table width="690" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- ���� ��ȸ �׸��� ���̺� ����-->
						<table width="690" height = "620" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <object id="grd_ITEM_D" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:690px;height:620px;">
						                            <param name="DataID"						value="ds_item_d">
						                            <param name="EdiTABLE"						value="true">
						                            <param name="DragDropEnable"				value="true">
						                            <param name="SortView"						value="Left">
						                            <param name="VIEWSUMMARY"					value=0>
						                            <param name="Format"						value="
						                                <C> id='CURROW'		width=80		name='NO'			align=center		value={String(Currow)}	</C>
						                                <C> id='CD_ITEM'	width=100		name='�ڵ�'			align=center 								</C>
						                                <C> id='DS_KSITEM'	width=300		name='�ڵ��'		align=left				                    </C>
						                                <C> id='AMT_ITEM'	width=100		name='���شܰ�'		align=center	    decao = 0				</C>
						                                <C> id='DT_APPLY'	width=100		name='������'		align=center	    mask = 'XXXX-XX-XX'		</C>						                                
						                            ">
						                        </object>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- ���� ��ȸ �׸��� ���̺� ��-->

					</td>
				</tr>
			</table>
			<!-- ������ ȭ�� ��-->
		</td>
	</tr>
</table>

</form>
<!-- form �� -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

