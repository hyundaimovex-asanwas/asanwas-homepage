<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �����ý���> ����ž��(�԰�)
 * ���α׷�ID 	: cq210i
 * J  S  P		: cq210i
 * �� �� ��		: Cq210i
 * �������		: ������ ���԰�ȹ�� ����, ������ �ο��� ���踦 �δ� ȭ��.
 * [ �������� ][������] ����
 * [2010-03-15][�ɵ���] �ż�. �����ο��� ���� ž�� ����
 * [2010-03-19][�ɵ���] ���⿡ ���� ���/�԰�� ���⿡ ���� �Ķ���� ����
 *		     ��.. ��¿��.. �԰�ð�, ��ǰ�� �ִ� �͵鸸 �˻��ϴ°� ������? ��..;;
 *		     		ü�����濡���� �԰�ð�/��ǰ�� �������� ������� �𸣴� ���� ����������
 *		     		����� �ٸ���.. �ִ� �͵鸸 ��ȸ�ϴ°� ���� ��~!
 *
 *					�� ��ǰ, ���԰�ð� ��� trm220(��ǰ����)�� ��ϵ� ���� �ҷ������ 
 *						���� �������鿡 ������ ������ commonH.java�� �ű� ������ �߰�
 *						- ������ �÷����� ���,�԰�� ���ƾ� ���� luxcombo���� ȣȯ����
 * [2015-09-23][�ɵ���] ������ ž�� ��Ī, ȣ���� ���(200I), �԰�(210I) �����ϱ��
 *						�׷��� ���԰�ȹ�� ������ ��Ȯ�ϰ� ���� �� �ֽ��ϴ�.
 *						UI�� ���ȭ��� �԰�ȭ������ �����ϴ�.
 * [2015-10-22][�ɵ���] �԰�� ��/���� ���� �� ����� �ʿ��� ��
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	
	java.util.Calendar date = java.util.Calendar.getInstance();
   	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   	String firstday = m_today.format(date.getTime());	
//   	firstday="20150916";
//   date.add(java.util.Calendar.DATE, +10);         
//   String endday = m_today.format(date.getTime()); 
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
	
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
         var v_job = "H";		
		 var div='';

		// �������ε�
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	        v_job = "H";		
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");		//���
			sDate.Text = '<%=firstday%>';	
			fnInit()
		} 
		 
		function fnInit() {
			div = 'init';
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ�

	        ds_code1.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ001&s_item1=Y";
	        ds_code1.Reset();	//���Թ���
	        
	        ds_code2.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=CQ004&s_item1=Y";
	        ds_code2.Reset();	//��������

	        ds_dp_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM014&s_item1=Y";
	        ds_dp_time.Reset();	//���ð�
	        ds_ar_time.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM015&s_item1=Y";
	        ds_ar_time.Reset();	//�԰�ð�
	     

			//���� ������ �ε尡 ������?
//			lc_code1.Index = 1; // �԰����� ����
//		    lc_code1.Enable = false;	//�׸��� ���� ��..		

		}



		// �������� ��ȸ (GR1)
		function fnSelect1() {
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("detail", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_accept_no=" + v_accept_no.Text        ;

			
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(O:DS_CAR=ds_car)",
			    param);
			   
			tr_post(tr1);
		}


					

		// ������������
		function fnApply1() {
			if (ds_car.IsUpdated) {
				v_job = "I1";	//�������������� I1
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
				          + ",sDate=" + sDate.Text;

				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
				    "JSP(I:DS_CAR=ds_car,O:RESULT=ds_result)",
				    param);
				tr_post(tr1);
			} else {
				alert("������ ���������� �����ϴ�.");
			};
			
		}


		// �ο����� ��ȸ (GR2)
		function fnSelect2() {
			v_job = "S";	//select �ϵ�..
			var v_assign;
			if(sAssign_YN.checked){
				v_assign="Y";
			}else{
				v_assign="N";
			}
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				      + ",v_ride=N"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("detail", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_class=" + lc_class.ValueOfIndex("class", lc_class.Index)
			          + ",v_team=" + lc_team.ValueOfIndex("teams", lc_team.Index)
			          + ",v_jobsel=" + sJobsel.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",v_assign_YN=" + v_assign
			          + ",v_custnm=" + sCustNm.value;
				          
				          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(O:DS_CUST=ds_cust)",
			    param);
			tr_post(tr1);
		}
		<%// �׼� �ٿ�� �ο����� ��ȸ : ������ ž�±����� %>
		function fnSelect3() {
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					  + ",v_ride=Y"
                      + ",v_saup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
                      + ",v_direction=" + lc_code1.ValueOfIndex("detail", lc_code1.Index)
                      + ",v_date=" + sDate.Text
                      + ",v_time=" + lc_time.ValueOfIndex("detail", lc_time.Index)
                      + ",v_goods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",v_class=" + lc_class.ValueOfIndex("class", lc_class.Index)
			          + ",v_team=" + lc_team.ValueOfIndex("teams", lc_team.Index)
			          + ",v_jobsel=" + sJobsel.value
			          + ",v_accept_no=" + v_accept_no.Text
			          + ",v_custnm=" + sCustNm.value;
				          
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
			    "JSP(O:DS_CUST=ds_cust)",
			    param);
			tr_post(tr1);
		}



		// �ο����� ����
		function fnApply2() {
            if (ds_cust.IsUpdated){		
	            v_job = "I2";	//���� ������ I2
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                      + ",v_date=" + sDate.Text;
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq210I",
				    "JSP(I:DS_CUST=ds_cust,O:RESULT=ds_result)",
				    param);
				   
				tr_post(tr1);
			} else {
				alert("ž���� ���� �����ϴ�.");
			};
		}	
		
		
		/*
		 *	��� 
		 */
		function fnCancel1() {
			ds_car.undoall();
		} 

		function fnCancel2() {
			ds_cust.undoall();
		} 

		// ���ð�, ��ǰ��ȸ
		function fnSelectDs3() {
			msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	 		if(lc_code1.ValueOfIndex("detail", lc_code1.Index)=="AR"){
	 			//alert(lc_code1.ValueOfIndex("detail", lc_code1.Index));
	 			var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=2"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sArriveDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_ARRIVE_TIME_DS=ds_time,O:S_GOODS_DS=ds_goods)",
			        v_param);		
	 		}else{
			    var v_param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=3"
			                + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                + ",sDepartDate=" + sDate.Text
			    ln_TRSetting(tr1, 
			        "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			        "JSP(O:S_GOODS_DS=ds_goods,O:S_DEPART_TIME_DS_NEW=ds_time)",
			        v_param);		
	 		}

		        
		    tr_post(tr1);
		}

		
		// ��
		function fnClass() {
			ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS6=ds_class)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid"));
        	tr_post(tr3);
		}

		
		// �� 	
		function fnTeam() {
				ln_TRSetting(tr4, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:DS7=ds_team)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,sDepartDate="+sDate.Text+",sSaupSid=1,sUpjang="
	            			+",sGoodsSid="+ ds_goods.namevalue(ds_goods.rowposition,"goods_sid") + ",sClass=" + lc_class.ValueOfIndex("class", lc_class.Index));
	        	tr_post(tr4);
			div='';
		}	

		// ��û�� ��ȣ ��ȸ
	    function fnAcceptNoPopup(){
	        v_cust_row = 0;
	        var arrResult   = new Array();
	        arrResult = fnAcceptNoPop("<%=dirPath%>");
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            getObjectFirst("v_accept_sid").value = arrParam[0];
	            getObjectFirst("v_accept_no").Text   = arrParam[1];
	        }
	    }


		// �� ������ȣ�� �����ϱ� -------------------------------------------------------------------------
		function eraseNO(){
			for (i = 0 ; i <= ds_cust.countrow; i++) {
				if (ds_cust.namevalue(i, "CHOICE")=="T") {
					ds_cust.namevalue(i, "CAR_RSV_SID")=  0;
					ds_cust.namevalue(i, "RIDE_CAR_NUM2")= "";
					ds_cust.namevalue(i, "RIDE_CAR_NM2")	= "";
					ds_cust.namevalue(i, "CAR_NO")	= "";					
				};
			};
		};



	// ����ȣ�� �ڵ�����
	function fnAssign() {
        msgTxt.innerHTML="�ڵ����� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
		//RIDE_CAR_NUM	        
		ds_car.undoall();
		for( k=1; k<=ds_car.CountRow; k++ ) {
			ds_car.namevalue(k,"RIDE_CAR_NUM2") = k;	//���������� �� ���ʴ��~
		}
        msgTxt.innerHTML="�ڵ������� �Ϸ�Ǿ����ϴ�.";		
	}


    function fnExcelDs1() {
        if(ds_cust.CountRow==0){
            alert("�ο� �����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr2").SetExcelTitle(0, "");
        getObjectFirst("gr2").SetExcelTitle(1, "value:����ž��(�԰�); font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr2").GridToExcel("����ž��(�԰�)", "����ž��(�԰�).xls", 8);        
    }
	

		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
//		���� �ʿ��� �޼��� ����� rm310i.jsp ��ĳ���� ������ ������ ��..
		var msg='';
        if(v_job=="I1") {	//���� ���� ����
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//	        fnSelect1();
        }  else if(v_job == "I2") {	// �ο� ���� ����
	        msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
	        fnSelect2();
        }  else if(v_job == "H" || v_job=="S") {
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
        };
	</script>
	<script language=JavaScript for="tr1" event=OnFail()>
		alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>



	<script language=JavaScript for=sDate event=OnKillFocus()>
		if ( div != "init" ) {	//�������� ��Ŀ�� �̵� 
			if ( sDate.Modified ) {
				div = "normal";
				fnSelectDs3();
			}
		}
	</script>
	<script language=JavaScript for= lc_saup event=OnSelChange()>
		if ( div != "init" ) {	//����
			div = "normal";
			fnSelectDs3();
		}
	</script>
	<script language=JavaScript for= lc_code1 event=OnSelChange()>
		if ( div != "init" ) {	//����
			div = "normal";
			fnSelectDs3();
		}
	</script>
	
	
	<script language=JavaScript for=lc_time event=OnSelChange()>
	//alert("�ð����� div="+div);
		if ( div != "init" ) {	//���ð�
			div = "normal";
			fnClass();
		}
	</script>
    <script language=JavaScript for=lc_goods event=OnSelChange()>
    //alert("��ǰ ���� div="+div);
        if ( div != "init" ) {  //��ǰ
            div = "normal";
            fnClass();
        }
    </script>
	<script language=JavaScript for=lc_class event=OnSelChange()>
	//alert("�� ���� div="+div);
		if ( div != "init" ) {	//��
			div = "'normal";
			fnTeam();// �� ȣ��
		}
	</script>


	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		//alert("����ε��, fnSelectDs3 ȣ��");
		fnSelectDs3();
	</script>
	<script language=JavaScript for=ds_time event=OnLoadCompleted(rowcnt)> <!-- �ð� -->
	//alert("ds_time �ε��,  fnClass ȣ��");
		fnClass();
	</script>
	<script language=JavaScript for=ds_class event=OnLoadCompleted(rowcnt)> <!-- �� -->
	//alert("ds_class �ε��,  fnTeam ȣ��");
		fnTeam();
	</script>
	<script language=JavaScript  for=ds_team event="OnLoadCompleted(row)"> <!-- �� -->
	//alert("ds_team �ε��, div�� init�� lc_code1 ����. ���� div="+div);
		if(div="init"){//ó�� �ε��� ���� 1�� �ϰ� 
			lc_code1.Index = 1; // �԰����� ����
		    lc_code1.Enable = false;	//�׸��� ���� ��..
		}
		div="normal";
	</script>	

	<!-- �����׸��� Ŭ���� ���õ� ���� ������ ž����20100319   -->
 	<script language=JavaScript for=gr1 event=OnClick(row,colid)>
 		if(colid=="RIDE_CAR_NUM"||colid=="RIDE_CAR_NM"){
			return;
 		}else{

			for (i = 0 ; i <= ds_cust.countrow; i++) {	//ds_cust(������)���� ���õ� �մ� ã�Ƽ�
				if (ds_cust.namevalue(i, "CHOICE")=="T") {
					ds_cust.namevalue(i, "CAR_RSV_SID") = ds_car.namevalue(row, "CAR_RSV_SID");
					ds_cust.namevalue(i, "RIDE_CAR_NUM2") = ds_car.namevalue(row, "RIDE_CAR_NUM2");
					ds_cust.namevalue(i, "RIDE_CAR_NM2") = ds_car.namevalue(row, "RIDE_CAR_NM2");
					ds_cust.namevalue(i, "CAR_NO")	= ds_car.namevalue(row, "CAR_NO");
				};
			};				
 		};
	</script>


	<script language=javascript for="gr2" event="OnClick(Row, Colid)">
	// ���� ������ ��.. ��ü ���� ������ �̺�Ʈ
        if(Row==0){
            if(ds_cust.CountRow==0) return;

            if(Colid=="CHOICE"){
                for(var i=1; i<=ds_cust.CountRow; i++){
                    ds_cust.NameValue(i, Colid) = ds_cust.NameValue(1, Colid);
                }
            }
		}
	</script>


<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>

<object id=ds_car classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_cust classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_dp_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_ar_time classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_code1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_class classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_team classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_code2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>


<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>




</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table  border='0' cellpadding='0' cellspacing='0' width='1002' >	
		<tr>
			<td align='right'>
				<img src="<%=dirPath%>/Sales/images/auto_assign.gif"  	style="cursor:hand"	align=absmiddle onclick="fnAssign()">
				<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect1()"> 		<!-- ��ȸ -->
				<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply1()"> 		<!-- ���� -->
				<img src="<%=dirPath%>/Sales/images/cancel.gif"  	style="cursor:hand"	align=absmiddle onclick="fnCancel1()"> 		<!-- ��� -->
			</td>
		</tr>
		
		<tr height="5px">
			<td></td>
		</tr>
		
		<tr height="30px">
			<td>
				<table border='0' cellpadding='0' cellspacing='1' width='1002' bgcolor="#666666">
					<tr height='30px'>
						<td width="70px" height="25px" class="text">��û����ȣ</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_accept_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='90px' align='absmiddle' class='textbox'>            
                                <param name=Format      value="00000000000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        <input type="hidden" name='v_accept_sid' id='v_accept_sid'>
                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onClick="fnAcceptNoPopup()" id="v_accept_btn">
                        </td>
						<td align=left class="text" width="50">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=70 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^70">
							</object>
							
						</td>
						<td align=left class="text"  width="50">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;
							
                            <object id=lc_code1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_code1>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							
	                    </TD>						
						<td align=left class="text"  width="60"><b>�԰�</b>����</td>
	                    <td align=left bgcolor="#ffffff" width=150>&nbsp;
							
							<object id=sDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17  width=65 align=center class="textbox">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny  	value="false">																				
							</object>&nbsp;
                            <object id=lc_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_time>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail_nm">
								<param name=EditExprFormat	value="%,%;detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^50"></object>
							
						</td>																							
						<td align=left class="text" width="60">��ǰ(��)</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							
                            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=90 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
                                <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^100">
							</object>
							
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10'>
			<td></td>
		</tr>
		<tr>
			<td align=center>
				
				<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width=1000 height=240 border=1 style="display:;">
                    <param name="DataID"            value="ds_car">
                    <param name="BorderStyle"       value="0">
                    <param name="ColSizing"         value="true">
                    <param name="editable"          value="True">
                    <param name="SuppressOption"    value="1">
                    <param name=SortView  			value="left">
                    <param name="ViewSummary"       value="1">
                    <param name="Format"            value=" 
					<G> name='��������'
						<C> name='��û����ȣ'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX'</C>
						<C> name='��ǰ��'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 </C>
						<C> name='�������'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX' </C>
						<C> name='�ð�'    		ID='DEPART_TIME'	width=75 	align=center	Edit=None suppress=4  editstyle=lookup data='ds_dp_time:detail:detail_nm' </C>
						<C> name='��������'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
						<C> name='�ð�'     	ID='arrive_time' 	width=75 	align=CENTER	Edit=None suppress=6  editstyle=lookup data='ds_ar_time:detail:detail_nm' sumtext='��' sumTextAlign=right </C>
					</G>
					<G> name='�԰�� ��������'
						<C> name='ȣ��' 		ID='RIDE_CAR_NUM2'	Width=50   Edit=true align=CENTER  show=true BgColor='#fefec0' sort=True sumtext=@cnt SumTextAlign=center</C>
						<C> name='��Ī' 		ID='RIDE_CAR_NM2'	Width=70   Edit=true align=CENTER  show=true BgColor='#fefec0' sort=true sumtext='��' sumTextAlign=left</C>
					</G>
                        <C> name='���¾�ü��'   ID='CLIENT_NM'		Width=100  Edit=none align=Left show=false</C>
                        <C> name='�ڵ�'    		ID='CLIENT_CD'		Width=40   Edit=none align=Left show=false</C>
						<C> name='��������ID' 		ID='CAR_RSV_SID'    Width=80   Edit=none align=Left show=false</C>
					<G> name='��������'
						<C> name='�Ҽ�'       	ID='tt_client_nm'   align=left	width=80 	show=true   sort=true </C>
                        <C> name='��Ϲ�ȣ'     ID='CAR_NO'             Width=80   Edit=none align=Left sort=true </C>
                        <C> name='����'             ID='CAR_NM'             Width=80   Edit=none align=Left</C>
                        <C> name='��������'         ID='CAR_TYPE'       Width=70   Edit=none align=center </C>
                        <C> name='��������'         ID='CAR_PERSONS'        Width=60   Edit=none align=CENTER</C>
                        <C> name='����'             ID='CAR_YEAR'           Width=40   Edit=none align=CENTER</C>
                        <C> name='��ⷮ(cc)'       ID='CAR_CC'             Width=80   Edit=none align=Right</C>
                        <C> name='�ִ����緮(kg)'   ID='MAX_KG'             Width=100  Edit=none align=Right</C>
                        <C> name='����1'            ID='CAR_TYPE_CD_NAME'   Width=80   Edit=none align=Left</C>
                        <C> name='�����ȣ'         ID='CAR_DNO'            Width=80   Edit=none align=Left</C>
					</G>
                    ">
				</object>
			</td>
		</tr>
		<tr>
			<td height=24>�� ����ȣ���� ��Ī�� �Է��ϰ� [����]�մϴ�.
			</td>
		</tr>

		<tr>
			<td>
				<table border=0 cellspacing=0 cellpadding=0>
					<tr>
						<td>				
							
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width=790 height=250 border=1 >
								<param name="DataID"        value="ds_cust">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="true">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<Param Name="UsingOneClick"   value="1">
								<param name=IndWidth" value="20">
								<param name="SuppressOption"    value="1">
	                            <param name="ViewSummary"       value="1">
								<param name="Format" 			value="
								  <G> name='��������'

								   	<FC> name='No'           ID='{STRING(CURROW)}'   Width=30    align=center </FC>
									<FC> name='��û����ȣ'   ID='ACCEPT_NO'  	width=95 	align=center editlimit=15 edit=none show=true suppress=1 mask='XXXXX-XXXXXXXXX' </FC>
									<FC> name='��ǰ��'    	ID='GOODS_NM'  		width=55 	align=left editlimit=15 edit=none show=true suppress=2 </FC>
									<C> name='�������'    	ID='DEPART_DATE'    width=65 	align=CENTER	Edit=None suppress=3 mask='XXXX-XX-XX'</C>
									<C> name='�ð�'    		ID='DEPART_TIME'	width=75 	align=center	Edit=None suppress=4  editstyle=lookup data='ds_dp_time:detail:detail_nm' </C>
									<C> name='��������'     ID='arrive_date' 	width=65 	align=CENTER	Edit=None suppress=5 mask='XXXX-XX-XX'</C>
									<C> name='�ð�'     	ID='arrive_time' 	width=75 	align=CENTER	Edit=None suppress=6  editstyle=lookup data='ds_ar_time:detail:detail_nm' </C>
								  </G>
								   	<C> name='����\\��'   	ID='CHOICE'  width=30 	align=center editlimit=16 show=true EditStyle=CheckBox SUMTEXT=�� sumTextAlign=right </C>
									<C> name='����'      	ID='CUST_NM'   		width=50 	align=left editlimit=30  edit=none show=true sort=true SUMTEXT=@CNT sumTextAlign=center </C>
								<G> name='�԰�� ��������'
									<C> name='ȣ��' 		ID='RIDE_CAR_NUM2'	Width=50   Edit=none align=CENTER  show=true sort=true SUMTEXT=�� sumTextAlign=left </C>
									<C> name='��Ī' 		ID='RIDE_CAR_NM2'	Width=70   Edit=none align=CENTER  show=true</C>
									<C> name='����' 		ID='DONGSEUNG2'     width=45   	align=center editlimit=10   editstyle=lookup  data='ds_code2:detail:detail_nm' edit=true show=true  bgColor={IF(DONGSEUNG2='Y','#ffcccc','#fefec0') }  </C>
									<C> name='��Ϲ�ȣ'     ID='CAR_NO'         Width=80   Edit=none align=Left sort=true </C>
								</G>
									<C> name='��������ID'	ID='CAR_RSV_SID'    width=80   	align=center editlimit=10  edit=TRUE show=false</C>
									<C> name='����'   		ID='COMPANY_NM'  	width=80 	align=left editlimit=30  edit=none show=true  sort=True</C>
									<C> name='����'    		ID='POSITIONS'   	width=50 	align=left editlimit=30  edit=none show=true</C>
									<C> name='��'        	ID='CLASS'       	width=40 	align=right editlimit=2 	show=true SORT=TRUE</C>
									<C> name='��'        	ID='TEAMS'      	width=40  	align=right editlimit=2 	show=true SORT=TRUE</C>
									<C> name='�ֹ� /\\����' ID='MANAGE_NO'  	width=75  	align=left editlimit=20  edit=none show=true </C>
								">
							</object>
							
						</td>
						<td width="10">
						<td align=right valign=top width="200">
							<table  border=0 cellpadding='0' cellspacing='1' bgcolor=#666666>
								<tr>
									<td align=left class="text">��/��</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;																										
										
			                            <object id=lc_class classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_class>
											<param name=BindColumn      value="class">
			                                <param name=BindColVal      value="class">
											<param name=EditExprFormat	value="%,%;class,class_nm">
											<param name=ListExprFormat  value="class_nm^0^70"></object>
			                            <object id=lc_team classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=70 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_team>
											<param name=BindColumn      value="teams">
			                                <param name=BindColVal      value="teams">
											<param name=EditExprFormat	value="%,%;teams,teams_nm">
											<param name=ListExprFormat  value="teams_nm^0^70"></object>
									</td>	
								</tr>
								<tr>
					              <td align=left class="text">������</td>
					              <td align="left" bgcolor="#ffffff">&nbsp;
			    					<select name="sJobsel"> 
				    					 <option value="0" SELECTED>��ü</option>
										 <option value="1">������</option>
										 <option value="2">�����</option>
										 <option value="3">���������</option>
									</select>
								  </td>
								</tr>
								<tr>
									<td align=left class="text">�̹���</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;&nbsp;<input type=checkbox name="sAssign_YN" id="sAssign_YN">������<img src="<%=dirPath%>/Sales/images/eraser.gif" style="cursor:hand"	align=absmiddle onclick="eraseNO()"></td>
								</tr>								
								<tr>
						            <td align=center class="text">����</td>
						            <td align="left" bgcolor="#ffffff">&nbsp;
										<input type="text" name=sCustNm id=sCustNm value="" size=15 maxlength="15" class='textbox'>
									</td>
								</tr>								
								<tr height=24>
			                        <td align=center bgcolor="#ffffff" colspan=3><img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect2()"> 		<!-- ��ȸ -->
											<img src="<%=dirPath%>/Sales/images/save.gif"  	style="cursor:hand"	align=absmiddle onclick="fnApply2()"> 		<!-- ��ǰ�� �������� �������� ���� -->
											<img src="<%=dirPath%>/Sales/images/cancel.gif"  	style="cursor:hand"	align=absmiddle onclick="fnCancel2()"> 		<!-- ��� --></td>
								</tr>
								<tr height=24>
			                        <td align=center bgcolor="#ffffff" colspan=3>
			                        	<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:pointer"	align=absmiddle onclick="fnSelect3()"> 		<!-- �׼��� ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->											
									</td>
								</tr>								
							</table>
							<BR>
							<DIV ALIGN=LEFT>
							1.�ϴ�GRID���� �� ���� üũ<BR>
							2.���GRID���� ���� Ŭ��<BR>
							3.�ϴ�GRID���� [����]���� ����<BR>
							4.���� �ϴ� [����] ��ư Ŭ��</DIV>

						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height=24>�� �� ��ȸ �� ������ ���� ���� �� ������ ž�½�ŵ�ϴ�.
			</td>
		</tr>
	</table>


<!--  ���¹� �÷���  -->
<iframe id="LowerFrame" 
	name="work" style="visibility:hidden; position:absolute; left:expression( (document.body.clientWidth - 400 ) / 2); top:expression(( document.body.clientHeight - 146 ) / 2); Z-INDEX: 9;"
	Frameborder="0" src="<%=dirPath%>/Common/include/loadingSales.jsp" 
	width="400px" height="146px"></iframe>



<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

