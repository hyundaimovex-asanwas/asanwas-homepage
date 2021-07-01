<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

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
	    
        var strParam = new Array();	//�˾��� �޾ƿ��� �Ķ���͵�
    	strParam=window.dialogArguments;
		alert("COST_CD+NO_BUDGET DB������ �������� ������ �� �ֽ��ϴ�.���� �ּ����� �ʿ�");
        var cost_cd = '180501' ;// strParam[0];  
        var no_budget ='0001' ;//strParam[1];
		
		
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>"
    		+ ",V_COST_CD=" + cost_cd + ",V_NO_BUDGET=" + no_budget;
    	
        
        ln_TRSetting(tr1, 
        	"<%=dirPath%><%=HDConstant.PATH_BUD%>Bd031",
            "JSP(O:DS_ITEM_M=ds_item_m)",
            param);
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
            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd031",
            "JSP(O:DS_ITEM_M=ds_item_m)", //ȭ�� ���. o ->output
            v_param);

        
        tr_post(tr1);

    }    
    





	<%//����=���ο�û %>
	function fnApply(){
		
		v_job = "A";
		var RowCnt = ds_ITEM_D.CountRow;
		var V_NO_BUDGET = ds_ITEM_D.NameValue(ds_ITEM_D.RowPosition,"NO_BUDGET");
		var V_CD_COST = ds_ITEM_D.NameValue(ds_ITEM_D.rowposition,"CD_COST"); // �����ڵ�
		var V_DS_KSITEM = ds_ITEM_D.NameValue(ds_ITEM_D.rowposition,"DS_KSITEM"); // �����ڵ� 
		alert("V_CD_COST:::"+V_CD_COST+"V_NO_BUDGET:::"+V_NO_BUDGET+"V_DS_KSITEM:::"+V_DS_KSITEM);
		
		
		
/* 		var RowCnt = ds_ITEM_D.CountRow;
		for(i=1; i<=RowCnt; i++){
			V_COST_CD_txt = ds_ITEM_D.NameValue(i,"CD_COST");
		} */ 
		
		if (ds_ITEM_D.IsUpdated) {

			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd031",
			                "JSP(I:DS_ITEM_D=ds_item_d)",
			                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
			  
			 //  prompt(this, ds_ITEM_D.text);
			  
			   tr_post(tr1);

        }else{
        	
     		alert("������ Data�� �����ϴ�.");
		
        }
		
		
	 }




		<%//�ű� ���� %>
	      function fnAddNew() {
	          // AddNew �� �Է� ���̺�� ��Ŀ��
	          ds_ITEM_D.AddRow(); 
	          ds_ITEM_D.namevalue(ds_ITEM_D.RowPosition, "NO_BUDGET")= ds_ITEM_D.namevalue(1, "NO_BUDGET") ;
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

		var overId1 = "CD_COST";
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
		            "<%=dirPath%><%=HDConstant.PATH_BUD%>Bd031",
		            "JSP(O:DS_ITEM_D=ds_item_d)", 						
		            v_param);

        
        tr_post(tr1);

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
<!-- 	<script for=grd_ITEM_D event=OnClick(Row,Colid)>
		var overId1 = "CD_COST";
		var overId2 = "TREE_LEVEL";
		var overNm = tree_ds_ITEM_M.ItemText;
		var Row = ds_ITEM_M.NameValueRow("DS_KSITEM",overNm);
		var overValue1 = ds_ITEM_M.NameValue(Row,overId1);
		var overValue2 = ds_ITEM_M.NameValue(Row,overId2);
		overValue2 = parseInt(overValue2)+1;
	// Ŭ���� �� ���̺� ��ü 
	//orderAct(���ޱݾ�) exeActUp(���࿹��) ORDER_AMT_NOW(���޾�_����) EXE_ACT_AMT_NOW(����_����))
		document.getElementById("project").innerHTML = overNm;
		document.getElementById("exeCaSu").innerHTML = overValue2 + " ����";
		document.getElementById("orderAct").innerHTML  = ds_ITEM_D.NameValue(ds_ITEM_D.RowPosition,"ORDER_AMT_NOW") ;
		document.getElementById("exeActUp").innerHTML  = ds_ITEM_D.NameValue(ds_ITEM_D.RowPosition,"EXE_ACT_AMT_NOW") ;
	
	</script> -->

<!--
**************************************************************
* BODY START
**************************************************************
-->


</head>
	<jsp:include page="/Pms/common/include/head.jsp"/>
    <jsp:include page="/Common/sys/body_s11.jsp"/>


<!-- form ���� -->
<form name="form1">
<!-- ��ư ���̺� ���� -->
<%-- 	<table width="1000" border="0" cellspacing="0" cellpadding="0">
	    <tr>
	        <td height="35" class="paddingTop5" align="right">
	        	<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">
	        	<img src="<%=dirPath%>/Sales/images/n_create.gif"				style="cursor:pointer" onclick="fnAddNew()">
	        	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"			style="cursor:pointer" onclick="fnApply()">	
	        </td>
	    </tr>
	</table> --%>
	<!-- input ��   --> 
	<table width="1000" border="1" cellspacing="0" cellpadding="0">
		<tr>
			<td style="width: 200px;">Project&nbsp;&nbsp;<span id="project" ></span></td>
			<td style="width: 200px;">��������&nbsp;&nbsp;<span id="exeCaSu"></span></td>
			<td style="width: 200px;">���ޱݾ�&nbsp;&nbsp;<span id="orderAct"></span></td>
			<td style="width: 200px;">���࿹��&nbsp;&nbsp;<span id="exeActUp"></span></td>
			<td style="width: 200px;">�����&nbsp;&nbsp;<span id="exeAct"></span></td>
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
							                                <C> id='DS_KSITEM'	width=110	align=left name='Content'	show=true </C>									                                
							                                <C> id='CD_COST'	width=110	align=left name='CODE'	show=true  </C>
							                                <C> id='NO_BUDGET'	name='����' align=center	 show=false</C> 	
							                                <C> id='ORDER_AMT_OLD'		width=110		name='����(����)'			align=center	</C> <!-- value={String(Currow)} -->
							                                <C> id='ORDER_AMT_NOW'	width=110		name='����(����)'			align=center 								</C>
							                                <C> id='ORDER_AMT_DIF'	width=110		name='����(����)'		align=center				                    </C>
							                                <C> id='EXE_ACT_AMT_OLD'	width=110		name='����(����)'		align=center	   				</C><!-- �⺻��  decao = 0 -->
							                                <C> id='EXE_ACT_AMT_NOW'	width=110		name='����(����)'		align=center	 </C> 
							                                <C> id='EXE_ACT_AMT_DIF'	width=110		name='����(����)'		align=center	 </C> 
							                                <C> id='COST_CD'	width=130		name='ǰ���ڵ�'	align=center EditStyle=Popup </C> 	
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

