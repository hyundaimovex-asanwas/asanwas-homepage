<!--
    ******************************************************************
    * @Source              : item020.jsp                             *
    * @Description         : ǰ���ڵ���� �ű� ���� ��û             *
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
            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm020",
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
    





	<%//����=���ο�û %>
	function fnApply(){
		
		v_job = "A";
		

		if (ds_ITEM_D.IsUpdated) {

			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm020",
			                "JSP(I:DS_ITEM_D=ds_item_d)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
			  
			   //prompt(this, ds_ITEM_D.text);
			  
			   tr_post(tr1);

        }else{
        	
     		alert("������ Data�� �����ϴ�.");
		
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
</head>

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


    <!----------------------------------------------+
    | 1. �ڷ� ���� �� ��ȸ�� Data Transacton        |
    | 2. �̸� : tr1, tr2                     		|
    +----------------------------------------------->
    
	<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
	    <param name="KeyName"    value="toinb_dataid4"/>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>

	<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
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
		            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm020",
		            "JSP(O:DS_ITEM_D=ds_item_d)", 						
		            v_param);

        
        tr_post(tr1);


	</script>

<script language=JavaScript  for=ds_ITEM_M event=OnLoadCompleted(row)>

		//alert(row);
	
		if(row>0){

			tree_ds_ITEM_M.focus();

			tree_ds_ITEM_M.ExpandLevel = '2';

			tree_ds_ITEM_M.index = 2;	


        }
		
</script>

    <!---------------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����      |
    +---------------------------------------------------------->
    <Script For=ds_ITEM_M Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <Script For=ds_ITEM_D Event="OnLoadError()">
        //Error Message ó��(Session Chekc, Biz Logic�� Error ó��)
        cfErrorMsg(this);
        // ���� �޼��� ó�� �� ���� ó�� �� ���� �ڵ�
    </Script>

    <!---------------------------------------------------------+
    | �������� �ű� Ȥ�� �߰� �۾��� �� �� Header�� ���� ������ �� ��  |
    +---------------------------------------------------------->
    <Script For=ds_ITEM_M Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <Script For=ds_ITEM_D Event="OnDataError()">
        //Dataset���� Error ó��
        cfErrorMsg(this);
    </Script>

    <!-----------------------------+
    | Transaction Successful ó��      |
    +------------------------------>
    <script for=tr1 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <script for=tr2 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

    <!--------------------------+
    | Transaction Failure ó��       |
    +--------------------------->
    <script for=tr1 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <script for=tr2 event="OnFail()">
        cfErrorMsg(this);
    </script>

    <!--------------------------+
    | grid���� row�� Ŭ�������� |
    +------ -------------------->
	<script for=grd_ITEM_D event=OnClick(Row,Colid)>


	</script>

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
        	<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">
        	<img src="<%=dirPath%>/Sales/images/n_create.gif"				style="cursor:pointer" onclick="fnAddNew()">
        	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"			style="cursor:pointer" onclick="fnApply()">	
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
						<!-- ���� �Է� ���̺� ����=
						<table width="690" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999">
										<colgroup>
											<col width="90"></col>
											<col width="250"></col>
											<col width="90"></col>
											<col width=""></col>
										</colgroup>
										<tr>
											<td align="center" class="text">��з�</td>
											<td><input id="txtCD_GBN" style="width:80%" maxlength="2"></td>
											<td align="center" class="text">�ڵ�</td>
											<td><input id="txtCOMM_CD" style="width:80%"  maxlength="5"></td>
										</tr>
										<tr>
											<td align="center" class="text">�ڵ��</td>
											<td><input id="txtCOMM_NM" style="width:80%" maxlength="10"></td>
											<td align="center" class="text"></td>
											<td></td>
										</tr>
										<tr>
											<td align="center" class="text">�������</td>
											<td>
												<input id="txtSTR_YMD" style="width:80%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">

											</td>
											<td align="center" class="text">�������</td>
											<td>
												<input id="txtEND_YMD" style="width:80%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
											</td>
										</tr>
										<tr>
											<td align="center" class="text">���ļ���</td>
											<td class="padding2423">
												<input id="txtSORT_NO" style="width:80%;padding-left:15" maxlength="10" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();" style="ime-mode:disabled">
											</td>
											<td align="center" class="text"></td>
											<td></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- ���� �Է� ���̺� �� -->

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
						                                <C> id='DS_KSITEM'	width=290		name='�ڵ��'		align=left				                    </C>
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


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

